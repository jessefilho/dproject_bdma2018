
CREATE SEQUENCE public.dim_popularitydate_id_popularitydate_seq;

CREATE TABLE public.dim_popularitydate (
                id_popularitydate INTEGER NOT NULL DEFAULT nextval('public.dim_popularitydate_id_popularitydate_seq'),
                popularitymonthYear TIMESTAMP NOT NULL,
                popularitymonth TIMESTAMP NOT NULL,
                popularityyear TIMESTAMP NOT NULL,
                CONSTRAINT dim_popularitydate_pk PRIMARY KEY (id_popularitydate)
);


ALTER SEQUENCE public.dim_popularitydate_id_popularitydate_seq OWNED BY public.dim_popularitydate.id_popularitydate;

CREATE TABLE public.dim_member (
                id_member INTEGER NOT NULL,
                member VARCHAR NOT NULL,
                position VARCHAR NOT NULL,
                CONSTRAINT dim_member_pk PRIMARY KEY (id_member)
);


CREATE TABLE public.dim_artistgroup (
                id_artistgroup INTEGER NOT NULL,
                artistgroup VARCHAR NOT NULL,
                cityoriginartist VARCHAR NOT NULL,
                id_cityoriginartist VARCHAR NOT NULL,
                countryoriginartist VARCHAR NOT NULL,
                id_countryoriginartist VARCHAR NOT NULL,
                typegroup VARCHAR NOT NULL,
                id_typegroup VARCHAR NOT NULL,
                CONSTRAINT dim_artistgroup_pk PRIMARY KEY (id_artistgroup)
);


CREATE TABLE public.fct_popularityArtist (
                id_artistgroup INTEGER NOT NULL,
                id_member INTEGER NOT NULL,
                id_popularitydate INTEGER NOT NULL,
                popularityArtist VARCHAR NOT NULL,
                CONSTRAINT fct_popularityartist_pk PRIMARY KEY (id_artistgroup, id_member, id_popularitydate)
);


ALTER TABLE public.fct_popularityArtist ADD CONSTRAINT dim_popularitydata_fct_popularityartist_fk
FOREIGN KEY (id_popularitydate)
REFERENCES public.dim_popularitydate (id_popularitydate)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_popularityArtist ADD CONSTRAINT dim_member_fct_popularityartist_fk
FOREIGN KEY (id_member)
REFERENCES public.dim_member (id_member)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fct_popularityArtist ADD CONSTRAINT dim_artistgroup_fct_popularityartist_fk
FOREIGN KEY (id_artistgroup)
REFERENCES public.dim_artistgroup (id_artistgroup)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
