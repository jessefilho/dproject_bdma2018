CREATE TABLE datamarts.dim_song (
                dim_song INTEGER ,
                id_song INTEGER,
                id_artistgroup INTEGER,
                artistgroup VARCHAR,
                typegroup VARCHAR,
                id_typegroup INTEGER,
                cityoriginartist VARCHAR,
                id_cityoriginartist INTEGER,
                countryoriginartist VARCHAR,
                id_countryoriginartist INTEGER,
                releasedmonthYearsong VARCHAR,
                releasedyearsong VARCHAR,
                releasedmonthsong VARCHAR,
                album VARCHAR,
                id_album VARCHAR,
                releasemonthyearalbum VARCHAR,
                releasemonthalbum VARCHAR,
                releaseyearalbum VARCHAR,
                releaselocationsong VARCHAR,
                id_releaselocationsong INTEGER,
                releasecitysong VARCHAR,
                id_releasecitysong INTEGER,
                releasecountrysong VARCHAR,
                id_releasecountrysong INTEGER
);

CREATE TABLE datamarts.fct_popularitysong (
                id_popularitydate VARCHAR ,
                popularitysong REAL,
                id_genres INTEGER,
                id_song INTEGER,
                id_cover VARCHAR
);

