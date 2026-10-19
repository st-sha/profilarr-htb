-- HTB parity: reproduce v1's "language: must_original" the way v1 synced it.
--
-- v1 did not send a profile language for must_original. It set the Radarr profile
-- language to Any and generated a "Not Original" custom format, scored at the
-- profile's minimum custom format score minus 1 (0 - 1 = -1 here), in every Radarr
-- and Sonarr profile. rosettarr instead writes language Original (type must), which
-- Profilarr v2 would sync as Radarr language Original and no format.

-- 1. Profile language: Any (Profilarr sends Any to Radarr and ignores it for Sonarr).
UPDATE quality_profile_languages SET language_name = 'Any', type = 'simple'
WHERE language_name = 'Original' AND type = 'must';

-- 2. The "Not Original" custom format, matching the one v1 created in both Arrs.
INSERT INTO custom_formats (name, description) VALUES ('Not Original', 'Matches releases with no original-language audio. Replaces v1''s language: must_original rule. Scored at the profile minimum minus 1 in every profile.');
INSERT INTO custom_format_tags (custom_format_name, tag_name) VALUES ('Not Original', 'Language');
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Not Original', 'Not Original', 'language', 'all', 0, 1);
INSERT INTO custom_format_conditions (custom_format_name, name, type, arr_type, negate, required) VALUES ('Not Original', 'Includes Original', 'language', 'all', 1, 1);
INSERT INTO condition_languages (custom_format_name, condition_name, language_name, except_language) VALUES ('Not Original', 'Not Original', 'Original', 1);
INSERT INTO condition_languages (custom_format_name, condition_name, language_name, except_language) VALUES ('Not Original', 'Includes Original', 'Original', 0);

-- 3. Score it in every profile, for both Arrs.
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('1080p Quality', 'Not Original', 'all', -1);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Balanced', 'Not Original', 'all', -1);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Efficient', 'Not Original', 'all', -1);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Quality', 'Not Original', 'all', -1);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Quality (Prefer Theatrical)', 'Not Original', 'all', -1);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Remux', 'Not Original', 'all', -1);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Remux (Prefer Theatrical)', 'Not Original', 'all', -1);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Remux Only', 'Not Original', 'all', -1);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('720p Quality', 'Not Original', 'all', -1);
