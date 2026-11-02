-- HTB deliberate change: ordinary DTS and Dolby Digital score equally in every profile.
-- Dolby Digital's upstream preference was a proxy for newer 1080p Blu-ray encodes, not proven
-- better audio fidelity: https://github.com/Dictionarry-Hub/database/issues/121#issuecomment-3685036673
-- Steven's choice on 2026-11-02: raise DTS from 300 to 400, leaving Dolby Digital at 400.
-- This covers all arr types. Other audio scores and all matching rules stay unchanged.

UPDATE quality_profile_custom_formats
SET score = 400
WHERE custom_format_name = 'DTS' AND score = 300;
