-- HTB parity: write "no maximum size" the way Profilarr v2 does.
--
-- Live Radarr has every quality definition at max 2000 and live Sonarr at
-- max 1000. Those are each Arr's top slider value, which means "unlimited".
-- Profilarr v2's drift check treats an Arr max of 2000 (Radarr) or 1000
-- (Sonarr) as unlimited, and stores unlimited in a database as 0. The v1
-- YAML, and so rosettarr, wrote the literal 2000 and 1000, which v2 reports
-- as drift on every row. Store 0 instead. Preferred sizes are unchanged.

UPDATE radarr_quality_definitions SET max_size = 0 WHERE name = 'default' AND max_size = 2000;
UPDATE sonarr_quality_definitions SET max_size = 0 WHERE name = 'default' AND max_size = 1000;
