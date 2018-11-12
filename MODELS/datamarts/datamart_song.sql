
CREATE SEQUENCE public.dim_labels_idlabels_seq_1;

CREATE TABLE public.dim_labels (
                idlabels VARCHAR NOT NULL DEFAULT nextval('public.dim_labels_idlabels_seq_1'),
                labeltype VARCHAR NOT NULL,
                CONSTRAINT dim_labels_pk PRIMARY KEY (idlabels)
);


ALTER SEQUENCE public.dim_labels_idlabels_seq_1 OWNED BY public.dim_labels.idlabels;

CREATE SEQUENCE public.dim_member_idmember_seq_1;

CREATE TABLE public.dim_member (
                idmember VARCHAR NOT NULL DEFAULT nextval('public.dim_member_idmember_seq_1'),
                member VARCHAR NOT NULL,
                position VARCHAR NOT NULL,
                CONSTRAINT dim_member_pk PRIMARY KEY (idmember)
);


ALTER SEQUENCE public.dim_member_idmember_seq_1 OWNED BY public.dim_member.idmember;

CREATE SEQUENCE public.dim_cover_idcover_seq_1;

CREATE TABLE public.dim_cover (
                idcover INTEGER NOT NULL DEFAULT nextval('public.dim_cover_idcover_seq_1'),
                cover VARCHAR NOT NULL,
                CONSTRAINT dim_cover_pk PRIMARY KEY (idcover)
);


ALTER SEQUENCE public.dim_cover_idcover_seq_1 OWNED BY public.dim_cover.idcover;

CREATE SEQUENCE public.dim_releaselocationsong_idreleaselocationsong_seq_1_1;

CREATE TABLE public.dim_releaselocationsong (
                idreleaselocationsong INTEGER NOT NULL DEFAULT nextval('public.dim_releaselocationsong_idreleaselocationsong_seq_1_1'),
                releasecitysong VARCHAR NOT NULL,
                releasecountrysong VARCHAR NOT NULL,
                CONSTRAINT dim_releaselocationsong_pk PRIMARY KEY (idreleaselocationsong)
);


ALTER SEQUENCE public.dim_releaselocationsong_idreleaselocationsong_seq_1_1 OWNED BY public.dim_releaselocationsong.idreleaselocationsong;

CREATE SEQUENCE public.dim_releasedatesong_idreleasedatesong_seq_1;

CREATE TABLE public.dim_releasedatesong (
                idreleasedatesong INTEGER NOT NULL DEFAULT nextval('public.dim_releasedatesong_idreleasedatesong_seq_1'),
                releasemonthsong TIMESTAMP NOT NULL,
                releasemonthYearsong TIMESTAMP NOT NULL,
                releaseyearsong TIMESTAMP NOT NULL,
                CONSTRAINT dim_releasedatesong_pk PRIMARY KEY (idreleasedatesong)
);


ALTER SEQUENCE public.dim_releasedatesong_idreleasedatesong_seq_1 OWNED BY public.dim_releasedatesong.idreleasedatesong;

CREATE SEQUENCE public.dim_artistgroup_idartistgroup_seq_1;

CREATE TABLE public.dim_artistgroup (
                idartistgroup VARCHAR NOT NULL DEFAULT nextval('public.dim_artistgroup_idartistgroup_seq_1'),
                artistgroup VARCHAR NOT NULL,
                cityoriginartist VARCHAR NOT NULL,
                idcityoriginartist VARCHAR NOT NULL,
                idcountryoriginartist VARCHAR NOT NULL,
                typegroup VARCHAR NOT NULL,
                CONSTRAINT dim_artistgroup_pk PRIMARY KEY (idartistgroup)
);


ALTER SEQUENCE public.dim_artistgroup_idartistgroup_seq_1 OWNED BY public.dim_artistgroup.idartistgroup;

CREATE SEQUENCE public.dim_genre_idgenre_seq_1;

CREATE TABLE public.dim_genre (
                idgenre INTEGER NOT NULL DEFAULT nextval('public.dim_genre_idgenre_seq_1'),
                genretype VARCHAR NOT NULL,
                CONSTRAINT dim_genre_pk PRIMARY KEY (idgenre)
);


ALTER SEQUENCE public.dim_genre_idgenre_seq_1 OWNED BY public.dim_genre.idgenre;

CREATE SEQUENCE public.dim_album_idalbum_seq_1;

CREATE TABLE public.dim_album (
                idalbum INTEGER NOT NULL DEFAULT nextval('public.dim_album_idalbum_seq_1'),
                releasemonthYearalbum TIMESTAMP NOT NULL,
                releasemonthalbum TIMESTAMP NOT NULL,
                releaseyearalbum VARCHAR NOT NULL,
                CONSTRAINT dim_album_pk PRIMARY KEY (idalbum)
);


ALTER SEQUENCE public.dim_album_idalbum_seq_1 OWNED BY public.dim_album.idalbum;

CREATE SEQUENCE public.dim_releasedatesong_idreleasedatesong_seq;

CREATE SEQUENCE public.dim_releaselocationsong_idreleaselocationsong_seq_1;

CREATE TABLE public.fct_song (
                idreleasedatesong INTEGER NOT NULL DEFAULT nextval('public.dim_releasedatesong_idreleasedatesong_seq'),
                idgenre INTEGER NOT NULL,
                idartistgroup VARCHAR NOT NULL,
                idmember VARCHAR NOT NULL,
                idreleaselocationsong INTEGER NOT NULL DEFAULT nextval('public.dim_releaselocationsong_idreleaselocationsong_seq_1'),
                idcover INTEGER NOT NULL,
                idalbum INTEGER NOT NULL,
                idlabels VARCHAR NOT NULL,
                numberReleasedCover INTEGER NOT NULL,
                numberArtist INTEGER NOT NULL,
                tempo INTEGER NOT NULL,
                energy REAL NOT NULL,
                danceability REAL NOT NULL,
                speechiness REAL NOT NULL,
                accoustiness REAL NOT NULL,
                loudness REAL NOT NULL,
                duration REAL NOT NULL,
                valence REAL NOT NULL,
                instrumentalness VARCHAR NOT NULL,
                titlesong VARCHAR NOT NULL,
                CONSTRAINT fct_song_pk PRIMARY KEY (idreleasedatesong, idgenre, idartistgroup, idmember, idreleaselocationsong, idcover, idalbum, idlabels)
);


ALTER SEQUENCE public.dim_releasedatesong_idreleasedatesong_seq OWNED BY public.fct_song.idreleasedatesong;

ALTER SEQUENCE public.dim_releaselocationsong_idreleaselocationsong_seq_1 OWNED BY public.fct_song.idreleaselocationsong;

ALTER TABLE public.fct_song ADD CONSTRAINT dim_labels_fct_song_fk
FOREIGN KEY (idlabels)
REFERENCES public.dim_labels (idlabels)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_song ADD CONSTRAINT dim_member_fct_song_fk
FOREIGN KEY (idmember)
REFERENCES public.dim_member (idmember)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_song ADD CONSTRAINT dim_cover_fct_song_fk
FOREIGN KEY (idcover)
REFERENCES public.dim_cover (idcover)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_song ADD CONSTRAINT dim_releaselocationsong_fct_song_fk
FOREIGN KEY (idreleaselocationsong)
REFERENCES public.dim_releaselocationsong (idreleaselocationsong)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_song ADD CONSTRAINT fct_song_dim_release_monthyear_song_fk
FOREIGN KEY (idreleasedatesong)
REFERENCES public.dim_releasedatesong (idreleasedatesong)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_song ADD CONSTRAINT dim_artistgroup_fct_song_fk
FOREIGN KEY (idartistgroup)
REFERENCES public.dim_artistgroup (idartistgroup)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_song ADD CONSTRAINT fct_song_dim_genre_fk
FOREIGN KEY (idgenre)
REFERENCES public.dim_genre (idgenre)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_song ADD CONSTRAINT dim_album_fct_song_fk
FOREIGN KEY (idalbum)
REFERENCES public.dim_album (idalbum)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
