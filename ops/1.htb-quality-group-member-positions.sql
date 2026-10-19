-- HTB parity: order the qualities inside each quality group.
--
-- Schema 1.1.0 added quality_group_members.position. rosettarr predates it, so every
-- member starts at 0 and Profilarr falls back to alphabetical order. Profilarr reads
-- members by position and sends them to the Arr in reverse, so position = (n - 1 - i)
-- for the member at index i of the v1 YAML group. The Arr then gets the YAML order,
-- which is what v1 synced and what live Radarr and Sonarr hold.

-- 1080p Quality / 1080p Quality: WEBDL-1080p, WEBRip-1080p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '1080p Quality' AND quality_group_name = '1080p Quality' AND quality_name = 'WEBDL-1080p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '1080p Quality' AND quality_group_name = '1080p Quality' AND quality_name = 'WEBRip-1080p';

-- 1080p Quality / 720p Quality: Bluray-720p, WEBDL-720p, WEBRip-720p
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '1080p Quality' AND quality_group_name = '720p Quality' AND quality_name = 'Bluray-720p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '1080p Quality' AND quality_group_name = '720p Quality' AND quality_name = 'WEBDL-720p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '1080p Quality' AND quality_group_name = '720p Quality' AND quality_name = 'WEBRip-720p';

-- 1080p Quality / 480p Quality: Bluray-576p, Bluray-480p, WEBDL-480p, DVD
UPDATE quality_group_members SET position = 3 WHERE quality_profile_name = '1080p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-576p';
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '1080p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-480p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '1080p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'WEBDL-480p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '1080p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'DVD';

-- 2160p Balanced / 2160p Balanced: Bluray-2160p, WEBDL-2160p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '2160p Balanced' AND quality_name = 'Bluray-2160p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '2160p Balanced' AND quality_name = 'WEBDL-2160p';

-- 2160p Balanced / 1080p Quality HDR: Bluray-1080p, WEBDL-1080p, WEBRip-1080p
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '1080p Quality HDR' AND quality_name = 'Bluray-1080p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '1080p Quality HDR' AND quality_name = 'WEBDL-1080p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '1080p Quality HDR' AND quality_name = 'WEBRip-1080p';

-- 2160p Balanced / 720p Quality: Bluray-720p, WEBDL-720p, WEBRip-720p
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '720p Quality' AND quality_name = 'Bluray-720p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '720p Quality' AND quality_name = 'WEBDL-720p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '720p Quality' AND quality_name = 'WEBRip-720p';

-- 2160p Balanced / 480p Quality: Bluray-576p, Bluray-480p, WEBDL-480p, DVD
UPDATE quality_group_members SET position = 3 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-576p';
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-480p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '480p Quality' AND quality_name = 'WEBDL-480p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Balanced' AND quality_group_name = '480p Quality' AND quality_name = 'DVD';

-- 2160p Efficient / 2160p Efficient: Bluray-2160p, WEBDL-2160p, WEBRip-2160p
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '2160p Efficient' AND quality_name = 'Bluray-2160p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '2160p Efficient' AND quality_name = 'WEBDL-2160p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '2160p Efficient' AND quality_name = 'WEBRip-2160p';

-- 2160p Efficient / 1080p Efficient: Bluray-1080p, WEBDL-1080p, WEBRip-1080p
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '1080p Efficient' AND quality_name = 'Bluray-1080p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '1080p Efficient' AND quality_name = 'WEBDL-1080p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '1080p Efficient' AND quality_name = 'WEBRip-1080p';

-- 2160p Efficient / 720p Quality: Bluray-720p, WEBDL-720p, WEBRip-720p
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '720p Quality' AND quality_name = 'Bluray-720p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '720p Quality' AND quality_name = 'WEBDL-720p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '720p Quality' AND quality_name = 'WEBRip-720p';

-- 2160p Efficient / 480p Quality: Bluray-576p, Bluray-480p, WEBDL-480p, DVD
UPDATE quality_group_members SET position = 3 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-576p';
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-480p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '480p Quality' AND quality_name = 'WEBDL-480p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Efficient' AND quality_group_name = '480p Quality' AND quality_name = 'DVD';

-- 2160p Quality / 2160p Quality: Bluray-2160p, WEBDL-2160p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '2160p Quality' AND quality_name = 'Bluray-2160p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '2160p Quality' AND quality_name = 'WEBDL-2160p';

-- 2160p Quality / 1080p Quality HDR: WEBDL-1080p, WEBRip-1080p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '1080p Quality HDR' AND quality_name = 'WEBDL-1080p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '1080p Quality HDR' AND quality_name = 'WEBRip-1080p';

-- 2160p Quality / 720p Quality: Bluray-720p, WEBDL-720p, WEBRip-720p
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '720p Quality' AND quality_name = 'Bluray-720p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '720p Quality' AND quality_name = 'WEBDL-720p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '720p Quality' AND quality_name = 'WEBRip-720p';

-- 2160p Quality / 480p Quality: Bluray-576p, Bluray-480p, WEBDL-480p, DVD
UPDATE quality_group_members SET position = 3 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-576p';
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-480p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'WEBDL-480p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'DVD';

-- 2160p Quality (Prefer Theatrical) / 2160p Quality: Bluray-2160p, WEBDL-2160p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '2160p Quality' AND quality_name = 'Bluray-2160p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '2160p Quality' AND quality_name = 'WEBDL-2160p';

-- 2160p Quality (Prefer Theatrical) / 1080p Quality HDR: WEBDL-1080p, WEBRip-1080p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '1080p Quality HDR' AND quality_name = 'WEBDL-1080p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '1080p Quality HDR' AND quality_name = 'WEBRip-1080p';

-- 2160p Quality (Prefer Theatrical) / 720p Quality: Bluray-720p, WEBDL-720p, WEBRip-720p
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '720p Quality' AND quality_name = 'Bluray-720p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '720p Quality' AND quality_name = 'WEBDL-720p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '720p Quality' AND quality_name = 'WEBRip-720p';

-- 2160p Quality (Prefer Theatrical) / 480p Quality: Bluray-576p, Bluray-480p, WEBDL-480p, DVD
UPDATE quality_group_members SET position = 3 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-576p';
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-480p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '480p Quality' AND quality_name = 'WEBDL-480p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND quality_group_name = '480p Quality' AND quality_name = 'DVD';

-- 2160p Remux / 2160p Formats: Remux-2160p, WEBDL-2160p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Remux' AND quality_group_name = '2160p Formats' AND quality_name = 'Remux-2160p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Remux' AND quality_group_name = '2160p Formats' AND quality_name = 'WEBDL-2160p';

-- 2160p Remux / SD Fallback: DVD, WEBDL-480p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Remux' AND quality_group_name = 'SD Fallback' AND quality_name = 'DVD';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Remux' AND quality_group_name = 'SD Fallback' AND quality_name = 'WEBDL-480p';

-- 2160p Remux (Prefer Theatrical) / 2160p Formats: Remux-2160p, WEBDL-2160p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Remux (Prefer Theatrical)' AND quality_group_name = '2160p Formats' AND quality_name = 'Remux-2160p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Remux (Prefer Theatrical)' AND quality_group_name = '2160p Formats' AND quality_name = 'WEBDL-2160p';

-- 2160p Remux (Prefer Theatrical) / SD Fallback: DVD, WEBDL-480p
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '2160p Remux (Prefer Theatrical)' AND quality_group_name = 'SD Fallback' AND quality_name = 'DVD';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '2160p Remux (Prefer Theatrical)' AND quality_group_name = 'SD Fallback' AND quality_name = 'WEBDL-480p';

-- 720p Quality / 720p Quality: Bluray-720p, WEBDL-720p, WEBRip-720p
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '720p Quality' AND quality_group_name = '720p Quality' AND quality_name = 'Bluray-720p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '720p Quality' AND quality_group_name = '720p Quality' AND quality_name = 'WEBDL-720p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '720p Quality' AND quality_group_name = '720p Quality' AND quality_name = 'WEBRip-720p';

-- 720p Quality / 480p Quality: Bluray-576p, Bluray-480p, WEBDL-480p, DVD
UPDATE quality_group_members SET position = 3 WHERE quality_profile_name = '720p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-576p';
UPDATE quality_group_members SET position = 2 WHERE quality_profile_name = '720p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'Bluray-480p';
UPDATE quality_group_members SET position = 1 WHERE quality_profile_name = '720p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'WEBDL-480p';
UPDATE quality_group_members SET position = 0 WHERE quality_profile_name = '720p Quality' AND quality_group_name = '480p Quality' AND quality_name = 'DVD';
