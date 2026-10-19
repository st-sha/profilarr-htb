# HTB database for Profilarr v2

The HTB's Radarr and Sonarr quality profiles and custom formats, as a Profilarr Compliant
Database (PCD 2.0) for Profilarr v2.

Philosophy: use a few profiles that aim for high-quality downloads, and allow lower quality only
when high quality isn't available. Physical media comes first, IMAX and Movies Anywhere get
priority, and the remux profiles avoid special editions where asked.

## Branches

- `v2` (this branch): the Profilarr v2 database. Profilarr v2 links it and HTB edits it in the v2
  UI, which exports each change as a new file in `ops/`.
- `stable`: the v1 YAML database. Profilarr v1 still syncs from it until cutover.

## Where it came from

- Source: branch `stable` at `3904008`, the state live Radarr (7 profiles) and Sonarr (6 profiles)
  matched on 2026-10-18.
- Converter: [rosettarr](https://github.com/Dictionarry-Hub/rosettarr) at `ab96b80`, the tool
  upstream used for its own v2 database.
- Three custom format YAML files (`2160p Bluray`, `Banned Groups`, `Remux Tier 0`) have
  multi-line descriptions that rosettarr's YAML parser rejects. They were normalized with PyYAML
  (the parser v1 uses) before conversion. Their parsed data is identical.
- `2160p Remux Only` scores a custom format named `ATV` that doesn't exist. v1 skipped that row,
  and so does the conversion.

## Layout

| Path | What it is |
| --- | --- |
| `pcd.json` | Manifest: name, version and the schema it builds on |
| `ops/` | SQL change files. Profilarr replays them in number order on top of the schema |

## Ops

| File | Purpose |
| --- | --- |
| `0.rosettarr.sql` | The converted v1 database, unmodified rosettarr output |
| `1.htb-quality-group-member-positions.sql` | Orders the qualities inside each quality group as v1 did. Schema 1.1.0 added the column after rosettarr was written |
| `2.htb-language-any-and-not-original.sql` | Rebuilds v1's `language: must_original`: profile language Any, plus a "Not Original" custom format scored -1 in every profile |
| `3.htb-streaming-services-in-rename.sql` | Turns on "include in rename" for the streaming formats that have it live |

Later files are changes made in the Profilarr v2 UI and exported here.

## Rules

- Never rename a quality profile. Radarr and Sonarr match profiles by name, and every movie,
  series and request default points at those profiles.
- Never edit or delete a published file in `ops/`. Add a new op instead.
- Make changes in the Profilarr v2 UI and export them.
