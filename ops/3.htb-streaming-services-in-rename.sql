-- HTB parity: custom formats included in file names.
--
-- The v1 YAML has no rename flag, so rosettarr leaves include_in_rename at 0.
-- Live Radarr and Sonarr have includeCustomFormatWhenRenaming on for these
-- streaming formats, so names keep tokens like {AMZN}. Other streaming formats
-- the profiles use (CRAV, DRPO, iP, MUBI, PLAY) are off in both Arrs, so they stay 0.

UPDATE custom_formats SET include_in_rename = 1 WHERE name IN (
  'AMZN',
  'ATVP',
  'BCORE',
  'CRIT',
  'DSNP',
  'HMAX',
  'HTSR',
  'HULU',
  'iT',
  'MA',
  'MAX',
  'NF',
  'NOW',
  'PCOK',
  'PMTP',
  'ROKU',
  'SHO',
  'STAN'
);
