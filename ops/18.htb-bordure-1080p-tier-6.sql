-- HTB deliberate change: BORDURE joins 1080p Quality Tier 6.
--
-- BORDURE's 1080p Blu-ray encodes matched no tier format, so any Tier 6 group outscored them by
-- 120,000 on the next search, even with lower bitrate and lossy audio. In the library, BORDURE's
-- 512 episodes run a median of 12.6 Mbps (Tier 2 is 12.6, Tier 6 is 12.2) and 290 of them carry
-- DTS-HD MA. Curb Your Enthusiasm S11 was the case: a Tier 6 encode at 12.2 Mbps with lossy audio
-- outranked BORDURE at 15.0 Mbps with DTS-HD MA from the same master. Neither Dictionarry nor TRaSH
-- rates BORDURE. Steven's choice on 2026-11-02: Tier 6, the same kind of override as op 16.
-- Tier 6 applies only to 1080p Blu-ray encodes that aren't remuxes. No scores change.

INSERT INTO regular_expressions (name, pattern, description, regex101_id) VALUES ('BORDURE', '(?<=^|[\s.-])BORDURE\b', '', NULL);
INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('BORDURE', 'Release Group');

INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('1080p Quality Tier 6', 'BORDURE', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('1080p Quality Tier 6', 'BORDURE', 'BORDURE');
