# SeraphIRC

**SeraphIRC v3.0.0-alpha**

A modern desktop IRC client built with Go, Wails, and SQLite.

SeraphIRC is designed for people who still care about IRC but want a cleaner, safer, more modern client experience. It focuses on privacy, standards-compliant IRC behavior, secure defaults, persistent local logging, and a polished desktop interface.

> **Alpha notice:** SeraphIRC Alpha is an early public testing release. Core functionality is available, but bugs and rough edges should be expected.

---

## Highlights

* Multi-network IRC client
* Modern desktop UI
* SQLite-backed local chat history
* Secure password storage using the operating system keyring
* SASL and NickServ support
* IRCv3 support, including server-time, account-notify, away-notify, chghost, extended-join, message-tags, echo-message, batch, multi-prefix, invite-notify, and msgid
* Network Manager for active and inactive networks
* Favorites
* Notify List / buddy-list style presence tracking
* WHOIS and User Info views
* Search
* URL launch confirmation
* Separate diagnostics logging
* Numerous theme selection choices
* Tab completion for commands
* Per buffer alert/notification settings
* Hover/click status pill for network and connection health stats
* Quick switcher (Ctrl+K/Cmd+K) for quick window navigation

---

## Installation

### Debian / Ubuntu

Download the `.deb` package from the `/debian` directory in this repository.

Then install it with:

```bash
sudo apt install ./seraphirc_3.0.0-alpha_amd64.deb
```

After installation, launch SeraphIRC from your desktop application menu.

---

### Fedora

Download the `.rpm` package from the `/fedora` directory in this repository.

Then install it with:

```bash
sudo dnf install ./seraphirc-3.0.0-alpha.x86_64.rpm
```

After installation, launch SeraphIRC from your desktop application menu.

---

### Windows portable

Download the portable `.exe` package from the `/windows` directory in this repository.

The portable executable can be run without an installer. As the alpha is unsigned,
you may encounter errors from Smartscreen or other code signing warnings. These
can be safely ignored. Future releases will resolve this.

---

## First Run

On first launch, open the Network Manager and add or enable an IRC network.

You can configure:

* Server hostname and port
* TLS
* Nickname
* SASL authentication
* NickServ fallback
* Autojoin channels
* Logging preferences

Passwords are stored using your operating system’s secure keyring where supported.

---

## Useful Commands

```text
/join #channel
/part
/msg nick message
/query nick
/notice target message
/notify
/notify nick optional comment
/help
/quit
```

`/help` can be used to view available commands, /help `<command>` for more specifics about a given command.

`/notify` opens the Notify List manager. `/notify nick optional comment` toggles a nick on or off the notify list for the active network.

---

## Privacy and Security

SeraphIRC is built with privacy-focused defaults.

* Passwords are not stored in plain text by the app.
* Credentials are handled through OS keyring integration where available.
* Chat logs are local SQLite data.
* Diagnostics logging is separate from chat logging.
* URL launches require confirmation.
* CTCP TIME responses use UTC only.
* Configuration export does not include passwords, chat logs, diagnostics logs, tokens, or keyring secrets.

Security-conscious behavior is intentional. SeraphIRC prefers user control over hidden automation.

---

## Alpha Testing Notes

Please test:

* Adding and connecting to networks
* SASL and NickServ authentication
* Joining channels
* Private messages
* Notices
* Notify List behavior
* Search
* Favorites
* Logging
* URL confirmation
* Import/export of configuration
* Reconnect behavior
* Theme switching
* Desktop notifications and sound preferences

When reporting issues, include:

* Operating system and version
* Package type used
* IRC network
* Steps to reproduce
* Whether the issue occurs consistently
* Relevant diagnostics, if safe to share

Do **not** share passwords, tokens, private messages, or sensitive logs.

---

## Support

For general support questions:

**[team@seraphirc.chat](mailto:team@seraphirc.chat)**

For security disclosures or privacy issues:

**[security@seraphirc.chat](mailto:security@seraphirc.chat)**

---

## Status

SeraphIRC Alpha is focused on stability, packaging, and early external feedback.

Upcoming work may include:

* Beta-focused onboarding
* More import/export polish
* Better diagnostics views
* Additional packaging targets
* Terminal UI exploration
* Continued IRCv3 refinement

---

## License

SeraphIRC is licensed under the **GNU General Public License v3.0**.

You may copy, distribute, and modify this software under the terms of the GPLv3. See the [`LICENSE`](./LICENSE) file for the full license text.

SPDX-License-Identifier: GPL-3.0-only
