# Stemgarden

An offline-first learning workspace for university STEM study. Built from the supplied Technical Requirements Document and extended to support eight practice formats.

**Installable PWA:** see [START-HERE.md](START-HERE.md) for Windows, iPhone and iPad installation and migrating your existing local library. The production build is a client-only static app; it does not require a running PC or application server after its offline files are downloaded. The optional local launcher is retained for source users.

## Workflow

1. Open **Import study pack → Get the AI prompt** and copy the reusable prompt.
2. Give the prompt and your notes/slides/diagrams to your preferred AI.
3. Paste or upload its JSON in the import dialog; inspect the validation preview.
4. Organize decks under subject folders and nested topics. Create, rename, move (including drag and drop), delete recursively, or study an entire folder.
5. Use **Review Q&As** on a folder, class, or deck to read questions, definitions, diagrams, and worked solutions before practice. Nested topics are included; reading does not change quiz scores.
6. Practice with flashcards, multiple choice, identification, enumeration, matching, ordering, multipart problems, or fill in the blanks. Mixed sessions preserve each question's format; flashcard mode works for every question.

The app does not call an AI service or analyze uploaded documents itself. The external AI is responsible for interpreting documents and circuit images, decomposing problems, and supplying verified solutions. Images can be attached to individual questions and are stored with the deck. The original four-field flashcard arrays remain compatible.

## Learning behavior

- 3D flashcards with two progressive hints; Space flips, H/B reveal hints, 1/right or 2/left records a rating after reveal.
- Every practice format supports untimed Normal mode and a configurable Timer mode. Save & leave pauses the clock; expiry retains submitted answers and gives no credit for unanswered questions.
- Sessions save each answer transactionally. Resume unfinished sessions, repeat all questions, or retry only missed questions.
- Numeric STEM answers accept arithmetic, fractions, pi, roots, and trigonometry in radians with per-part relative and absolute tolerances. Values must be entered in the displayed units.
- Symbolic answers use conservative real-valued algebraic equivalence. Unconfirmed expressions, proofs, and unsupported results require explicit self-check against the solution. There is no claim of a full computer algebra or automated proof system.
- Mathematical checking runs in a worker with an allowlisted expression tree and a 5-second limit.
- Short text and enumerations ignore capitalization and accept explicitly supplied alternative names, without fuzzy spelling correction. Enumeration earns partial points per matched item; duplicate answers cannot earn repeated credit. Add accepted alternative names in the question editor.
- Connect Concepts includes Clear All before submission. Put in Order follows mouse/touch dragging with shifting positions, keyboard alternatives, green/red positional feedback, adjacent correct answers, and a complete correct sequence beneath the list.
- Fill in the blanks supports prose, descriptions, math expressions with the math keypad, and code completion. Text accepts defined aliases; code is case-sensitive, preserves internal whitespace, and is never executed. Each blank earns one point. Submitted answers survive reload. Create examples through Add question → Structured JSON → template picker, or Import → Try sample data.
- Folders support recursive deletion, arbitrary hex colors, saved custom swatches, and batch creation of 1–50 folders.
- Light, dark, and system themes include stronger text and panel contrast, responsive layouts, and larger touch controls.
- Review scheduling uses 1, 2, 4, ... up to 60 days after correct responses; misses become ready again after 10 minutes. Immediate retry is always available from the session summary. XP is an engagement aid, not a measure of subject mastery.

## Data and offline access

Dexie/IndexedDB stores the folder tree, cards, shared images, reviews, and session queues on the current device. Nothing is synchronized between devices. **Image library** uploads and reuses images across all eight formats. Duplicate images share storage, while alternate filenames remain usable for imports. Referenced images cannot be deleted until detached from their questions. Existing stored images migrate automatically on database upgrade. The production service worker precaches the app shell, JavaScript, math-worker bundle, equation fonts, icons, and bundled diagrams after a successful online visit. Settings reports offline readiness and offers installation instructions.

To bulk associate images, upload the images first, then import JSON with `imageFile` equal to the exact filename (for example `circuit-001.png`) and a meaningful `imageAlt`. Missing filenames block import with an explanation. You can also choose images manually in the question editor. ZIP import is not implemented. Full backups include the shared image library; deck exports embed only the images used by that deck so the JSON is portable.

**Settings & backups** exports the complete database. Restore validates schema, references, cycles, and session consistency before a single replacement transaction. The current database is downloaded before replacement. Clearing browser data removes the local database; backups remain necessary even if persistent storage is granted.

## Performance

Study screens load on demand. Math checking reuses an isolated worker, equation previews are debounced and cached, and large decks display questions in batches of 40. New diagrams are resized to a maximum 2400-pixel edge when needed and compressed only when beneficial. Equation fonts use WOFF2. Settings shows estimated device storage use; app updates wait for an explicit reload so a lesson is not interrupted.

## Run the complete project

For one-click startup, extract the project and double-click **Start-Stemgarden.cmd** on Windows or **Start-Stemgarden.command** on a Mac. First setup needs Node.js and internet; afterward the launcher reuses its prepared build. It opens your browser and prints addresses for phones/tablets on the same private network. See **START-HERE.md** for instructions and the distinction between local access and cloud hosting.

Install Node.js 22.13 or newer, extract this archive, open a terminal in its folder, and run:

```sh
npm ci
npm run dev
```

Open the localhost address printed by the server. This is a complete source project, not a single HTML file to double-click. Internet access is needed to install dependencies. The production build enables offline caching after an initial visit over HTTPS or localhost.

Your personal decks live in your browser and are not included in the source archive. Export them from **Settings & backups** and restore that backup on another device.

## Updating an existing local installation

1. Export a full backup from your current app before upgrading.
2. Stop the old server with Ctrl+C and extract this project into a new folder.
3. In the extracted project folder run `npm ci`, then `npm run dev`.
4. Open the printed localhost address using the same browser and port as before; that preserves the browser's database and applies its image migration. If using a different browser or address, restore your backup there.

See `docs/Stemgarden-AI-Import-Guide.md` for complete, current AI templates. No cloud service, API key, app-store installation, or additional dependency is needed for these features.

## Development

React 19, TypeScript, Vinext/Vite, Tailwind, shadcn/Radix, Dexie, KaTeX, math.js, and a versioned service worker. The project remains compatible with the Sites Worker build and hosting manifest.

- `npm run build` builds the Worker/client bundles and production offline cache.
- `npm test` runs focused import, grading, folder, backup, and session tests against fake-indexeddb.
- `npx tsc --noEmit` validates the TypeScript source.
- `node scripts/test-offline.mjs` checks the built service worker's precache, offline app-shell fallback, and worker-bundle availability in a mocked service-worker runtime.

No browser end-to-end or device-installation testing is represented by these checks.

## Key source files

- `lib/schema.ts`: backward-compatible import contract and validation.
- `lib/ai-prompt.ts`: the reusable AI handoff prompt.
- `lib/database.ts`: transactional data operations and backup integrity checks.
- `lib/grading.ts`, `lib/math-worker.ts`: answer checking and isolation.
- `components/learning/`: library workspace, authoring, study modes, math input, progress.
- `scripts/build-offline.mjs`: release-specific offline assets and app-shell caching.

The 26 sample questions are illustrative study material. User-imported answer keys should be checked against their course sources.
