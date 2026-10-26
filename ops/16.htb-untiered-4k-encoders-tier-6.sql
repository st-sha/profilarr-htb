-- HTB deliberate change: four 4K Blu-ray encoders that upstream doesn't rate join 2160p Quality Tier 6.
--
-- 2160p Quality gives an untiered 4K Blu-ray encode no base score, so any 4K WEB-DL replaced it on the next
-- search. In the library, these groups' 4K encodes match the tiered ones (median 33 to 47 Mbps, lossless audio):
-- segment 42 Mbps, stories 32, BROADCAST 26 (The Last of Us 32 to 48) and SNOW 17 to 58, all lossless. The 4K
-- WEB-DLs that would replace them run about 16 to 22 Mbps with lossy audio. Neither Dictionarry nor TRaSH rates
-- these groups. Steven's choice on 2026-10-25: Tier 6, above every 4K WEB-DL and below every upstream tier, the
-- same kind of override as FraMeSToR (op 8). Tier 6 applies only to 2160p Blu-ray encodes that aren't remuxes.
-- No scores change.

INSERT INTO regular_expressions (name, pattern, description, regex101_id) VALUES ('BROADCAST', '(?<=^|[\s.-])BROADCAST\b', '', NULL);
INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('BROADCAST', 'Release Group');
INSERT INTO regular_expressions (name, pattern, description, regex101_id) VALUES ('segment', '(?<=^|[\s.-])segment\b', '', NULL);
INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('segment', 'Release Group');
INSERT INTO regular_expressions (name, pattern, description, regex101_id) VALUES ('stories', '(?<=^|[\s.-])stories\b', '', NULL);
INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('stories', 'Release Group');
INSERT INTO regular_expressions (name, pattern, description, regex101_id) VALUES ('SNOW', '(?<=^|[\s.-])SNOW\b', '', NULL);
INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('SNOW', 'Release Group');

INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('2160p Quality Tier 6', 'BROADCAST', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('2160p Quality Tier 6', 'BROADCAST', 'BROADCAST');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('2160p Quality Tier 6', 'segment', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('2160p Quality Tier 6', 'segment', 'segment');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('2160p Quality Tier 6', 'stories', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('2160p Quality Tier 6', 'stories', 'stories');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('2160p Quality Tier 6', 'SNOW', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('2160p Quality Tier 6', 'SNOW', 'SNOW');
