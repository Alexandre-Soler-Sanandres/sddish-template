---
id: LEGACY-INVENTORY-<APP-SLUG>-001
type: legacy-inventory
status: active
title: "<app-slug> Legacy Inventory"
created: ""              # YYYY-MM-DD
updated: ""              # YYYY-MM-DD
legacy_roots:
  - legacy/imported/<app-slug>
tags: [legacy-discovery, <app-slug>]
---

# `<app-slug>` Legacy Inventory

## Scope

This inventory covers the first discovery baseline for `legacy/imported/<app-slug>`.
The legacy source is evidence for the new monorepo, not authority.

## Identity

(package/service name, runtime baseline, version, stated purpose, entry point — whatever identifies what this app
is and what it is for)

Evidence:

- (paths)

## Major Runtime Areas

(the load-bearing files and directories that define this app's shape: main entry point(s), core config, primary
docs, container/deployment files, CI — enough that a reader knows where to look next)

Evidence:

- (paths)

## App-Specific Sections

Add as many sections here as the app's own structure needs — one per structural concern, evidence-linked, same
depth as `Major Runtime Areas`. Do not force every app into the same set of section names; let the app's actual
shape decide them. Generic examples of the kind of concern that typically becomes its own section: API surface,
persistence/data model, authentication and session handling, external integrations, background/scheduled work,
presentation/UI structure. Name each section after what it actually covers in this app, not after the example list.

## Operations, Tooling, and Quality

(package manager, build/test/lint/type commands, CI pipeline shape, release process, coverage or quality gates)

Evidence:

- (paths)

## Inventory Gaps

(what this pass did not inspect, what is uncertain, what later discovery or an import-hygiene pass still needs to
cover — do not silently omit gaps to make the inventory look complete)
