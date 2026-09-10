# Stemgarden: install once, study offline

Use the same PWA on Windows, iPhone and iPad. No Node.js, desktop launcher, Apple developer membership, or App Store download is required for the hosted PWA.

1. Open https://stemgarden.aloysiusaltarejos061.chatgpt.site while connected to the internet. Sign in if requested.
2. Windows: use Chrome or Edge, press **Install** in Stemgarden, then **Install Stemgarden** in settings (or the browser's install icon).
3. iPhone / iPad: open the address in Safari, choose **Share → Add to Home Screen**, enable **Open as Web App** if offered, and tap **Add**.
4. Open the installed app while still online. Wait for **Ready for offline study**. Import or restore your study materials inside this installed app.
5. Thereafter, launch from its icon. Local quizzes, images, equation checking and progress work without Wi-Fi or a running computer. Try opening it with Wi-Fi disabled before relying on it away from home.

Internet is needed for initial installation, app updates, and obtaining new AI-generated materials or online images. Download image files and import them; external websites are not made available offline by installing Stemgarden.

Libraries are local to each device/browser installation and do not sync. Before switching from the old localhost app, export a full backup in Settings and restore it in the installed PWA. An installed Apple web app can have separate storage from the Safari tab. Do not delete the old copy until the restored library is verified. Clearing browser/app data or device storage cleanup can remove local files: export backups regularly.

For updates, connect online, reopen the app, then use **Settings → Reload update** when offered. Save your current answer first. Updates preserve your IndexedDB library; do not uninstall the app to update it.

## Source code and optional local launcher

The complete source remains included below. The old local launcher is optional; a phone visiting your computer's HTTP network address cannot install an independently offline PWA. Use the HTTPS address above for that.

For developers: install Node.js 22.13 or newer, run `npm.cmd ci` on Windows (`npm ci` elsewhere), then `npm.cmd run build` and `npm.cmd start`. The production PWA files are in `dist/client`; serve them at the root of an HTTPS origin (localhost also works on that computer). Do not open index.html by double-clicking it. App URLs use hash routes.

## Restricted local launcher

For Windows source users, double-click Start-Stemgarden.cmd; for Mac source users, use Start-Stemgarden.command. Node.js is needed only for this optional developer route. The launcher now binds only to this computer, serves only built web assets, rejects outside paths and symlinks, and checks the request's host and origin. Do not add a firewall exception or enable port forwarding.

The hosted PWA is the preferred route for restricting device access: it runs inside your browser's security boundary. The optional Node launcher is a normal desktop process and does not have the same browser sandbox. It still uses your account's permissions for setup and building source code.

See SECURITY-AND-PERFORMANCE.md for the changes, limits, and verification details. This download can be newer than the published Site; the app's live address only changes after publication.
