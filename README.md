# Mathematics

A collaborative LaTeX book by Scott Hwang, Adi Mittal, and Griffin Teller.

## Repository layout

```text
main.tex                 # launcher for the whole book (leave alone)
references.bib           # shared bibliography
.latexmkrc               # shared build settings
writing/
    book.tex             # preamble, macros, theorem environments, chapter order
    chapters/
        <part>-chapters/<topic>-chapter.tex
```

Git does not track the compiled PDF. You build it on your own computer (step 5).

---

# Working on the book locally

This guide sets up a Mac so you can edit the book, compile a PDF, and collaborate through GitHub. You only need to do the installation steps once.

We use **BasicTeX** to keep the installation smaller, **VS Code** to edit and preview the book, and **GitHub Desktop** to share changes.

## 1. Install BasicTeX

1. Go to the [BasicTeX download page](https://tug.org/mactex/morepackages.html).
2. Download BasicTeX and run the installer. You do not need the full MacTeX download.
3. When installation finishes, quit and reopen Terminal. If VS Code is already running, quit and reopen it too.

Open Terminal and run:

```bash
pdflatex --version
```

You should see version information, including a TeX Live release year. If you see “command not found,” try restarting your Mac before continuing.

## 2. Install the book’s extra packages

BasicTeX provides the foundation. Our book also needs packages for math, bibliographies, code examples, and other features.

Copy this command into Terminal and press Return:

```bash
sudo tlmgr update --self --all
```

This updates your new installation. Your Mac may ask for your login password. Nothing appears while you type it; that is normal. Type it and press Return.

When the update finishes, run:

```bash
sudo tlmgr install latexmk biblatex biber subfiles import \
  mathtools amsfonts amsmath amscls minted \
  algorithms algorithmicx imakeidx blindtext hyperref \
  graphics tools xcolor
```

Copy the whole block together. The backslashes let one command continue across several lines.

The package list is based on the book’s current source. If we add new features later, we may need to add packages here too.

## 3. Install your editor

1. Download and install [Visual Studio Code](https://code.visualstudio.com/).
2. Open VS Code.
3. Click **Extensions** in the left sidebar.
4. Search for **LaTeX Workshop**, by James Yu, and install it.

LaTeX Workshop adds PDF previews and LaTeX editing support. BasicTeX supplies the actual compiler.

## 4. Get the project folder

1. Install [GitHub Desktop](https://desktop.github.com/) and sign in.
2. Open the book’s repository on GitHub. Accept your collaborator invitation first if needed.
3. Click **Code → Open with GitHub Desktop**.
4. Choose where to save the project and click **Clone**.

Cloning creates your own local working copy. Edit that copy rather than a separate download from Overleaf.

## 5. Open the book and build a PDF

In VS Code, choose **File → Open Folder** and select the project folder.

You should see a structure like this:

```text
math-book/
    main.tex
    references.bib
    writing/
        book.tex
        chapters/
            ...
```

Choose **Terminal → New Terminal**. The terminal should open in your project folder. Run:

```bash
latexmk
```

This builds the complete book. It runs LaTeX as many times as needed and runs Biber for references. The build options live in the repository's `.latexmkrc`, so everyone builds the same way. One option, shell-escape, lets the code-highlighting and index helpers run. Saving a `.tex` file in VS Code with LaTeX Workshop uses the same settings.

When the build succeeds, you should have **`main.pdf`** next to `main.tex`. Open it to check the result. In LaTeX Workshop, you can also use the command **View LaTeX PDF file** from the Command Palette.

For the first check, confirm that:

- The table of contents appears and its links work.
- The example chapter’s Python code is formatted.
- The example citation has a matching reference entry.
- The index contains the example index entry.

Chapters without citations will not display a References section. That is expected.

## 6. Know which files to edit

| File | What belongs there |
| --- | --- |
| `main.tex` | The small launcher for the complete book. Usually leave it alone. |
| `.latexmkrc` | Shared build options. Change only by team agreement. |
| `writing/book.tex` | Shared packages, formatting, part headings, chapter titles, and chapter order. |
| Files under `writing/chapters/` | The actual chapter text, sections, equations, and chapter bibliography command. |
| `references.bib` | The shared database of citation entries. |

Keep each chapter’s `subfiles` wrapper. It lets the chapter reuse the shared preamble and compile separately.

Start by getting the **whole-book build** working. Individual chapter builds may need additional bibliography-path configuration; they are not the acceptance test for the complete book.

## 7. Keep collaborators’ setups compatible

Everyone should use the **same TeX Live release year** and the same whole-book build command above. Mac collaborators can use BasicTeX or full MacTeX. Windows and Linux collaborators can use TeX Live.

```text
Team TeX Live release: 2026
```

To check yours, run `pdflatex --version`.

Package updates within a release year can still differ. Once the project builds reliably, coordinate future toolchain upgrades instead of upgrading independently. Run the update command above during initial setup; you do not need to run it every time you work on the book.

Keep this README in the repository so everyone has the same package list and instructions. If someone adds a new package to `book.tex`, they should update these instructions in the same change.

GitHub stores our source and setup instructions. It does not automatically install BasicTeX or packages on collaborators’ computers.

## 8. Share your work

Use this routine:

1. Fetch and pull the latest changes in GitHub Desktop before starting.
2. Create a branch for your change.
3. Edit your chapter in VS Code.
4. Build the whole book and check the PDF.
5. Review the changed files in GitHub Desktop, write a short commit message, and commit.
6. Push your branch and open a pull request.

Commit source files, references, figures, and shared configuration. The `.gitignore` already keeps build files and `main.pdf` out of Git. If GitHub Desktop lists `.aux`, `.log`, or PDF files as changes, don't commit them.

### Avoiding merge conflicts

- **Mostly edit your own chapters.** Most conflicts come from two people editing the same chapter at the same time.
- **Coordinate changes to shared files.** `writing/book.tex` (macros, packages, chapter order) and `references.bib` affect everyone. Keep those changes small and merge them quickly.
- **Where practical, put one sentence per line** in `.tex` files. Git compares files line by line, so short lines make changes easier to review and conflicts rarer.
- **Pull often and keep branches short-lived.**

### Figures

Put images in `writing/images/`. Prefer PDF or PNG, and keep files reasonably small.

## If something goes wrong

### “latexmk: command not found” or “biber: command not found”

Quit and reopen Terminal and VS Code. If the command is still missing, run:

```bash
sudo tlmgr install latexmk biber
```

### A `.sty` file is missing

The build needs another package. Read the missing filename in the error message. To find which package supplies it, replace `missing.sty` below with that filename:

```bash
tlmgr search --global --file /missing.sty
```

Then install the package named in the result:

```bash
sudo tlmgr install PACKAGE_NAME
```

Replace `PACKAGE_NAME` with the actual package name. Add it to the installation list in this README for the next collaborator.

### Citations show question marks

Make sure `biber --version` works, then rebuild the whole book with the command in step 5. Read any Biber error messages in the terminal. Do not assume a successful individual chapter build means the full book’s bibliography has been processed.

### The build complains about `minted` or `latexminted`

Check that the code-highlighting helper is available:

```bash
latexminted --version
```

If it is missing, run `sudo tlmgr install minted`, then restart Terminal. Current TeX Live installations provide the helper through the TeX package installation. If it still fails, keep the exact error message so we can diagnose it.

### The table of contents or references seem stale

From the project folder, run:

```bash
latexmk -C
latexmk
```

The first command deletes generated build files, including the generated PDF. It leaves the source files in place. The second rebuilds the book.

### TeX Live says the local version is older than the repository

Your installed TeX Live release and the online package repository do not match. Check the team’s agreed release year before upgrading. Do not change release years just to silence the message.

## Official documentation

- [BasicTeX and adding packages](https://tug.org/mactex/morepackages.html)
- [LaTeX Workshop installation](https://github.com/James-Yu/LaTeX-Workshop/wiki/Install)
- [The minted package manual](https://www.tug.org/docs/latex/minted/minted.pdf)
- [GitHub Desktop documentation](https://docs.github.com/en/desktop)
