SELECT distinct artist_table.name_group,
		  artist_table.id as id_msbz,
		  artist_table.position as id_member_position,
		  artist_table.type as id_type_group, 
		  artist_table.area as id_country_origin, 
		  area_table.countrycity_name as country_origin,
		  artist_table.begin_area as id_city_origin ,
		  (SELECT musicbrainz.area.name FROM musicbrainz.area WHERE musicbrainz.area.id = artist_table.begin_area AND musicbrainz.area.type = 3) as city_origin,
		  gender_table.name as gender_sex

		  FROM (SELECT musicbrainz.artist.name as name_group,* 
			FROM musicbrainz.artist
			INNER JOIN musicbrainz.artist_credit_name
		  ON musicbrainz.artist.id = musicbrainz.artist_credit_name.artist ) as artist_table
		  LEFT JOIN musicbrainz.gender as gender_table
		  ON artist_table.gender = gender_table.id
		  INNER JOIN (select musicbrainz.area.id as id_area, musicbrainz.area.name as countrycity_name, musicbrainz.area_type.name as countrycity_type
				FROM musicbrainz.area
				INNER JOIN musicbrainz.area_type
				on musicbrainz.area.type = musicbrainz.area_type.id
				INNER JOIN (SELECT musicbrainz.area_alias.area as id_area FROM musicbrainz.area_alias WHERE musicbrainz.area_alias.locale = 'en') as area_alias_table
				on musicbrainz.area.id = area_alias_table.id_area
				where musicbrainz.area_type.id = 1) as area_table
		  ON artist_table.area = area_table.id_area
			
		  group by artist_table.name_group,
		  id_msbz,
		  id_member_position,
		  id_type_group, 
		  id_country_origin, 
		  country_origin,
		  id_city_origin ,
		  city_origin,
		  gender_sex
		  
		  HAVING artist_table.area is not null AND 
		  artist_table.begin_area is not null AND 
		  artist_table.area != artist_table.begin_area AND
		  artist_table.name_group in (select distinct name from stages.stage_artists_spotify)
		  
		  
		  limit 100




INSERT INTO estages.stage_cover(id_song, artistgroup, title_song, cover_name) VALUES (%s, %s, %s, %s)
ON CONFLICT id_song IGNORE;

SELECT distinct id_song
WHERE NOT EXISTS (
        SELECT id_song FROM stage_cover WHERE id_song = id_song
    );

    SELECT distinct id_song, artistgroup, title_song, popularity
FROM stages.stage_song
	INNER JOIN stages.stage_track_features_bkp
	ON id_song = track_id
	order by popularity desc

INSERT INTO stages.stage_cover(id_song, artistgroup, title_song, cover_name)
				VALUES (%s, %s, %s, %s);



SELECT id_artistgroup, id_date, stages.popularity
FROM dim_artistgroup
INNER JOIN
ON dim_artistgroup.id_artistgroup = stages.stage_artists_spotify



SELECT distinct id_artistgroup, artistgroup, cityoriginartist, 
id_cityoriginartist, countryoriginartist, id_countryoriginartist, typegroup, id_typegroup,data_popularity

FROM stages.stage_song 
INNER JOIN stages.stage_artists_spotify
ON stages.stage_song.id_artistgroup = stages.stage_artists_spotify.id_spotify



ALTER SEQUENCE datamarts_2.dim_artistgroup_dim_artistgroup_seq  RESTART WITH 1;
ALTER SEQUENCE datamarts_2.dim_artistgroup_dim_artistgroup_seq_1  RESTART WITH 1;
ALTER SEQUENCE datamarts_2.dim_popularitydate_artist_sgk_popularitydate_popartist_seq  RESTART WITH 1;
ALTER SEQUENCE datamarts_2.fct_popularityartist_id_popularitydate_seq  RESTART WITH 1;


SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'dw' AND pid <> pg_backend_pid()  AND state in ('idle');





SELECT distinct id_artistgroup, stages.stage_artists_spotify.popularity
FROM datamarts_2.dim_artistgroup_popartist
INNER JOIN stages.stage_artists_spotify
ON dim_artistgroup_popartist.id_artistgroup = stages.stage_artists_spotify.id_spotify
