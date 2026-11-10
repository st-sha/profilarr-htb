-- HTB deliberate change: a DVD remux ranks just below an untiered DVD encode, no longer banned.
--
-- "DVD Remux" was banned (-999,999) in every profile but 2160p Efficient, which scores it 20,000. The ban
-- came from the fork and was kept in the 2026-10-19 review because DVD video is often interlaced. On a
-- DVD-only show it inverted the order: The Joe Schmo Show S02's untouched NTSC DVD remux (S0NNY, Dolby
-- Digital 2.0) scored -999,589, so a lossy XviD DVDRip of the same disc (AMiGOS, 20,010) was an approved
-- replacement. Steven declined it on 2026-11-05 and asked for this review.
-- Steven's choice on 2026-11-10: a remux should score just a bit less than an encode. "DVD Remux" now
-- scores 19,700 in those eight profiles, 300 below the "DVD" base that every DVD encode gets (the "DVD"
-- format excludes remuxes). An encode wins a tie, and also wins when its audio is one step behind (AAC,
-- 200, against the remux's Dolby Digital, 400). A remux wins only against an encode with no scored
-- audio, which keeps Joe Schmo S02 (20,110 against 20,010). Tiered DVD encodes always win. Full disc
-- images stay banned through "Full Disc". 2160p Efficient keeps its 20,000.

UPDATE quality_profile_custom_formats SET score = 19700 WHERE quality_profile_name = '1080p Quality' AND custom_format_name = 'DVD Remux' AND arr_type = 'all' AND score = -999999;
UPDATE quality_profile_custom_formats SET score = 19700 WHERE quality_profile_name = '2160p Balanced' AND custom_format_name = 'DVD Remux' AND arr_type = 'all' AND score = -999999;
UPDATE quality_profile_custom_formats SET score = 19700 WHERE quality_profile_name = '2160p Quality' AND custom_format_name = 'DVD Remux' AND arr_type = 'all' AND score = -999999;
UPDATE quality_profile_custom_formats SET score = 19700 WHERE quality_profile_name = '2160p Quality (Prefer Theatrical)' AND custom_format_name = 'DVD Remux' AND arr_type = 'all' AND score = -999999;
UPDATE quality_profile_custom_formats SET score = 19700 WHERE quality_profile_name = '2160p Remux' AND custom_format_name = 'DVD Remux' AND arr_type = 'all' AND score = -999999;
UPDATE quality_profile_custom_formats SET score = 19700 WHERE quality_profile_name = '2160p Remux (Prefer Theatrical)' AND custom_format_name = 'DVD Remux' AND arr_type = 'all' AND score = -999999;
UPDATE quality_profile_custom_formats SET score = 19700 WHERE quality_profile_name = '2160p Remux Only' AND custom_format_name = 'DVD Remux' AND arr_type = 'all' AND score = -999999;
UPDATE quality_profile_custom_formats SET score = 19700 WHERE quality_profile_name = '720p Quality' AND custom_format_name = 'DVD Remux' AND arr_type = 'all' AND score = -999999;
