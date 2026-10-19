# Maintaining the HTB database in Profilarr v2

A guide for someone who knows Profilarr v1 well and hasn't used v2 yet. It explains how each
version works, maps v1 ideas to v2, and gives step-by-step routines for keeping this database
up to date.

Each routine has a status:

- **Verified on 2.2.0**: done for real against this database in Profilarr v2.2.0.
- **From the 2.2.0 source**: written from Profilarr's code and docs, not yet clicked through.

Paths like `/databases/<id>/changes` are pages in the v2 web UI (port 6869 on the server).

## 1. How each version works

### v1

- The database is a folder of YAML files in git: `regex_patterns/`, `custom_formats/`,
  `profiles/` and `media_management/`.
- v1 clones the repo into its `db/` folder. You edit files (by hand or in the v1 UI), commit and
  push to `stable`.
- Pressing Pull in v1 does two things at once: it pulls the repo, and it pushes the profiles and
  custom formats to Radarr and Sonarr.
- HTB changes were marked with `CUSTOM:` comments. Upstream changes came in as git merges.
- v1 never managed naming, quality definitions or delay profiles.

### v2

- The database is a list of SQL change files ("ops") in `ops/`, numbered `0`, `1`, `2` and so
  on. Nothing in git looks like a profile any more. A profile is whatever the ops add up to.
- Every op runs on top of a shared schema
  ([Dictionarry-Hub/schema](https://github.com/Dictionarry-Hub/schema), version pinned in
  `pcd.json`). The schema defines the tables and seeds the qualities and languages.
- v2 replays all ops, in number order, into an in-memory database (the "cache"). The UI reads and
  edits that cache.
- When you edit something in the UI, v2 writes a new op. For a database you maintain, that op is a
  **draft**. Drafts apply to the cache straight away, but nothing reaches git until you export them.
- **Export** (on the database's Changes page) bundles the drafts you select into one new file,
  `ops/<next number>.<your message>.sql`. It commits that file with your git author name and
  pushes it to the `v2` branch, using the token saved on the database.
- Pulling the database and syncing an Arr are separate actions:
  - Pulling (Updates or Changes page) fetches new commits from GitHub and rebuilds the cache.
  - Syncing is set up per Arr instance on `/arr/<id>/sync`. You choose which profiles, naming,
    media settings, quality definitions and delay profile that Arr gets. Each section has a
    trigger: Manual, On Pull or Schedule.
- **Drift** (`/arr/<id>/drift`) compares what v2 would sync with what the Arr has now. It never
  writes to the Arr.

## 2. Concept map

| v1 | v2 |
| --- | --- |
| `regex_patterns/*.yml` | Regular Expressions |
| `custom_formats/*.yml` | Custom Formats, each with conditions |
| `profiles/*.yml` | Quality Profiles: General, Qualities and Scoring tabs |
| Quality group with a negative id | A group inside the profile's Qualities tab. Groups belong to one profile |
| `custom_formats_radarr` / `custom_formats_sonarr` | A score row with arr type Radarr or Sonarr instead of All |
| `language: must_original` | Profile language Any, plus the "Not Original" custom format scored -1 in every profile (op 2) |
| `media_management/naming.yml` | Media Management, Naming config `default` (Radarr and Sonarr) |
| `media_management/misc.yml` | Media Management, Media Settings config `default` |
| `media_management/quality_definitions.yml` | Media Management, Quality Definitions config `default` |
| (not managed) | Delay Profiles: `HTB Default` |
| Custom format tests in YAML | Not converted. v2 has its own Testing tab on each custom format |
| `CUSTOM:` comments | The op file name and the commit message |
| Edit YAML, push, Pull in v1 | Edit in the v2 UI, Export, then Sync (after cutover) |
| `git merge upstream/stable` | Read upstream's new ops and copy the changes you want (routine 4.5) |

## 3. Layers, and why HTB edits go to "base"

Every compile replays four layers in order:

1. **Schema**: the shared tables and seed data.
2. **Base**: the ops in this repo, then any drafts not yet exported.
3. **Tweaks**: optional SQL files in the repo's `tweaks/` folder (unused here).
4. **User**: local changes kept only inside that v2 install.

For Dictionarry and TRaSH, which HTB only reads, any edit becomes a user op. For the HTB database
it's different: it is linked with a GitHub token and **Local ops off**, so v2 treats you as its
developer. Every edit becomes a base draft and can be exported.

Never turn on Local ops for HTB. Edits would then stay inside v2 and never reach git.

## 4. Routines

### 4.1 Change a score

Status: from the 2.2.0 source.

1. Quality Profiles, then the HTB database, then the profile, then **Scoring**.
2. Change the score and save. The change is now a draft.
3. If the score should differ between Radarr and Sonarr, set the row's arr type rather than
   making two profiles.
4. Export it (4.6).

### 4.2 Add or move a release group in a tier

Status: from the 2.2.0 source.

Release group tiers are custom formats (for example `Remux Tier 1`), with one condition per group
that points at a regular expression.

1. If the group has no regular expression yet: Regular Expressions, then HTB, then New. Name it
   after the group and set the pattern (copy upstream's when it exists).
2. Custom Formats, then HTB, then the tier format, then **Conditions**. Add a Release Group
   condition that uses the new regular expression, not required, not negated.
3. To move a group, delete its condition from the old tier and add it to the new one in the same
   session, so both land in one export.
4. Export it.

### 4.3 Add a custom format

Status: from the 2.2.0 source.

1. Custom Formats, then HTB, then New. Give it a name, a description and tags.
2. Add conditions on the Conditions tab. Optionally add test releases on the Testing tab.
3. Score it in each profile that should use it (4.1). A format no profile scores is never synced.
4. Export it.

### 4.4 Create or change a profile

Status: from the 2.2.0 source.

- **Never rename an existing profile.** Radarr and Sonarr match profiles by name. A rename creates
  a new profile and leaves every movie, series and request default on the old one.
- The Qualities tab sets order, groups, allowed qualities and the "upgrade until" quality. Top to
  bottom is highest to lowest priority. Qualities inside one group rank equally. v2 sends a
  group's members to the Arr in reverse of the order shown, which is how the converted groups
  match live.
- To add a profile, use New on the Quality Profiles page.

### 4.5 Bring in upstream (Dictionarry) changes

Status: from the 2.2.0 source. Planned helper: a script that lists upstream ops touching only
release groups or regex.

HTB's database is not a fork of Dictionarry's v2 database, so git can't merge it. Instead:

1. Dictionarry stays linked in v2 as a reference database (auto-pull off). Open its **Updates**
   page to see new upstream commits, then pull it. That only changes Dictionarry's copy inside v2.
2. Read what changed: the op files in
   [Dictionarry-Hub/database, branch v2](https://github.com/Dictionarry-Hub/database/tree/v2/ops),
   or the same entity in the Dictionarry database inside v2.
3. Copy the changes you want into HTB by hand in the UI, usually regex patterns and tier
   membership. Review score or quality group changes against HTB's ranking model before copying.
4. Export with a message that names the upstream op, for example
   `copy upstream 131: add XYZ to 2160p Quality Tier 3`.
5. TRaSH Guides stays linked as a cross-check only.

### 4.6 Export changes to git

Status: from the 2.2.0 source. Verified when the delay profile is exported.

1. Databases, then HTB, then **Changes**. "Outgoing Changes" lists every draft.
2. If "Incoming Changes" shows commits, pull them first. Export is blocked while the local copy is
   behind GitHub.
3. Tick the drafts to ship. Changes they depend on are ticked automatically (amber).
4. Type a commit message. It also becomes the op file name, so keep it short and specific.
5. Click **Preview export**, check the diff, then **Approve & Export**.
6. v2 validates the SQL against a clean build, writes `ops/<n>.<message>.sql`, commits it as the
   git author set on the database, and pushes to `v2`.

To throw a draft away instead, tick it and click **Drop selected changes** (the bin icon).

### 4.7 Pull the database after a commit made outside v2

Status: from the 2.2.0 source.

If someone adds or fixes an op directly in git (for example in a Copilot session), v2 has to pull
it before the next export:

1. Databases, then HTB, then **Changes**. The "Incoming Changes" section shows a
   **Pull N commits** button when GitHub is ahead. The **Updates** tab lists the same commits.
2. Pull. v2 imports the new op files and rebuilds the cache.

Before cutover this is safe, because no Arr sync uses the On Pull trigger. After cutover, keep
every sync trigger on Manual, so a pull never changes an Arr by itself.

### 4.8 Run and read drift

Status: from the 2.2.0 source.

1. Arrs, then the instance, then **Drift**.
2. Turn on **Detection** if needed, then **Run Now**. It only reads from the Arr.
3. Each row is one drifted item (a profile, custom format, delay profile or media management
   config). Expand it to see the Profilarr value next to the Arr value.
4. Drift only covers what is selected on the instance's Sync page.

Known differences at the parity check (see section 7) are expected until the first sync.

### 4.9 Sync to an Arr (after cutover only)

Status: not yet exercised. Cutover needs its own approval.

1. Arrs, then the instance, then **Sync**.
2. Each section (Quality Profiles, Delay Profiles, Media Management) has its own selections and
   its own Trigger, Save and Sync buttons. Select only HTB items, and keep HTB at database
   priority #1.
3. Keep Trigger on **Manual**. Click **Save** for selections, then **Sync** only when you mean to
   push. Sync and Save sit next to each other, so check which one you are pressing.
4. Run drift afterwards. It should be clean.

### 4.10 Undo a change

Status: from the 2.2.0 source.

- **Not exported yet**: drop the draft on the Changes page.
- **Already exported**: make the opposite edit in the UI and export it as a new op. Never delete
  or rewrite a published op file. Installs that already have it would go out of step with git.
- **Exported and synced**: fix the database, export, then sync again.

### 4.11 Renew the GitHub token

Status: from the 2.2.0 source.

The token on the HTB database is a fine-grained GitHub token: repository `st-sha/profilarr-htb`
only, Contents read and write. When it expires, exports and pulls fail with an auth error.

1. Create a new token on GitHub with the same scope.
2. Databases, then HTB, then **Settings**, paste it in the token field and save.
3. Revoke the old token on GitHub.

The token lives only in v2's own database. Never put it in a file, a script or chat.

## 5. Safety rules

- Profile names never change.
- On every Arr's Sync page, HTB is database priority #1, above Dictionarry and TRaSH. Their
  profiles and custom formats share names with HTB's, and the highest-priority database wins.
- Every sync trigger stays Manual. Never On Pull or Schedule.
- Never turn on v2 upgrades, rename or cleanup for these Arrs. Upgrades run automated searches.
- Apply Default Delay Profile and Prompt to Sync Changes stay off in Settings, General.
- Before cutover, nothing syncs to production Radarr or Sonarr. v1 stays the only writer.
- Measure a scoring re-band in a sandbox Arr before it reaches a real one.

## 6. Troubleshooting

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| Export says "Pull incoming changes first" | GitHub has commits v2 hasn't pulled | Pull on the Changes page, then export |
| Export says the repository has uncommitted changes or unpushed commits | The clone inside v2 was touched by hand | Don't edit `/config/data/databases/...` by hand. Ask for help before repairing it |
| Export or pull fails with an auth error | Token expired or lost access | Renew it (4.11) |
| Export says a batch failed validation | A selected draft depends on something not selected, or breaks a rule | Read the message, select the missing draft, or fix the entity |
| Database shows errors after a pull | An op failed to compile | Check Settings, Logs for "Cache failed". Fix with a new op |
| Conflicts tab has entries | Only user ops conflict. HTB's own edits are base ops | Review them. HTB should have none |
| Drift won't clear after a sync | A value the Arr rewrites (see section 7) | Compare the expanded drift row with the Arr's own UI |

## 7. What's in this branch, and known differences

Ops `0` to `3` rebuild the v1 database as live Radarr and Sonarr had it on 2026-10-18:

- `0.rosettarr.sql`: the converted v1 YAML (`stable` at `3904008`), unmodified.
- `1.htb-quality-group-member-positions.sql`: the order of qualities inside each group, which v1
  kept and the converter couldn't express.
- `2.htb-language-any-and-not-original.sql`: v1's `must_original` rule (language Any plus
  "Not Original" at -1 in every profile).
- `3.htb-streaming-services-in-rename.sql`: the 18 streaming formats that are in file names live.

Known differences from live at the parity check. The first v2 sync at cutover would change only
these:

- **Group numbering** in Radarr `2160p Remux`, `2160p Remux (Prefer Theatrical)` and
  `2160p Efficient`, and Sonarr `2160p Remux` and `2160p Efficient`. v1 numbered groups from their
  YAML ids, while v2 numbers them 1001, 1002 and so on from the top. Members, order, allowed flags
  and the cutoff group are the same, so release choice doesn't change.
- **Radarr's Xvid regex** is `\b(Xvid)\b`, a leftover from the June 2026 v2 trial (Dictionarry's
  op 58). This database keeps the fork's `(?i)[-. ]Xvid`, which Sonarr already uses.
