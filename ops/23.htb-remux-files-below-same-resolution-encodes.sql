-- HTB deliberate change: a remux file in a non-remux profile ranks just below the encodes of its resolution.
--
-- The Quality, Balanced and Efficient profiles ban remux releases, so their quality lists didn't name
-- Remux-1080p or Remux-2160p. Profilarr sends unlisted qualities to the Arr as disallowed entries at the bottom
-- of the ladder, below SDTV, so a remux file there lost to any allowed release that cleared the 0 minimum. Op 20
-- let DVD remuxes clear it, and It's Always Sunny S06E13's 1080p Blu-ray remux was offered a 480i DVD remux.
-- Steven declined that on 2026-11-12. The same day he asked that encodes replace remux files on profiles that
-- don't want remuxes, so the remux can't simply rank first.
-- Both remux qualities are now listed, still disallowed, directly below the Blu-ray encode entry of their own
-- resolution (below the whole group where WEB-DL and Blu-ray share one) and above everything lower. A remux file
-- can be replaced by an encode of the same resolution or by anything higher, but not by a lower resolution or
-- a DVD. Where a profile allows no encode of that resolution (1080p Quality for 4K, 720p Quality for both), the
-- remux ranks first. Remux releases stay unwanted and banned. The remux profiles are unchanged. No scores change.
-- Steven's choice on 2026-11-13 (option A2).

UPDATE quality_profile_qualities SET position = position + 2 WHERE quality_profile_name = '1080p Quality' AND position >= 1;
UPDATE quality_profile_qualities SET position = position + 1 WHERE quality_profile_name = '1080p Quality' AND position = 0;
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('1080p Quality', 'Remux-2160p', NULL, 0, 0, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('1080p Quality', 'Remux-1080p', NULL, 2, 0, 0);
UPDATE quality_profile_qualities SET position = position + 2 WHERE quality_profile_name = '720p Quality' AND position >= 0;
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('720p Quality', 'Remux-2160p', NULL, 0, 0, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('720p Quality', 'Remux-1080p', NULL, 1, 0, 0);
UPDATE quality_profile_qualities SET position = position + 2 WHERE quality_profile_name = '2160p Balanced' AND position >= 2;
UPDATE quality_profile_qualities SET position = position + 1 WHERE quality_profile_name = '2160p Balanced' AND position = 1;
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('2160p Balanced', 'Remux-2160p', NULL, 1, 0, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('2160p Balanced', 'Remux-1080p', NULL, 3, 0, 0);
UPDATE quality_profile_qualities SET position = position + 2 WHERE quality_profile_name = '2160p Efficient' AND position >= 2;
UPDATE quality_profile_qualities SET position = position + 1 WHERE quality_profile_name = '2160p Efficient' AND position = 1;
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('2160p Efficient', 'Remux-2160p', NULL, 1, 0, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('2160p Efficient', 'Remux-1080p', NULL, 3, 0, 0);
UPDATE quality_profile_qualities SET position = position + 2 WHERE quality_profile_name = '2160p Quality' AND position >= 3;
UPDATE quality_profile_qualities SET position = position + 1 WHERE quality_profile_name = '2160p Quality' AND position IN (1, 2);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('2160p Quality', 'Remux-2160p', NULL, 1, 0, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('2160p Quality', 'Remux-1080p', NULL, 4, 0, 0);
UPDATE quality_profile_qualities SET position = position + 2 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND position >= 3;
UPDATE quality_profile_qualities SET position = position + 1 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND position IN (1, 2);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('2160p Quality (Prefer Theatrical)', 'Remux-2160p', NULL, 1, 0, 0);
INSERT INTO quality_profile_qualities (quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until) VALUES ('2160p Quality (Prefer Theatrical)', 'Remux-1080p', NULL, 4, 0, 0);
