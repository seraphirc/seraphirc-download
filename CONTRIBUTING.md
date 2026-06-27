# Contributing to SeraphIRC

Thanks for your interest in contributing to SeraphIRC.

SeraphIRC is a modern desktop IRC client built with Go, Wails, and SQLite. The project focuses on privacy, standards-compliant IRC behavior, secure defaults, and a polished desktop experience.

This document explains how to report issues, suggest features, submit changes, and work safely with the codebase.

---

## Project Status

SeraphIRC is currently in alpha.

That means:

* Core functionality is usable.
* Packaging and cross-platform testing are active.
* Bugs and regressions are expected.
* Stability, privacy, and user experience polish are high priorities.
* Large feature additions should be discussed before implementation.

Please keep alpha quality in mind when filing issues or opening pull requests.

---

## Ways to Contribute

Helpful contributions include:

* Bug reports
* Reproduction steps
* Packaging tests on Linux distributions
* UI/UX feedback
* IRC network compatibility testing
* Documentation improvements
* Small focused bug fixes
* Security/privacy review
* Accessibility feedback
* Theme polish
* Regression tests

If you are planning a larger feature, please open an issue or discussion first.

---

## Security and Privacy Issues

Please do **not** report security vulnerabilities or privacy issues in public GitHub issues.

For security disclosures or privacy concerns, contact:

**[security@seraphirc.chat](mailto:security@seraphirc.chat)**

Examples of sensitive issues include:

* Credential exposure
* Password/keyring storage bugs
* Private message leakage
* Log privacy issues
* Unsafe URL handling
* Unsafe file handling
* Authentication bypasses
* Sensitive diagnostics output

General support questions can go to:

**[team@seraphirc.chat](mailto:team@seraphirc.chat)**

---

## Reporting Bugs

When reporting a bug, please include:

* SeraphIRC version
* Operating system and version
* Package type used, if applicable

  * `.deb`
  * `.rpm`
  * source build
  * Windows executable
* IRC network
* Steps to reproduce
* Expected behavior
* Actual behavior
* Screenshots, if useful
* Relevant diagnostics, if safe to share

Please do **not** include:

* Passwords
* SASL secrets
* NickServ passwords
* Private message contents
* Sensitive logs
* Tokens
* Private keys

A good bug report looks like:

```text
Version: 1.0.2-alpha
OS: Ubuntu 24.04
Package: .deb
Network: Libera.Chat

Steps:
1. Connect to Libera.Chat.
2. Join #example.
3. Right-click channel > View Ban List.

Expected:
Ban list opens.

Actual:
Client closes immediately.
```

---

## Suggesting Features

Feature ideas are welcome, but SeraphIRC prioritizes:

1. Reliability
2. Privacy and security
3. Standards-compliant IRC behavior
4. Daily-driver usability
5. Clear, consistent UX
6. Maintainability

Features that add significant complexity should be discussed first.

Examples of features that need discussion before implementation:

* DCC
* Ident server
* Plugin or scripting systems
* Mobile sync
* New storage formats
* Major UI rewrites
* Protocol behavior changes
* Cross-device sync
* Anything involving credentials or private logs

---

## Development Principles

Please keep these principles in mind when contributing.

### Privacy-first

SeraphIRC should not expose credentials, private messages, logs, or sensitive user data unnecessarily.

Do not log:

* Passwords
* SASL secrets
* NickServ passwords
* Tokens
* Keyring values
* Private message contents unless explicitly part of chat logging
* Full exported configuration contents

### Secure defaults

Prefer safe behavior by default.

Examples:

* Confirm URL launches.
* Store passwords using OS keyring integration.
* Do not fall back to plaintext credential storage.
* Do not auto-accept risky actions.
* Do not silently expose local files or logs.

### Standards-compliant IRC behavior

SeraphIRC should respect IRC protocol expectations and IRCv3 behavior.

Avoid client behavior that creates loops, sends malformed commands, or violates common IRC semantics.

### Source behavior is truth

When updating UI or documentation, verify actual source behavior.

Do not document commands, settings, or protocol support that are not actually implemented.

### Avoid visual clutter

SeraphIRC favors a polished, consistent UI over feature noise.

When adding UI:

* Prefer consistency over novelty.
* Avoid unnecessary badges and icons.
* Keep status and connection state clear.
* Use theme tokens.
* Check light and dark theme behavior.
* Test custom themes where practical.

---

## Local Development

SeraphIRC uses Go, Wails, a frontend stack, and SQLite.

Exact setup may change over time, so check the project README and scripts first.

Typical development workflow:

```bash
git clone https://github.com/<owner>/<repo>.git
cd <repo>
go mod download
```

If using Wails:

```bash
wails dev
```

To build:

```bash
wails build
```

If the repository has project-specific scripts, prefer those over manual commands.

---

## Running Tests

Before submitting a pull request, run the relevant tests.

Common commands may include:

```bash
go test ./...
```

If working on state/concurrency-sensitive code, also run:

```bash
go test -race ./...
```

If frontend tests are present, run the project’s frontend test command.

Please mention in the pull request what testing you performed.

---

## Code Style

### Go

* Use `gofmt`.
* Prefer small focused functions.
* Avoid unnecessary global state.
* Keep IRC protocol logic separate from UI logic.
* Avoid data races in shared state.
* Return structured errors instead of panicking from user-facing paths.
* Do not expose internal mutable maps/slices directly.

### Frontend

* Use existing components and theme tokens where possible.
* Avoid hardcoded colors.
* Avoid one-off styling that only works in one theme.
* Keep dialogs and context menus consistent.
* Test narrow window behavior.
* Preserve keyboard navigation.

### SQLite and Storage

* Keep transactions short.
* Close rows promptly.
* Do not block UI on long database operations.
* Do not store secrets in SQLite.
* Do not mix diagnostics logs with chat logs.
* Treat chat logs as user data.

---

## Pull Request Guidelines

Pull requests should be focused.

A good PR should:

* Solve one problem or implement one coherent feature.
* Include a clear summary.
* Include screenshots for UI changes.
* Mention tested platforms.
* Mention any known limitations.
* Avoid unrelated formatting churn.
* Avoid large drive-by refactors.

Please include:

```text
Summary:
- What changed?

Testing:
- What did you test?

Screenshots:
- If UI changed.

Notes:
- Anything reviewers should know.
```

---

## Commit Messages

Use clear commit messages.

Examples:

```text
Fix ban list permission handling for non-ops
Add per-buffer scrollback setting
Improve command autocomplete keyboard navigation
Update Solarized Light dialog control tokens
```

Avoid vague messages such as:

```text
fix stuff
changes
update
```

---

## UI Changes

For UI changes, please check:

* Dark theme
* Light theme
* At least one custom theme
* Narrow window behavior
* Keyboard navigation
* Context menus
* Dialog spacing
* Readability
* Tooltip text
* No unnecessary visual clutter

If your change affects chat rendering, test:

* Normal messages
* Notices
* Joins
* Parts
* Quits
* Server/status messages
* Query/private messages
* Long messages
* Long URLs
* Long nicknames

---

## IRC Behavior Changes

Changes to IRC behavior should be conservative.

When modifying command or protocol handling, test where relevant:

* Libera.Chat
* OFTC
* DALnet
* Another network if available

Be careful with:

* `NOTICE`
* CTCP
* SASL
* NickServ fallback
* IRCv3 capability negotiation
* MONITOR/ISON notify behavior
* reconnect behavior
* channel forwarding numerics
* operator-only actions

---

## Packaging Changes

If changing packaging, test install and launch where possible.

Supported alpha packaging targets include:

* Debian/Ubuntu `.deb`
* Fedora `.rpm`

Packaging should not include:

* User logs
* SQLite chat databases
* Diagnostics logs
* Credentials
* Keyring data
* Local development artifacts
* Test network data

---

## Documentation Changes

Documentation should be accurate and current.

Please update documentation when changing:

* Commands
* Settings
* Install steps
* Packaging paths
* Security behavior
* Import/export behavior
* Known limitations
* IRCv3 support
* Build instructions

---

## Known Limitations

Some features may not be implemented yet.

Examples may include:

* DCC
* Ident server
* Mobile companion mode
* Plugin/scripting support

Please do not submit large implementations for these areas without discussion first.

---

## License

By contributing to SeraphIRC, you agree that your contributions will be licensed under the project’s license.

SeraphIRC is licensed under the **GNU General Public License v3.0**.

See [`LICENSE`](./LICENSE) for the full license text.

SPDX-License-Identifier: GPL-3.0-only
