-- HTB deliberate change: GA's "WEB-DL" releases rank one tier step below the untouched streams.
--
-- GA's Grey's Anatomy S01 "AMZN WEB-DL" pack is an x264 CRF 18 re-encode (encoder header on E01), with no
-- visible gain over the untouched Disney+ stream on aligned frames. It still outscored that stream by 920
-- (283,610 against 282,690), because the title says AMZN WEB-DL. Steven declined it on 2026-11-10, and the
-- same group's S02 pack was the next candidate. The Arrs can't see encoder settings, so this works by group:
-- a new "WEB-DL Re-encode" format at -1,000 in every profile, one tier step, matching only WEB-DL releases
-- from groups added after a file comparison. GA is the only member. TrollHD and RTN were reviewed and left
-- out: some TrollHD packs in the library are untouched streams, and Steven chose TrollHD for New Girl S02
-- and S03 on its merits. A GA release still wins when it's the only 1080p WEB-DL. Steven's choice on
-- 2026-11-10.

INSERT INTO regular_expressions (name, pattern, description, regex101_id) VALUES ('GA', '(?<=^|[\s.-])GA\b', '', NULL);
INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('GA', 'Release Group');
INSERT INTO custom_formats (name, description, include_in_rename) VALUES ('WEB-DL Re-encode', 'HTB. WEB-DL releases from groups whose WEB-DLs were found to be x264 CRF re-encodes of the stream, not the untouched stream. Add a group only after a file comparison.', 0);
INSERT INTO custom_format_tags (custom_format_name, tag_name) VALUES ('WEB-DL Re-encode', 'Release Group');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('WEB-DL Re-encode', 'GA', 'release_group', 'all', 0, 0);
INSERT INTO condition_patterns (custom_format_name, condition_name, regular_expression_name) VALUES ('WEB-DL Re-encode', 'GA', 'GA');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('WEB-DL Re-encode', 'WEB-DL', 'source', 'all', 0, 1);
INSERT INTO condition_sources (custom_format_name, condition_name, source) VALUES ('WEB-DL Re-encode', 'WEB-DL', 'web_dl');
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('1080p Quality', 'WEB-DL Re-encode', 'all', -1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Balanced', 'WEB-DL Re-encode', 'all', -1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Efficient', 'WEB-DL Re-encode', 'all', -1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Quality', 'WEB-DL Re-encode', 'all', -1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Quality (Prefer Theatrical)', 'WEB-DL Re-encode', 'all', -1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Remux', 'WEB-DL Re-encode', 'all', -1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Remux (Prefer Theatrical)', 'WEB-DL Re-encode', 'all', -1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Remux Only', 'WEB-DL Re-encode', 'all', -1000);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('720p Quality', 'WEB-DL Re-encode', 'all', -1000);
