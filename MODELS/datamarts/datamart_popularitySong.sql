
CREATE SEQUENCE public.dim_popularitydate_id_popularitydate_seq_1;

CREATE TABLE public.dim_popularitydate (
                id_popularitydate INTEGER NOT NULL DEFAULT nextval('public.dim_popularitydate_id_popularitydate_seq_1'),
                popularitymonthyear TIMESTAMP NOT NULL,
                popularitymonth TIMESTAMP NOT NULL,
                popularityyear TIMESTAMP NOT NULL,
                CONSTRAINT dim_popularitydate_pk PRIMARY KEY (id_popularitydate)
);


ALTER SEQUENCE public.dim_popularitydate_id_popularitydate_seq_1 OWNED BY public.dim_popularitydate.id_popularitydate;

CREATE TABLE public.dim_labels (
                id_labels INTEGER NOT NULL,
                labeltype VARCHAR NOT NULL,
                CONSTRAINT dim_labels_pk PRIMARY KEY (id_labels)
);


CREATE SEQUENCE public.dim_member_id_member_seq_1;

CREATE TABLE public.dim_member (
                id_member INTEGER NOT NULL DEFAULT nextval('public.dim_member_id_member_seq_1'),
                member VARCHAR NOT NULL,
                position VARCHAR NOT NULL,
                CONSTRAINT dim_member_pk PRIMARY KEY (id_member)
);


ALTER SEQUENCE public.dim_member_id_member_seq_1 OWNED BY public.dim_member.id_member;

CREATE SEQUENCE public.dim_cover_id_cover_seq_1;

CREATE TABLE public.dim_cover (
                id_cover INTEGER NOT NULL DEFAULT nextval('public.dim_cover_id_cover_seq_1'),
                cover VARCHAR NOT NULL,
                CONSTRAINT dim_cover_pk PRIMARY KEY (id_cover)
);


ALTER SEQUENCE public.dim_cover_id_cover_seq_1 OWNED BY public.dim_cover.id_cover;

CREATE TABLE public.dim_genres (
                id_genres INTEGER NOT NULL,
                genrestype VARCHAR NOT NULL,
                CONSTRAINT dim_genres_pk PRIMARY KEY (id_genres)
);


CREATE SEQUENCE public.dim_song_id_song_seq_1;

CREATE TABLE public.dim_song (
                id_song INTEGER NOT NULL DEFAULT nextval('public.dim_song_id_song_seq_1'),
                id_artistgroup VARCHAR NOT NULL,
                artistgroup VARCHAR NOT NULL,
                typegroup VARCHAR NOT NULL,
                id_typegroup VARCHAR NOT NULL,
                cityoriginartist VARCHAR NOT NULL,
                id_cityoriginartist VARCHAR NOT NULL,
                countryoriginartist VARCHAR NOT NULL,
                id_countryoriginartist VARCHAR NOT NULL,
                releasedmonthYearsong TIMESTAMP NOT NULL,
                releasedyearsong TIMESTAMP NOT NULL,
                releasedmonthsong TIMESTAMP NOT NULL,
                album VARCHAR NOT NULL,
                id_album VARCHAR NOT NULL,
                releasemonthyearalbum TIMESTAMP NOT NULL,
                releasemonthalbum VARCHAR NOT NULL,
                releaseyearalbum VARCHAR NOT NULL,
                releaselocationsong VARCHAR NOT NULL,
                id_releaselocationsong VARCHAR NOT NULL,
                releasecitysong VARCHAR NOT NULL,
                id_releasecitysong VARCHAR NOT NULL,
                releasecountrysong VARCHAR NOT NULL,
                id_releasecountrysong VARCHAR NOT NULL,
                CONSTRAINT dim_song_pk PRIMARY KEY (id_song)
);


ALTER SEQUENCE public.dim_song_id_song_seq_1 OWNED BY public.dim_song.id_song;

CREATE TABLE public.fct_popularitySong (
                id_song INTEGER NOT NULL,
                id_labels INTEGER NOT NULL,
                id_member INTEGER NOT NULL,
                id_cover INTEGER NOT NULL,
                id_genres INTEGER NOT NULL,
                id_popularitydate INTEGER NOT NULL,
                popularitysong VARCHAR NOT NULL,
                CONSTRAINT fct_popularitysong_pk PRIMARY KEY (id_song, id_labels, id_member, id_cover, id_genres, id_popularitydate)
);


ALTER TABLE public.fct_popularitySong ADD CONSTRAINT dim_popularitydate_fct_popularitysong_fk
FOREIGN KEY (id_popularitydate)
REFERENCES public.dim_popularitydate (id_popularitydate)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_popularitySong ADD CONSTRAINT dim_labels_fct_popularitysong_fk
FOREIGN KEY (id_labels)
REFERENCES public.dim_labels (id_labels)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_popularitySong ADD CONSTRAINT dim_member_fct_popularitysong_fk
FOREIGN KEY (id_member)
REFERENCES public.dim_member (id_member)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_popularitySong ADD CONSTRAINT dim_cover_fct_popularitysong_fk
FOREIGN KEY (id_cover)
REFERENCES public.dim_cover (id_cover)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_popularitySong ADD CONSTRAINT dim_genres_fct_popularitysong_fk
FOREIGN KEY (id_genres)
REFERENCES public.dim_genres (id_genres)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_popularitySong ADD CONSTRAINT dim_song_fct_popularitysong_fk
FOREIGN KEY (id_song)
REFERENCES public.dim_song (id_song)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
