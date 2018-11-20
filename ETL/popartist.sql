-- DROP TABLE datamart_popularityartist.fct_popularityartist;

CREATE TABLE datamarts.fct_popularityartist
(
    id_popularitydate integer,
    popularityartist integer,
    id_artistgroup integer,
    
)


-- Table: datamart_popularityartist.dim_popularitydate

-- DROP TABLE datamart_popularityartist.dim_popularitydate;

CREATE TABLE datamart_popularityartist.dim_popularitydate
(
    id_popularitydate integer, --  NOT NULL DEFAULT nextval('datamart_popularityartist.dim_popularitydate_id_popularitydate_seq'::regclass),
    popularitymonthyear character varying ,
    popularitymonth character varying,
    popularityyear character varying,    
)


    -- Table: datamart_popularityartist.dim_member

-- DROP TABLE datamart_popularityartist.dim_member;

CREATE TABLE datamarts.dim_member
(
    
    id_member integer,
    member character varying ,
    position character varying
    
)

-- Table: datamart_popularityartist.dim_artistgroup

-- DROP TABLE datamart_popularityartist.dim_artistgroup;

CREATE TABLE datamarts.dim_artistgroup
(
    id_artistgroup integer,
    artistgroup character varying 
    cityoriginartist character varying 
    id_cityoriginartist character varying 
    countryoriginartist character varying 
    id_countryoriginartist character varying 
    typegroup character varying 
    id_typegroup character varying 
)

-- Table: datamart_popularityartist.bridge_member

-- DROP TABLE datamart_popularityartist.bridge_member;

CREATE TABLE datamart_popularityartist.bridge_member
(
    
    dim_member integer ,
    weight_member character varying,
    id_member integer,
    id_artistgroup integer
    
)
