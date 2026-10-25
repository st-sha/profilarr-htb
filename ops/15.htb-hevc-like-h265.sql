-- HTB deliberate change: treat the HEVC spelling like H.265 at 1080p and below.
--
-- Untouched streaming HEVC (often HDR10) is titled either "H.265" or "HEVC". HTB has scored upstream's h265
-- format at 0 since v1, so H.265 streams are allowed, but x265 (WEB) and x265 share the x265 regex, which also
-- matches the word HEVC. The same stream scored about +380,000 or -600,000 depending on its title, and the
-- Arrs' renamed files carry [HEVC], so an allowed H.265 grab turned negative after import and was replaced.
-- Steven's choice on 2026-10-25: these two formats match only the x265 encoder tag, the mark of a re-encode.
-- The shared x265 regex is untouched, so x265 (Bluray), x265 (Efficient), UHD Bluray, Full Disc and
-- HDR (Missing) behave as before. No scores change.

INSERT INTO regular_expressions (name, pattern, description, regex101_id) VALUES ('x265 (Encoder)', '^(?!.*remux).*[x][ ._-]?265', 'HTB: the x265 encoder tag only, without HEVC or H.265, for remux-free titles.', NULL);
INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('x265 (Encoder)', 'Codec');
INSERT INTO regular_expression_tags (regular_expression_name, tag_name) VALUES ('x265 (Encoder)', 'Encoder');

UPDATE condition_patterns SET regular_expression_name = 'x265 (Encoder)' WHERE custom_format_name = 'x265 (WEB)' AND condition_name = 'x265' AND regular_expression_name = 'x265';
UPDATE condition_patterns SET regular_expression_name = 'x265 (Encoder)' WHERE custom_format_name = 'x265' AND condition_name = 'x265' AND regular_expression_name = 'x265';

UPDATE custom_formats SET description = 'Matches the x265 encoder tag when not 2160p or Bluray. HTB: HEVC and H.265 streams don''t match (op 15).' WHERE name = 'x265 (WEB)';
UPDATE custom_formats SET description = 'Matches the x265 encoder tag when not 2160p. HTB: HEVC and H.265 streams don''t match (op 15).' WHERE name = 'x265';
