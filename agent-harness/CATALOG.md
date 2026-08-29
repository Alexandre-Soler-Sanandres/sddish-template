# CATALOG.md

## Purpose

`harness-data/CATALOG.md` is the generated project index. This file only explains its source and rendering
contract; it is not a writable project catalog.

## Contract

The renderer derives the Catalog exclusively from canonical artifact frontmatter and the Questions registry. It
sorts entries by ID and replaces the output atomically. A Catalog contains no project-authored notes, marker
regions, or canonical metadata. Backlinks, ADR consumers, active-work lists, and trace matrices are generated only
as ephemeral query output.

## Loading

Start from an explicitly named artifact. Use the generated project Catalog only when the artifact's stable type
root is unknown. Do not use a Catalog as authority for status, links, approval, or requirements.
