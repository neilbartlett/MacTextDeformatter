# 🧰 MacTextDeformatter

A lightweight macOS menu bar utility that transforms clipboard contents into formats you can actually use. Designed for speed, simplicity, and power-user workflows.

---

## ✨ Features

✔️ **Remove Rich Text Formatting**  
Strips styles, fonts, and formatting from text copied into the clipboard.  
Useful when `⌘⇧V` fails or isn't available.

📊 **CSV → TSV**  
Converts comma-separated values into tab-separated values for **flawless pasting into Excel, Numbers, or Google Sheets**.

🧾 **JSON → TSV**  
Takes a JSON object or array of objects and flattens it into TSV — perfect for data inspection and spreadsheet import.

🔁 **JSON → TSV (Transposed)**  
Rotates the structure: keys become row labels, and values align across columns.

🧠 **Clipboard-first design**  
All operations read from and write to the macOS system clipboard. Just copy → run → paste.

---

## 🚀 Getting Started

You’ll need:

- macOS with [Xcode](https://apps.apple.com/us/app/xcode/id497799835) installed
- No developer account required

### 🔨 Build and Install

From the project root:

```bash
make
```
This will:
	1.	Build the app in Release mode
	2.	Archive and extract it
	3.	Install it to /Applications

📌 If xcodebuild errors with a message about command-line tools, run:

```bash
make xcode-full
make
```

to switch back to cmdline use

```bash
make xcode-cli
```

## License

This project is licensed under the MIT License.
