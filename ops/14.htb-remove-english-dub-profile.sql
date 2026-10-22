-- HTB deliberate change: remove the "2160p Quality (English Dub)" profile (added by op 10).
--
-- Steven's choice on 2026-10-21: don't use an English Dub profile. Its films went back to 2160p Quality in
-- Radarr before this op. This removes the profile and the three HTB formats only it scored: Resolution 1080p, Resolution 2160p, English Audio Missing.
-- Upstream's Dual Audio and DUBBED formats stay, unscored, like the other upstream formats op 12 added.
-- Nothing else changes, so no other profile's scores move. Child rows are deleted explicitly.

-- The profile and everything that belongs to it.
DELETE FROM quality_profile_custom_formats WHERE quality_profile_name = '2160p Quality (English Dub)';
DELETE FROM quality_profile_qualities WHERE quality_profile_name = '2160p Quality (English Dub)';
DELETE FROM quality_group_members WHERE quality_profile_name = '2160p Quality (English Dub)';
DELETE FROM quality_groups WHERE quality_profile_name = '2160p Quality (English Dub)';
DELETE FROM quality_profile_tags WHERE quality_profile_name = '2160p Quality (English Dub)';
DELETE FROM quality_profile_languages WHERE quality_profile_name = '2160p Quality (English Dub)';
DELETE FROM quality_profiles WHERE name = '2160p Quality (English Dub)';

-- The three formats only the profile used.
DELETE FROM condition_patterns WHERE custom_format_name IN ('Resolution 1080p', 'Resolution 2160p', 'English Audio Missing');
DELETE FROM condition_resolutions WHERE custom_format_name IN ('Resolution 1080p', 'Resolution 2160p', 'English Audio Missing');
DELETE FROM condition_languages WHERE custom_format_name IN ('Resolution 1080p', 'Resolution 2160p', 'English Audio Missing');
DELETE FROM custom_format_conditions WHERE custom_format_name IN ('Resolution 1080p', 'Resolution 2160p', 'English Audio Missing');
DELETE FROM custom_format_tags WHERE custom_format_name IN ('Resolution 1080p', 'Resolution 2160p', 'English Audio Missing');
DELETE FROM custom_format_tests WHERE custom_format_name IN ('Resolution 1080p', 'Resolution 2160p', 'English Audio Missing');
DELETE FROM quality_profile_custom_formats WHERE custom_format_name IN ('Resolution 1080p', 'Resolution 2160p', 'English Audio Missing');
DELETE FROM custom_formats WHERE name IN ('Resolution 1080p', 'Resolution 2160p', 'English Audio Missing');
