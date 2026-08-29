# Harness configuration

## Project profile

`harness-data/HARNESS-PROFILE.yaml` is optional project configuration. Its absence means every default below. It
does not contain harness version, lane selection, artifact status, artifact paths, or compatibility state.

```yaml
extensions:
  legacy_discovery: disabled
```

| Key | Type | Legal values | Default | Effect |
| --- | --- | --- | --- | --- |
| `extensions.legacy_discovery` | string | `enabled`, `disabled` | `disabled` | Makes the optional Legacy Discovery extension and its generated entry point available. |

The schema is closed. Unknown keys, duplicate YAML keys, invalid nesting, types, or values are errors. Project
profile values override only their documented default.
