-- HTB deliberate change: "Full Disc" no longer lets UHD disc sets through because their names say HEVC.
--
-- "Full Disc" bans disc images (-999,999 in every profile). One of its required conditions, "Not x265",
-- used the shared "x265" regex, which also matches the word HEVC. Every UHD disc carries HEVC video, so a
-- disc set named like "Fallout.S01.DV.HDR.2160p.BluRay.TrueHDA.7.1.HEVC-BROADCAST" (284 GB, three ISOs
-- inside) missed the ban and scored as a 2160p Quality Tier 6 encode (445,410). Sonarr has no BR-DISK
-- quality to fall back on; Radarr already parses these titles as BR-DISK and bans them through
-- "Full Disc (Quality Match)". Steven declined the Fallout set on 2026-11-10 and sent the gap for review.
-- "Not x265" now uses "x265 (Encoder)" (op 15), which matches only the x265 encoder tag. The Full Disc
-- pattern itself still skips REMUX, x264/x265/h264/h265 and 1080p HEVC, so encodes and remuxes named
-- that way are unaffected. Steven's choice on 2026-11-10.

UPDATE condition_patterns SET regular_expression_name = 'x265 (Encoder)' WHERE custom_format_name = 'Full Disc' AND condition_name = 'Not x265' AND regular_expression_name = 'x265';
