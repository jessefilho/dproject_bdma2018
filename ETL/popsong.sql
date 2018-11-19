
CREATE SEQUENCE datamarts.dim_popularitydate_dim_popularitydate_seq;

CREATE TABLE datamarts.dim_popularitydate (
                dim_popularitydate INTEGER NOT NULL DEFAULT nextval('datamarts.dim_popularitydate_dim_popularitydate_seq'),
                popularitymonthyear VARCHAR,
                popularitymonth VARCHAR,
                popularityyear VARCHAR,
                CONSTRAINT dim_popularitydate_pk PRIMARY KEY (dim_popularitydate)
);


ALTER SEQUENCE datamarts.dim_popularitydate_dim_popularitydate_seq OWNED BY datamarts.dim_popularitydate.dim_popularitydate;

CREATE SEQUENCE datamarts.dim_labels_dim_labels_seq;

CREATE TABLE datamarts.dim_labels (
                dim_labels INTEGER NOT NULL DEFAULT nextval('datamarts.dim_labels_dim_labels_seq'),
                id_labels INTEGER,
                labeltype VARCHAR,
                CONSTRAINT dim_labels_pk PRIMARY KEY (dim_labels)
);


ALTER SEQUENCE datamarts.dim_labels_dim_labels_seq OWNED BY datamarts.dim_labels.dim_labels;

CREATE SEQUENCE datamarts.dim_member_dim_member_seq;

CREATE TABLE datamarts.dim_member (
                dim_member INTEGER NOT NULL DEFAULT nextval('datamarts.dim_member_dim_member_seq'),
                id_member INTEGER,
                member VARCHAR,
                position VARCHAR,
                CONSTRAINT dim_member_pk PRIMARY KEY (dim_member)
);


ALTER SEQUENCE datamarts.dim_member_dim_member_seq OWNED BY datamarts.dim_member.dim_member;

CREATE SEQUENCE datamarts.dim_cover_dim_cover_seq;

CREATE TABLE datamarts.dim_cover (
                dim_cover INTEGER NOT NULL DEFAULT nextval('datamarts.dim_cover_dim_cover_seq'),
                id_cover INTEGER,
                cover VARCHAR,
                CONSTRAINT dim_cover_pk PRIMARY KEY (dim_cover)
);


ALTER SEQUENCE datamarts.dim_cover_dim_cover_seq OWNED BY datamarts.dim_cover.dim_cover;

CREATE SEQUENCE datamarts.dim_genres_dim_genres_seq;

CREATE TABLE datamarts.dim_genres (
                dim_genres INTEGER NOT NULL DEFAULT nextval('datamarts.dim_genres_dim_genres_seq'),
                id_genres INTEGER,
                genrestype VARCHAR,
                CONSTRAINT dim_genres_pk PRIMARY KEY (dim_genres)
);


ALTER SEQUENCE datamarts.dim_genres_dim_genres_seq OWNED BY datamarts.dim_genres.dim_genres;

CREATE SEQUENCE datamarts.dim_song_dim_song_seq;

CREATE TABLE datamarts.dim_song (
                dim_song INTEGER NOT NULL DEFAULT nextval('datamarts.dim_song_dim_song_seq'),
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
                id_releasecountrysong INTEGER,
                CONSTRAINT dim_song_pk PRIMARY KEY (dim_song)
);


ALTER SEQUENCE datamarts.dim_song_dim_song_seq OWNED BY datamarts.dim_song.dim_song;

CREATE SEQUENCE datamarts.dim_labels_seq;

CREATE SEQUENCE datamarts.dim_song_seq_1_1;

CREATE TABLE datamarts.bridge_labels (
                dim_labels INTEGER NOT NULL DEFAULT nextval('datamarts.dim_labels_seq'),
                dim_song INTEGER NOT NULL DEFAULT nextval('datamarts.dim_song_seq_1_1'),
                weight_labels VARCHAR,
                id_song INTEGER,
                id_labels INTEGER,
                CONSTRAINT bridge_labels_pk PRIMARY KEY (dim_labels, dim_song)
);


ALTER SEQUENCE datamarts.dim_labels_seq OWNED BY datamarts.bridge_labels.dim_labels;

ALTER SEQUENCE datamarts.dim_song_seq_1_1 OWNED BY datamarts.bridge_labels.dim_song;

CREATE SEQUENCE datamarts.dim_song_seq_1;

CREATE TABLE datamarts.bridge_member (
                dim_song INTEGER NOT NULL DEFAULT nextval('datamarts.dim_song_seq_1'),
                dim_member INTEGER NOT NULL,
                weight_member VARCHAR,
                id_member INTEGER,
                id_song INTEGER,
                CONSTRAINT bridge_member_pk PRIMARY KEY (dim_song, dim_member)
);


ALTER SEQUENCE datamarts.dim_song_seq_1 OWNED BY datamarts.bridge_member.dim_song;

CREATE SEQUENCE datamarts.dim_popularitydate_seq;

CREATE SEQUENCE datamarts.dim_song_seq;

CREATE SEQUENCE datamarts.dim_genres_seq;

CREATE SEQUENCE datamarts.dim_cover_seq;

CREATE TABLE datamarts.fct_popularitysong (
                dim_popularitydate INTEGER NOT NULL DEFAULT nextval('datamarts.dim_popularitydate_seq'),
                dim_song INTEGER NOT NULL DEFAULT nextval('datamarts.dim_song_seq'),
                dim_genres INTEGER NOT NULL DEFAULT nextval('datamarts.dim_genres_seq'),
                dim_cover INTEGER NOT NULL DEFAULT nextval('datamarts.dim_cover_seq'),
                popularitysong REAL,
                id_genres INTEGER,
                id_song INTEGER,
                id_cover VARCHAR,
                CONSTRAINT fct_popularitysong_pk PRIMARY KEY (dim_popularitydate, dim_song, dim_genres, dim_cover)
);


ALTER SEQUENCE datamarts.dim_popularitydate_seq OWNED BY datamarts.fct_popularitysong.dim_popularitydate;

ALTER SEQUENCE datamarts.dim_song_seq OWNED BY datamarts.fct_popularitysong.dim_song;

ALTER SEQUENCE datamarts.dim_genres_seq OWNED BY datamarts.fct_popularitysong.dim_genres;

ALTER SEQUENCE datamarts.dim_cover_seq OWNED BY datamarts.fct_popularitysong.dim_cover;

ALTER TABLE datamarts.fct_popularitysong ADD CONSTRAINT dim_popularitydate_fct_popularitysong_fk
FOREIGN KEY (dim_popularitydate)
REFERENCES datamarts.dim_popularitydate (dim_popularitydate)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamarts.bridge_labels ADD CONSTRAINT dim_labels_bridge_labels_fk
FOREIGN KEY (dim_labels)
REFERENCES datamarts.dim_labels (dim_labels)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamarts.bridge_member ADD CONSTRAINT dim_member_bridge_member_fk
FOREIGN KEY (dim_member)
REFERENCES datamarts.dim_member (dim_member)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamarts.fct_popularitysong ADD CONSTRAINT dim_cover_fct_popularitysong_fk
FOREIGN KEY (dim_cover)
REFERENCES datamarts.dim_cover (dim_cover)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamarts.fct_popularitysong ADD CONSTRAINT dim_genres_fct_popularitysong_fk
FOREIGN KEY (dim_genres)
REFERENCES datamarts.dim_genres (dim_genres)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamarts.fct_popularitysong ADD CONSTRAINT dim_song_fct_popularitysong_fk
FOREIGN KEY (dim_song)
REFERENCES datamarts.dim_song (dim_song)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamarts.bridge_member ADD CONSTRAINT dim_song_bridge_member_fk
FOREIGN KEY (dim_song)
REFERENCES datamarts.dim_song (dim_song)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE datamarts.bridge_labels ADD CONSTRAINT dim_song_bridge_labels_fk
FOREIGN KEY (dim_song)
REFERENCES datamarts.dim_song (dim_song)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;