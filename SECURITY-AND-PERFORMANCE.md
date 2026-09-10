# Stemgarden: performance and access boundaries

The installed PWA is the recommended version for everyday use. It runs inside the browser's security boundary and needs no Node.js server, administrator permission, shared folder, or inbound network port on your device.

## What it can access

- The particular JSON and image files you select in its file picker. It reads an imported copy; it does not get continuing access to your Documents folder, scan your disk, or modify your original files.
- Its own browser-managed database and offline cache. Subject folders inside Stemgarden are database records, not Windows or Apple filesystem folders.
- Downloads you initiate, such as exported backups. The browser handles their destination.
- Same-origin app resources for initial installation and updates. Your imported study content is not uploaded by the app. The hosting provider still handles ordinary website requests and sign-in when you visit online.

No camera, microphone, location, remote-control feature, telemetry, cloud synchronization, or background file watcher is implemented. The local launcher additionally sends permission-denial headers; the portable build includes these headers for hosts that support the `_headers` format. A host that ignores that file does not enforce its extra headers.

The built HTML enforces a Content Security Policy allowing only local scripts, workers, fonts, styles and connections, plus local/embedded images. Inline scripts, dynamic code execution, embedded pages and form submission are blocked. Inline styles remain allowed for equation rendering and interface positioning. The math worker is local, restricts accepted expressions, and is terminated if checking exceeds five seconds. Imported code is study text and is never executed. KaTeX's trusted commands stay disabled. Image imports check file signatures and apply size limits.

## Hardware and storage improvements

- Equation rendering code loads only when needed, reducing initial JavaScript from about 959 KB to about 699 KB uncompressed (approximately 27%). The whole offline install still includes that code so equations work without internet.
- Closed answer panels no longer read their diagrams or render their answers. Opening a panel loads them; closing it releases that component's references.
- Review lookups use an index in memory rather than scanning the review list once per question. Current-folder question lists are reused across unrelated renders.
- Repeated equation previews reuse cached results; typing is debounced before asking the math worker. Idle workers already shut down after 30 seconds.
- Image decoding uses temporary object URLs, avoiding an additional full-size base64 copy during decoding. Object URLs and drawing surfaces are released afterward. Resized images remain resized even if the original compressed file is smaller. This affects new imports; existing images are preserved.
- Image-library usage counts no longer retain a duplicate array of complete question records. Images request asynchronous decoding.

These changes reduce avoidable work. The initial-bundle measurement is not a measurement of RAM, battery life or CPU savings on your device. Overall installed size is roughly unchanged; retaining full offline functionality takes priority over minor storage savings. Large imports still require memory, and animated GIFs can consume more processing power than static diagrams.

## Optional launcher

The source-code launcher now listens only on `127.0.0.1`, rejects unexpected hosts and cross-origin requests, serves only built web-file types within its output directory, and refuses symlinks that lead outside that directory. No firewall exception is needed. It no longer provides phone/tablet access through your computer's LAN address.

A Node.js launcher is an ordinary desktop process with your account's permissions, not an OS-level sandbox. Use the installed PWA if avoiding that broader access is your priority. Neither version protects an already compromised operating system or browser.

## Verification and remaining limits

Checks cover grading, imports, backup compatibility, malicious equation commands, image signatures, launcher host/origin restrictions, path traversal, symlink escape, and offline caching. Physical-device resource usage and a full external penetration test have not been performed. No application can honestly be guaranteed invulnerable.

Keep your browser updated. Do not import files from sources you do not trust. Local decks and exported backups are not application-encrypted: someone using your unlocked device/browser profile can access them. Use your device lock and keep private backups in a protected location. Clearing browser data can delete your library.

File-picker boundary: https://developer.mozilla.org/en-US/docs/Web/API/File_API

Content Security Policy: https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy
