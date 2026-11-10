-- HTB deliberate change: FraMeSToR's encodes rank with decibeL's.
--
-- Op 8 moved FraMeSToR's 1080p and 720p encodes from upstream's Tier 6 to Tier 2, the tier of its
-- remuxes, after a library search would have swapped FraMeSToR encodes with lossless audio for lossy
-- ones (Anthropoid). Since op 11, lossless audio (2,000) beats lossy from one tier below, so that risk
-- is smaller. Battlestar Galactica (2003) S02 showed the cost of Tier 2: FraMeSToR's pack outscored
-- decibeL's (Tier 3) by 1,000 with no visible gain and without decibeL's commentary tracks. Steven chose
-- on 2026-11-10 to rank FraMeSToR's encodes equal to decibeL's: 1080p Quality Tier 3 and 720p Quality
-- Tier 4, decibeL's tiers. Remux Tier 2 is unchanged. FraMeSToR's entry in the unscored
-- "1080p Quality Tier 6 (Efficient)" format is left alone. No scores change.

DELETE FROM custom_format_conditions WHERE custom_format_name = '1080p Quality Tier 2' AND name = 'FraMeSToR';
DELETE FROM custom_format_conditions WHERE custom_format_name = '720p Quality Tier 2' AND name = 'FraMeSToR';

INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('1080p Quality Tier 3', 'FraMeSToR', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('1080p Quality Tier 3', 'FraMeSToR', 'FraMeSToR');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('720p Quality Tier 4', 'FraMeSToR', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('720p Quality Tier 4', 'FraMeSToR', 'FraMeSToR');
