#!/usr/bin/env bash
# Publish a staged SeraphIRC desktop release as a GitHub Release on THIS repo.
#
# Why releases: the website used to link this repo's file TREE, and saving a
# .deb from a GitHub blob page yields an HTML file named like a .deb ("Invalid
# archive signature", issue #1). Release assets are always direct binary
# downloads, so the website links .../releases/latest instead.
#
# Usage: scripts/publish-github-release.sh <version>
#   e.g. scripts/publish-github-release.sh 4.0.7-alpha
#
# Reads artifacts from <repo>/{debian,fedora,windows,macos}/<version>/ — stage
# them first: Linux/Windows via the source repo's scripts/package-*.sh; macOS
# via the source repo's macos.yml workflow (signed + notarized .dmg artifact).
# Idempotent: re-running replaces the assets on the existing release.
#
# NOTE: alpha versions are NOT marked --prerelease on purpose. GitHub's
# /releases/latest only resolves non-prerelease releases and 404s if every
# release is a prerelease — which would break the website's download button.
# The "-alpha" in the version string carries that signal instead.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="${1:-}"

if [[ -z "$VERSION" ]]; then
  echo "usage: $(basename "$0") <version>   (e.g. 4.0.7-alpha)" >&2
  exit 2
fi
if [[ "$VERSION" == "." || "$VERSION" == ".." || "$VERSION" == */* ]] ||
   [[ ! "$VERSION" =~ ^[A-Za-z0-9][A-Za-z0-9._+-]*$ ]]; then
  echo "error: invalid version: $VERSION" >&2
  exit 1
fi
if ! command -v gh >/dev/null 2>&1; then
  echo "error: required command not found: gh" >&2
  exit 1
fi

RELEASE_REPO="$(cd "$ROOT_DIR" && gh repo view --json nameWithOwner --jq .nameWithOwner)"
TAG="v${VERSION}"

# GitHub attaches auto-generated "Source code (zip/tar.gz)" links to every
# release, built from the tree the tag points at. There is no way to suppress
# them. Tagging main would make them ~800MB archives of our own installers
# labelled "Source code" — misleading, since no source lives in this repo.
# So we point every tag at an orphan commit holding a single NOTICE.md; the
# links remain (unavoidable) but resolve to a ~1KB archive that says so.
# Release assets attach to the release, not the tag, so downloads are unaffected.
STUB_BRANCH="release-stub"
ensure_stub() {
  if git -C "$ROOT_DIR" rev-parse --verify --quiet "refs/heads/${STUB_BRANCH}" >/dev/null; then
    return
  fi
  if git -C "$ROOT_DIR" ls-remote --exit-code --heads origin "$STUB_BRANCH" >/dev/null 2>&1; then
    git -C "$ROOT_DIR" fetch origin "${STUB_BRANCH}:${STUB_BRANCH}"
    return
  fi
  echo "Creating ${STUB_BRANCH} (one-time)..."
  local tmp blob tree commit
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' RETURN
  cat >"${tmp}/NOTICE.md" <<'NOTICE'
# Not source code

GitHub automatically attaches "Source code (zip)" and "Source code (tar.gz)"
links to every release. They cannot be removed or hidden.

This repository distributes prebuilt SeraphIRC packages only. It contains no
source code, so those archives contain nothing but this notice.

The downloads you want are the release assets listed above this notice on the
release page: the .deb, .rpm, .flatpak, and .dmg files, each with a
.sha256sum.txt companion.
NOTICE
  blob="$(git -C "$ROOT_DIR" hash-object -w "${tmp}/NOTICE.md")"
  tree="$(printf '100644 blob %s\tNOTICE.md\n' "$blob" \
    | git -C "$ROOT_DIR" mktree)"
  commit="$(git -C "$ROOT_DIR" commit-tree "$tree" \
    -m "Release tag anchor: this repo ships packages, not source")"
  git -C "$ROOT_DIR" branch "$STUB_BRANCH" "$commit"
  git -C "$ROOT_DIR" push origin "${STUB_BRANCH}:refs/heads/${STUB_BRANCH}"
}

assets=()
for os in debian fedora flatpak windows macos; do
  dir="${ROOT_DIR}/${os}/${VERSION}"
  if [[ -d "$dir" ]]; then
    while IFS= read -r -d '' f; do assets+=("$f"); done \
      < <(find "$dir" -maxdepth 1 -type f -print0 | sort -z)
  fi
done
if [[ "${#assets[@]}" -eq 0 ]]; then
  echo "error: no artifacts for ${VERSION} under ${ROOT_DIR}/{debian,fedora,flatpak,windows,macos}/${VERSION}/" >&2
  echo "  stage them first: Linux/Windows via the source repo's scripts/package-*.sh," >&2
  echo "  macOS via the source repo's macos.yml workflow (.dmg artifact)" >&2
  exit 1
fi

echo "Publishing ${TAG} to ${RELEASE_REPO} (${#assets[@]} assets):"
printf '  %s\n' "${assets[@]}"

if gh release view "$TAG" --repo "$RELEASE_REPO" >/dev/null 2>&1; then
  echo "Release ${TAG} exists; replacing assets..."
  gh release upload "$TAG" "${assets[@]}" --repo "$RELEASE_REPO" --clobber
else
  notes="SeraphIRC Desktop ${VERSION}.

| Platform | File |
|---|---|
| Debian/Ubuntu | \`seraphirc_${VERSION}_amd64.deb\` |
| Fedora | \`seraphirc-${VERSION}.x86_64.rpm\` |
| Any Linux (Flatpak) | \`SeraphIRC-${VERSION}.flatpak\` — install with \`flatpak install SeraphIRC-${VERSION}.flatpak\` |
| Windows | Microsoft Store |
| macOS (universal) | \`SeraphIRC-${VERSION}-macos-universal.dmg\` |

Every file has a \`.sha256sum.txt\` companion — verify with \`sha256sum -c\`."
  ensure_stub
  gh release create "$TAG" "${assets[@]}" \
    --repo "$RELEASE_REPO" \
    --target "$(git -C "$ROOT_DIR" rev-parse "$STUB_BRANCH")" \
    --title "SeraphIRC ${VERSION}" \
    --notes "$notes"
fi

echo ""
echo "Release: https://github.com/${RELEASE_REPO}/releases/tag/${TAG}"
echo "Latest:  https://github.com/${RELEASE_REPO}/releases/latest"
