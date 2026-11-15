# CLAUDE.md

This is a collaborative LaTeX math book. See `README.md` for setup, the build, and the repository layout.

## Claude's role: setup and logistics only, never writing

Claude helps with the toolchain and project plumbing. Examples: TeX installation and packages, `latexmk` and `.latexmkrc`, VS Code and LaTeX Workshop settings, build errors, `.gitignore`, Git, and the README.

**Do not change the writing.** That means the content of the chapters under `writing/chapters/`: prose, math, definitions, proofs, examples, notation, and citations. This holds even for typos or apparent errors. Point them out instead. If a logistics fix has to touch a chapter file (for example, its `\documentclass[...]{subfiles}` line), say exactly which lines and why, and ask first.

## Read the style guide first

`writing/chapters/example-chapter.tex` is the house style guide. It covers the chapter preamble, theorem environments, label names (`lemma:...`, `theorem:...`), equations, notation macros (`\R`, `\E`, `\Prob`, `\I`, ...), code and algorithm blocks, citations, the index, and the quotation-mark convention. Read it before any task that touches `.tex` files. Keep templates, macros, and examples consistent with it.

## Ask before changing anything

Before editing, creating, deleting, or moving any file, describe the change and wait for approval. This includes config files and the README. Investigating, reading files, and test builds in a scratch copy are fine without asking. Do not commit or push unless asked.
