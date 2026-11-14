-- HTB deliberate change: a release labeled Theatrical wins over an unlabeled one on the Prefer Theatrical profiles.
--
-- The Prefer Theatrical profiles penalize labeled longer cuts (Special Edition, -40,000) but scored a release
-- labeled Theatrical the same as an unlabeled one, which is often the longer cut. In the July and October
-- remux-to-encode swaps, unlabeled extended and unrated encodes replaced theatrical files on The Campaign,
-- Talladega Nights, Wedding Crashers and Taken 3 (movie cut and edition audit, D3 and D9, 2026-11-13).
-- Two changes:
-- 1. "Theatrical" and "Better Theatricals" excluded every name containing a Special Edition word, and "Cut" is
--    one, so the most common label, "Theatrical Cut", counted as unlabeled (59 of 131 theatrical-labeled
--    releases in the saved searches). Both now use a copy of the Special Edition words that skips Cut, Version
--    or Edition right after "Theatrical". The Special Edition format keeps its own regex and doesn't change.
-- 2. "Theatrical" scores 24,500 on both Prefer Theatrical profiles. That lets a labeled theatrical beat an
--    unlabeled release up to one encode class better (a BHDStudio encode over a D-Z0N3 one, for example), and
--    stays below 25,000, where The Patriot's misparsed TERMiNAL full disc would replace its encode.
-- Read-only searches of the 55 unlabeled, unflagged Prefer Theatrical movies found 6 that a search would move
-- to a labeled theatrical of the same quality (5 remuxes and Mallrats), all keeping lossless audio.
-- Steven's choice on 2026-11-13.

INSERT INTO regular_expressions (name, pattern, description, regex101_id) VALUES ('Special Edition (Not Theatrical Cut)', '(?<=\b[12]\d{3}\b).*\b(?<!Theatrical[ ._-])(Cut|Directors|DC|Extended|Special|Uncensored|Uncut|Unrated|Version|(?<!{)Edition)(\b|\d)', 'HTB. The Special Edition words, except Cut, Version or Edition right after Theatrical, so "Theatrical Cut" still counts as theatrical.', NULL);
INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('Special Edition (Not Theatrical Cut)', 'Edition');
UPDATE condition_patterns SET regular_expression_name = 'Special Edition (Not Theatrical Cut)' WHERE custom_format_name IN ('Theatrical', 'Better Theatricals') AND condition_name = 'Not Special Edition' AND regular_expression_name = 'Special Edition';
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Quality (Prefer Theatrical)', 'Theatrical', 'radarr', 24500);
INSERT INTO quality_profile_custom_formats (quality_profile_name, custom_format_name, arr_type, score) VALUES ('2160p Remux (Prefer Theatrical)', 'Theatrical', 'radarr', 24500);