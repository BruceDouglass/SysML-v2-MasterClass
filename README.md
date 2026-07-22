# SysML v2 Masterclass Examples

This repository contains the SysML v2 textual notation examples from *SysML v2 Masterclass* by Bruce Powel Douglass. The examples are provided as `.sysml` text files and are organized by book chapter so that each file can be located alongside the corresponding discussion in the book.

## Repository Organization

The repository is arranged by chapter. Each chapter directory contains the example files associated with that chapter of *SysML v2 Masterclass*.

```text
Chapter folders
├── SysML v2 example
├── SysML v2 example
└── ...
```

The examples are intended to accompany the explanations, diagrams, and exercises in the book. They are not a replacement for the book's discussion of the language concepts being demonstrated.

## Importing an Example into CATIA 2026x

The files can be imported into CATIA System of Systems Architect 2026x using its SysML v2 textual notation importer:

1. Clone this repository or download it as a ZIP file and extract it.
2. Open the desired project in CATIA 2026x.
3. Select **File > Import From > SysML v2 Textual Notation**.
4. Navigate to the directory for the applicable book chapter.
5. Select the desired `.sysml` file and complete the import.
6. Review the imported model and any messages reported by the importer.

Some examples may reference definitions, libraries, or companion files used elsewhere in the chapter. If an import reports unresolved references, check the file's import statements and the accompanying discussion in the book.

## Using the Files with Other SysML v2 Tools

Because the examples use the standard SysML v2 textual notation, they may also be usable with other SysML v2 implementations. Compatibility depends on the language version, library support, and implementation status of the tool. Minor changes may therefore be required outside CATIA 2026x.

## Reporting Problems

If an example contains an error or does not import as expected:

1. Confirm that the example is being imported into a compatible SysML v2 environment.
2. Check that any required companion files or libraries are available.
3. Open a GitHub issue identifying the chapter, filename, tool version, and reported error.

Corrections that preserve the intent of the published example are welcome.

## About the Book

*SysML v2 Masterclass* is an in-depth, example-driven guide to modeling with SysML v2. These repository files provide the textual source for the examples presented throughout the book. See https://www.amazon.com/dp/B0GSZHKJWZ 

## Author

Bruce Powel Douglass, Ph.D.

