-- HTB deliberate change: "Better Theatricals" scores 0 everywhere.
--
-- The format is meant to prefer the theatrical cut of a listed set of films (Alien, Terminator 2, Donnie Darko
-- and others) by matching their titles. Radarr replaces the movie's title with "A Movie" before it matches
-- release titles (SimpleReleaseTitle), so the format has never applied to a release: none of the 6,348 releases
-- in the saved searches carried it. It only added 1,000 to library files whose names say Theatrical, and at
-- +1,000 it only tied Special Edition anyway. A per-movie theatrical preference is done by putting the movie on
-- a Prefer Theatrical profile, where six of its eleven titles already are. One file changes (Almost Famous,
-- -1,000) and no search decision. Steven's choice on 2026-11-13.

UPDATE quality_profile_custom_formats SET score = 0 WHERE custom_format_name = 'Better Theatricals' AND score = 1000;