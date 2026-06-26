# ARCHITECTURE.md

> **Project-specific.** Fill this in for your project. Agents load this file when validating scope,
> checking allowed paths, or understanding system boundaries during Implementation and Validation modes.

## System Overview

_(describe the high-level system architecture in 2-3 sentences)_

## Layers and Boundaries

_(describe the main layers — e.g. frontend, backend, database, infrastructure — and what belongs in each)_

## Key Components

_(list and describe the main components or services)_

## Technical Artifacts

_(declare where project-specific technical specs live — agents use this when resolving `technical_refs` entries in Specs)_

Examples:
- API specification: `docs/api/openapi.yaml`
- Database schema: `docs/db/schema.sql`
- Event contracts: `docs/contracts/`

## External Integrations

_(list external systems, APIs, or services this project integrates with)_

## Deployment

_(describe the deployment model — e.g. containers, cloud provider, environments)_

## Allowed and Forbidden Paths

_(optional — list path conventions agents must respect when planning implementation)_
