
CREATE SEQUENCE datamart_song.dim_labels_dim_labels_seq;

CREATE TABLE datamart_song.dim_labels (
                dim_labels INTEGER NOT NULL DEFAULT nextval('datamart_song.dim_labels_dim_labels_seq'),
                id_labels INTEGER,
                labeltype VARCHAR,
                CONSTRAINT dim_labels_pk PRIMARY KEY (dim_labels)
);


ALTER SEQUENCE datamart_song.dim_labels_dim_labels_seq OWNED BY datamart_song.dim_labels.dim_labels;

CREATE SEQUENCE datamart_song.dim_member_dim_member_seq;

CREATE TABLE datamart_song.dim_member (
                dim_member INTEGER NOT NULL DEFAULT nextval('datamart_song.dim_member_dim_member_seq'),
                id_member INTEGER,
                member VARCHAR NOT NULL,
                position VARCHAR NOT NULL,
                CONSTRAINT dim_member_pk PRIMARY KEY (dim_member)
);


ALTER SEQUENCE datamart_song.dim_member_dim_member_seq OWNED BY datamart_song.dim_member.dim_member;

CREATE SEQUENCE datamart_song.dim_cover_dim_cover_seq;

CREATE TABLE datamart_song.dim_cover (
                dim_cover INTEGER NOT NULL DEFAULT nextval('datamart_song.dim_cover_dim_cover_seq'),
                id_cover INTEGER,
                cover VARCHAR,
                CONSTRAINT dim_cover_pk PRIMARY KEY (dim_cover)
);


ALTER SEQUENCE datamart_song.dim_cover_dim_cover_seq OWNED BY datamart_song.dim_cover.dim_cover;

CREATE SEQUENCE datamart_song.dim_releaselocationsong_dim_releaselocationsong_seq;

CREATE TABLE datamart_song.dim_releaselocationsong (
                dim_releaselocationsong INTEGER NOT NULL DEFAULT nextval('datamart_song.dim_releaselocationsong_dim_releaselocationsong_seq'),
                id_releaselocationsong INTEGER,
                releasecitysong VARCHAR,
                releasecountrysong VARCHAR,
                CONSTRAINT dim_releaselocationsong_pk PRIMARY KEY (dim_releaselocationsong)
);


ALTER SEQUENCE datamart_song.dim_releaselocationsong_dim_releaselocationsong_seq OWNED BY datamart_song.dim_releaselocationsong.dim_releaselocationsong;

CREATE SEQUENCE datamart_song.dim_releasedatesong_dim_releasedatesong_seq;

CREATE TABLE datamart_song.dim_releasedatesong (
                dim_releasedatesong INTEGER NOT NULL DEFAULT nextval('datamart_song.dim_releasedatesong_dim_releasedatesong_seq'),
                id_releasedatesong INTEGER,
                releasemonthsong VARCHAR,
                releasemonthYearsong VARCHAR,
                releaseyearsong VARCHAR,
                CONSTRAINT dim_releasedatesong_pk PRIMARY KEY (dim_releasedatesong)
);


ALTER SEQUENCE datamart_song.dim_releasedatesong_dim_releasedatesong_seq OWNED BY datamart_song.dim_releasedatesong.dim_releasedatesong;

CREATE SEQUENCE datamart_song.dim_artistgroup_dim_artistgroup_seq;

CREATE TABLE datamart_song.dim_artistgroup (
                dim_artistgroup INTEGER NOT NULL DEFAULT nextval('datamart_song.dim_artistgroup_dim_artistgroup_seq'),
                id_artistgroup VARCHAR,
                cityoriginartist VARCHAR,
                artistgroup VARCHAR,
                id_cityoriginartist VARCHAR,
                id_countryoriginartist VARCHAR,
                typegroup VARCHAR,
                CONSTRAINT dim_artistgroup_pk PRIMARY KEY (dim_artistgroup)
);


ALTER SEQUENCE datamart_song.dim_artistgroup_dim_artistgroup_seq OWNED BY datamart_song.dim_artistgroup.dim_artistgroup;

CREATE TABLE datamart_song.bridge_member (
                dim_artistgroup INTEGER NOT NULL,
                dim_member INTEGER NOT NULL,
                weight_member REAL,
                id_member VARCHAR,
                id_artistgroup VARCHAR,
                CONSTRAINT bridge_member_pk PRIMARY KEY (dim_artistgroup, dim_member)
);


CREATE SEQUENCE datamart_song.dim_genre_dim_genre_seq;

CREATE TABLE datamart_song.dim_genre (
                dim_genre INTEGER NOT NULL DEFAULT nextval('datamart_song.dim_genre_dim_genre_seq'),
                id_genre INTEGER,
                genretype VARCHAR,
                CONSTRAINT dim_genre_pk PRIMARY KEY (dim_genre)
);


ALTER SEQUENCE datamart_song.dim_genre_dim_genre_seq OWNED BY datamart_song.dim_genre.dim_genre;

CREATE SEQUENCE datamart_song.dim_album_dim_album_seq;

CREATE TABLE datamart_song.dim_album (
                dim_album INTEGER NOT NULL DEFAULT nextval('datamart_song.dim_album_dim_album_seq'),
                id_album INTEGER,
                releasemonthYearalbum VARCHAR,
                releasemonthalbum VARCHAR,
                releaseyearalbum VARCHAR,
                CONSTRAINT dim_album_pk PRIMARY KEY (dim_album)
);


ALTER SEQUENCE datamart_song.dim_album_dim_album_seq OWNED BY datamart_song.dim_album.dim_album;

CREATE TABLE datamart_song.bridge_labels (
                dim_album INTEGER NOT NULL,
                dim_labels INTEGER NOT NULL,
                weight_labels VARCHAR,
                id_labels INTEGER,
                id_album INTEGER,
                CONSTRAINT bridge_labels_pk PRIMARY KEY (dim_album, dim_labels)
);


CREATE TABLE datamart_song.fct_song (
                dim_artistgroup INTEGER NOT NULL,
                dim_releasedatesong INTEGER NOT NULL,
                dim_genre INTEGER NOT NULL,
                dim_cover INTEGER NOT NULL,
                dim_releaselocationsong INTEGER NOT NULL,
                dim_album INTEGER NOT NULL,
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
                titlesong VARCHAR,
                CONSTRAINT fct_song_pk PRIMARY KEY (dim_artistgroup, dim_releasedatesong, dim_genre, dim_cover, dim_releaselocationsong, dim_album)
);


ALTER TABLE datamart_song.bridge_labels ADD CONSTRAINT dim_labels_bridge_labels_fk
FOREIGN KEY (dim_labels)
REFERENCES datamart_song.dim_labels (dim_labels)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamart_song.bridge_member ADD CONSTRAINT dim_member_bridge_member_fk
FOREIGN KEY (dim_member)
REFERENCES datamart_song.dim_member (dim_member)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamart_song.fct_song ADD CONSTRAINT dim_cover_fct_song_fk
FOREIGN KEY (dim_cover)
REFERENCES datamart_song.dim_cover (dim_cover)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamart_song.fct_song ADD CONSTRAINT dim_releaselocationsong_fct_song_fk
FOREIGN KEY (dim_releaselocationsong)
REFERENCES datamart_song.dim_releaselocationsong (dim_releaselocationsong)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamart_song.fct_song ADD CONSTRAINT fct_song_dim_release_monthyear_song_fk
FOREIGN KEY (dim_releasedatesong)
REFERENCES datamart_song.dim_releasedatesong (dim_releasedatesong)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamart_song.fct_song ADD CONSTRAINT dim_artistgroup_fct_song_fk
FOREIGN KEY (dim_artistgroup)
REFERENCES datamart_song.dim_artistgroup (dim_artistgroup)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamart_song.bridge_member ADD CONSTRAINT dim_artistgroup_bridge_member_fk
FOREIGN KEY (dim_artistgroup)
REFERENCES datamart_song.dim_artistgroup (dim_artistgroup)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamart_song.fct_song ADD CONSTRAINT fct_song_dim_genre_fk
FOREIGN KEY (dim_genre)
REFERENCES datamart_song.dim_genre (dim_genre)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamart_song.fct_song ADD CONSTRAINT dim_album_fct_song_fk
FOREIGN KEY (dim_album)
REFERENCES datamart_song.dim_album (dim_album)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamart_song.bridge_labels ADD CONSTRAINT dim_album_bridge_labels_fk
FOREIGN KEY (dim_album)
REFERENCES datamart_song.dim_album (dim_album)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;