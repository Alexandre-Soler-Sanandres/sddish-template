# ARCHITECTURE.md

> **Project-specific.** Fill this in for your project. Agents load this file when validating scope,
> checking allowed paths, or understanding system boundaries during Implementation and Validation modes.

## System Overview

(describe the high-level system architecture in 2-3 sentences)

## Layers and Boundaries

(describe the main layers — e.g. frontend, backend, database, infrastructure — and what belongs in each)

## Key Components

(list and describe the main components or services)

## Technical Artifacts

(declare where project-specific technical specs live — agents use this when resolving `technical_refs` entries in Specs)

Examples:

- API specification: `docs/api/openapi.yaml`
- Database schema: `docs/db/schema.sql`
- Event contracts: `docs/contracts/`

## External Integrations

(list external systems, APIs, or services this project integrates with)

## Deployment

(describe the deployment model — e.g. containers, cloud provider, environments)

## Allowed and Forbidden Paths

(optional — list path conventions agents must respect when planning implementation)
