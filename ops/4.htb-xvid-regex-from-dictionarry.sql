-- HTB deliberate change (not parity): use Dictionarry's Xvid regex.
--
-- The fork's v1 pattern is (?i)[-. ]Xvid, which needs a separator before
-- "Xvid". Dictionarry changed it to \b(Xvid)\b in its v2 op 58. Live Radarr
-- already has \b(Xvid)\b, left over from the June 2026 v2 trial, while live
-- Sonarr still has the fork's pattern. Steven chose Dictionarry's pattern on
-- 2026-10-18, so Radarr already matches and Sonarr changes at cutover.

UPDATE regular_expressions SET pattern = '\b(Xvid)\b'
WHERE name = 'Xvid' AND pattern = '(?i)[-. ]Xvid';
