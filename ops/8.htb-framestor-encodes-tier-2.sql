-- HTB deliberate change: FraMeSToR encodes rank with its remuxes.
--
-- FraMeSToR's remuxes are in Remux Tier 2. Upstream ranks its encodes by Golden Popcorn awards
-- (GPPi), which are thin because it mostly releases remuxes, and moved them to 1080p Quality
-- Tier 6 (Dictionarry op 220, copied here by op 7). Steven chose on 2026-10-19 to rank
-- FraMeSToR's 1080p and 720p encodes at Tier 2, the same as its remuxes. It releases no 2160p
-- encodes that HTB has seen, so no 2160p tier changes.

DELETE FROM custom_format_conditions WHERE custom_format_name = '1080p Quality Tier 6' AND name = 'FraMeSToR';
DELETE FROM custom_format_conditions WHERE custom_format_name = '720p Quality Tier 5' AND name = 'FraMeSToR';

INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('1080p Quality Tier 2', 'FraMeSToR', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('1080p Quality Tier 2', 'FraMeSToR', 'FraMeSToR');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('720p Quality Tier 2', 'FraMeSToR', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('720p Quality Tier 2', 'FraMeSToR', 'FraMeSToR');
