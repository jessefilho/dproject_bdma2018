
CREATE TABLE datamarts.dim_labels (
                dim_labels INTEGER ,
                id_labels INTEGER,
                labeltype VARCHAR
                
);

CREATE TABLE datamarts.dim_cover (
                dim_cover INTEGER ,
                id_cover INTEGER,
                cover VARCHAR
);



CREATE TABLE datamarts.dim_releaselocationsong (
                id_releaselocationsong INTEGER,
                releasecitysong VARCHAR,
                releasecountrysong VARCHAR
);

CREATE TABLE datamarts.dim_releasedatesong (
                
                id_releasedatesong INTEGER,
                releasemonthsong VARCHAR,
                releasemonthYearsong VARCHAR,
                releaseyearsong VARCHAR
);


CREATE TABLE datamarts.dim_genre (
                dim_genre INTEGER,
                id_genre INTEGER,
                genretype VARCHAR
);

CREATE TABLE datamarts.dim_album (
                id_album INTEGER,
                releasemonthYearalbum VARCHAR,
                releasemonthalbum VARCHAR,
                releaseyearalbum VARCHAR
);




CREATE TABLE datamarts.bridge_labels (                
                weight_labels VARCHAR,
                id_labels INTEGER,
                id_album INTEGER
                
);


CREATE TABLE datamarts.fct_song (
                id_artistgroup INTEGER,
                id_album INTEGER,
                id_releasedatesong INTEGER,
                id_cover VARCHAR,
                id_genre INTEGER,
                numberReleasedCover INTEGER,
                numberArtist INTEGER,
                tempo INTEGER,
                energy REAL,
                danceability REAL,
                speechiness REAL,
                accoustiness REAL,
                loudness REAL,
                duration REAL,
                valence REAL,
                instrumentalness VARCHAR,
                titlesong VARCHAR
                
);

