-- HTB parity: the default delay profile.
--
-- v1 never managed delay profiles, so rosettarr has none. This matches the
-- default delay profile (id 1) live in both Radarr and Sonarr on 2026-10-18:
-- prefer torrent, no usenet or torrent delay, no bypass, minimum custom
-- format score 0 (stored as NULL while the score bypass is off).

INSERT INTO delay_profiles (name, preferred_protocol, usenet_delay, torrent_delay, bypass_if_highest_quality, bypass_if_above_custom_format_score, minimum_custom_format_score)
VALUES ('HTB Default', 'prefer_torrent', 0, 0, 0, 0, NULL);
