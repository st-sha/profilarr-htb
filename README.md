# HTB database for Profilarr v2

The HTB's Radarr and Sonarr quality profiles and custom formats, as a Profilarr Compliant
Database (PCD 2.0) for Profilarr v2.

Philosophy: use a few profiles that aim for high-quality downloads, and allow lower quality only
when high quality isn't available. Physical media comes first, IMAX and Movies Anywhere get
priority, and the remux profiles avoid special editions where asked.

## Branches

- `v2` (this branch): the Profilarr v2 database. Profilarr v2 links it without a token and pulls
  it. Changes are new files in `ops/`, written in git or exported from the v2 UI with a
  short-lived token (see GUIDE.md).
- `stable`: the v1 YAML database, frozen at `3904008`. Profilarr v1 synced from it until the
  2026-10-18 cutover to v2.

## Where it came from

- Source: branch `stable` at `3904008`, the state live Radarr (7 profiles) and Sonarr (6 profiles)
  matched on 2026-10-18.
- Converter: [rosettarr](https://github.com/Dictionarry-Hub/rosettarr) at `ab96b80`, the tool
  upstream used for its own v2 database.
- Three custom format YAML files (`2160p Bluray`, `Banned Groups`, `Remux Tier 0`) have
  multi-line descriptions that rosettarr's YAML parser rejects. They were normalized with PyYAML
  (the parser v1 uses) before conversion. Their parsed data is identical.
- `2160p Remux Only` scored a custom format named `ATV` that didn't exist. v1 skipped that row,
  and so did the conversion. Op 9 added `ATV`, so every profile now scores it.

## Layout

| Path | What it is |
| --- | --- |
| `pcd.json` | Manifest: name, version and the schema it builds on |
| `ops/` | SQL change files. Profilarr replays them in number order on top of the schema |
| `GUIDE.md` | How v1 and v2 work, and how to maintain this database |

## Ops

| File | Purpose |
| --- | --- |
| `0.rosettarr.sql` | The converted v1 database, unmodified rosettarr output |
| `1.htb-quality-group-member-positions.sql` | Orders the qualities inside each quality group as v1 did. Schema 1.1.0 added the column after rosettarr was written |
| `2.htb-language-any-and-not-original.sql` | Rebuilds v1's `language: must_original`: profile language Any, plus a "Not Original" custom format scored -1 in every profile |
| `3.htb-streaming-services-in-rename.sql` | Turns on "include in rename" for the streaming formats that have it live |
| `4.htb-xvid-regex-from-dictionarry.sql` | Deliberate change, not parity: uses Dictionarry's Xvid regex `\b(Xvid)\b` (chosen 2026-10-18) |
| `5.htb-default-delay-profile.sql` | The "HTB Default" delay profile, matching live: prefer torrent, no delays, no bypass |
| `6.htb-unlimited-max-quality-sizes.sql` | Stores the Arrs' "unlimited" maximum sizes (Radarr 2000, Sonarr 1000) as 0, the way Profilarr v2 does |
| `7.htb-upstream-group-tiers-batch-1.sql` | Deliberate change: Dictionarry's release-group tier and ban updates (batch 1 of the 2026-10-19 review, upstream `fb09c84`). Scores are unchanged |
| `8.htb-framestor-encodes-tier-2.sql` | Deliberate change: FraMeSToR's 1080p and 720p encodes rank at Tier 2, the same as its remuxes (Steven's choice, 2026-10-19) |
| `9.htb-tv-and-safety.sql` | Deliberate change (2026-10-19 review, package 1): four junk guards, CAM for movies (never a Blu-ray), DVD tiers replace the SD tiers, 576p WEB-DL, ATV |
| `10.htb-language-and-dubs.sql` | Deliberate change (package 2): the movie foreign-language guard "Foreign Language Only", Balanced tiers lowered in the Quality profiles, and the new `2160p Quality (English Dub)` profile |
| `11.htb-audio-and-streaming.sql` | Deliberate change (package 3): every lossless codec scores 2,000 on the Quality and Remux profiles, Atmos 400, Dictionarry's streaming values, Bravia Core +7,000 |
| `12.htb-upstream-alignment.sql` | Deliberate change (package 4): Dictionarry's ban structure (no-group releases allowed), 39 pattern updates, upstream's HDR structure, Upscale and Extras cover TV, unscored upstream formats, Remux Only tidy |
| `13.htb-upstream-conditions.sql` | Alignment: Dictionarry's condition changes on 77 formats that still had the old form. Measured with no change in what Radarr or Sonarr pick |

Later files are HTB changes, written in git or exported from the v2 UI.

## Rules

- Never rename a quality profile. Radarr and Sonarr match profiles by name, and every movie,
  series and request default points at those profiles.
- Never edit or delete a published file in `ops/`. Add a new op instead.
- Make changes as new ops, either in git or exported from the v2 UI. See [GUIDE.md](GUIDE.md).
- In `2160p Quality (English Dub)`, bans are -20,000,000, not -999,999, because that profile's
  bonuses reach about 10,500,000. A new ban "in every profile" needs -20,000,000 there.
