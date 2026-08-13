# SeraphIRC

A modern desktop IRC client built with Go, Wails, and SQLite.

SeraphIRC is designed for people who still care about IRC but want a cleaner, safer, more modern client experience. It focuses on privacy, standards-compliant IRC behavior, secure defaults, persistent local logging, and a polished desktop interface.

---

## Highlights

* Layered windows and tiles
* Modern desktop UI or classic IRC views available
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
* Quick switcher for quick window navigation

---

## Installation

### Debian / Ubuntu

Download the `.deb` package from the `/debian` directory in this repository.

Then install it with:

```bash
sudo apt install ./seraphirc_<version>_amd64.deb
```

After installation, launch SeraphIRC from your desktop application menu.

---

### Fedora

Download the `.rpm` package from the `/fedora` directory in this repository.

Then install it with:

```bash
sudo dnf install ./seraphirc-<version>.x86_64.rpm
```

After installation, launch SeraphIRC from your desktop application menu.

---

### Flatpak

Download the `.flatpak` package from the `/flatpak` directory in this repository.

Then install it with:

```bash
flatpak install --bundle SeraphIRC-<version>.flatpak
```

---

### macOS

Download the .dmg file and click/drag to install as normal.

---

## First Run

On first launch, you will encounter the setup wizard. From here, choose whether to import bouncer configuration or connect to a direct IRC network.

---

## Useful Commands


`/help` can be used to view available commands, /help `<command>` for more specifics about a given command.


You can see the full list here:
https://www.seraphirc.chat/#commands

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
* Peer-to-peer chat and file transfer wrapped in TLS 1.3 using Seraph Chat/Transfer (SeraphIRC users only)

Security-conscious behavior is intentional. SeraphIRC prefers user control over hidden automation.

---

## Support

For general support questions:

**[support@seraphirc.chat](mailto:support@seraphirc.chat)**

For security disclosures or privacy issues:

**[security@seraphirc.chat](mailto:security@seraphirc.chat)**
