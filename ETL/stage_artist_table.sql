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


ALTER SEQUENCE datamarts_2.dim_artistgroup_skg_artistgrou_seq  RESTART WITH 1;
ALTER SEQUENCE datamarts_2.dim_releasedatesong_skg_releasedatesong_seq RESTART WITH 1;
ALTER SEQUENCE datamarts_2.dim_releaselocationsong_skg_releaselocationsong_seq RESTART WITH 1;
ALTER SEQUENCE datamarts_2.dim_album_skg_album_seq RESTART WITH 1;
ALTER SEQUENCE datamarts_2.bridge_cover_fctsong_skg_cover_fctsong_seq RESTART WITH 1;







SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'dw' AND pid <> pg_backend_pid()  AND state in ('idle');





SELECT distinct id_artistgroup, stages.stage_artists_spotify.popularity
FROM datamarts_2.dim_artistgroup_popartist
INNER JOIN stages.stage_artists_spotify
ON dim_artistgroup_popartist.id_artistgroup = stages.stage_artists_spotify.id_spotify



SELECT country_name_release_song, 
id_country_name_release_song,
(SELECT count(id_song) FROM stages.stage_cover where id_song =stage_song.id_song  group by id_song)
	FROM stages.stage_song;


	SELECT distinct track_id,
	(SELECT count(id_song) FROM stages.stage_cover where id_song =stage_track_features_bkp.track_id  group by id_song) as numberReleasedCover, 
	artist_id_spotify as numberArtist, tempo, energy, danceability,speechiness, acousticness, loudness, duration_ms as duration, valence, instrumentalness, track_name as titlesong
	FROM stages.stage_track_features_bkp;


SELECT track_id, artist_id_spotify as numberArtist, dim_artistgroup_song.skg_artistgroup_song, tempo, energy, danceability,speechiness, acousticness, loudness, duration_ms as duration, valence, instrumentalness, track_name as titlesong
FROM stages.stage_track_features_bkp
INNER JOIN datamarts_2.dim_artistgroup_song
ON stage_track_features_bkp.artist_id_spotify=dim_artistgroup_song.id_artistgroup;



INSERT INTO stages.stage_tag(
	release_name, tag_genre)
	VALUES SELECT release,r.name, tag,t.name
  FROM musicbrainz.release_tag rt ,musicbrainz.tag t,musicbrainz.release r
  where t.id=rt.tag and r.id=rt.release
  OR t.name like '%rock%'
  OR t.name like '%pop%'
  OR t.name like '%classical%'
  OR t.name like '%funk%'
  OR t.name like '%jazz%'
  OR t.name like '%blues%'
  OR t.name like '%reggea%'
  OR t.name like '%folk%'
  OR t.name like '%hiphop%'
  OR t.name like '%electronic%'
  OR t.name like '%country%'
  
  limit 2000;


INSERT INTO stages.stage_tag
  SELECT r.name,t.name,tag,release,
  FROM musicbrainz.release_tag rt ,musicbrainz.tag t,musicbrainz.release r
  where t.id=rt.tag and r.id=rt.release
  OR t.name like '%rock%'
  OR t.name like '%pop%'
  OR t.name like '%classical%'
  OR t.name like '%funk%'
  OR t.name like '%jazz%'
  OR t.name like '%blues%'
  OR t.name like '%reggea%'
  OR t.name like '%folk%'
  OR t.name like '%hiphop%'
  OR t.name like '%electronic%'
  OR t.name like '%country%'


(row12.name_tag != null && row12.name_tag.contains("rock")) ? "Rock" : 
(row12.name_tag.contains("folk")) ? "Folk":
(row12.name_tag.contains("pop")) ? "Pop":
(row12.name_tag.contains("classical")) ? "Classical":
(row12.name_tag.contains("funk")) ? "Funk":
(row12.name_tag.contains("jazz")) ? "Jazz":
(row12.name_tag.contains("blues")) ? "Blues":
(row12.name_tag.contains("reggea")) ? "Reggea":
(row12.name_tag.contains("hip hop")) ? "Hip Hop":
(row12.name_tag.contains("electronic")) ? "Electronic":
(row12.name_tag.contains("country")) ? "Country":
"Others"

(Var.transfer_genres.equals("Rock"))? 1 :
(Var.transfer_genres.equals("Folk"))? 2 :
(Var.transfer_genres.equals("Pop"))? 3 :
(Var.transfer_genres.equals("Classical"))? 4 :
(Var.transfer_genres.equals("Funk"))? 5 :
(Var.transfer_genres.equals("Jazz"))? 6 :
(Var.transfer_genres.equals("Blues"))? 7 :
(Var.transfer_genres.equals("Reggea"))? 8 :
(Var.transfer_genres.equals("Hip Hop"))? 9 :
(Var.transfer_genres.equals("Electronic"))? 10 :
(Var.transfer_genres.equals("Country"))? 11 :  0 


  "SELECT r.name,t.name,tag,release  
FROM musicbrainz.release_tag rt ,musicbrainz.tag t,musicbrainz.release r
where t.id=rt.tag and r.id=rt.release
limit 100"


SELECT *
FROM fct_song
RIGHT JOIN dim_album_song
ON fct_song.id_album = dim_album_song.id_album
RIGHT JOIN dim_releaselocationsong
ON fct_song.id_releaselocationsong = dim_releaselocationsong.id_releaselocationsong
RIGHT JOIN dim_artistgroup_song
ON fct_song.id_artistgroup = dim_releaselocationsong.id_artistgroup
RIGHT JOIN dim_releasedatesong
ON fct_song.id_releasedatesong = dim_releasedatesong.id_releasedatesong
RIGHT JOIN  dim_genre_song
ON fct_song.id_genre = dim_genre_song.id_genre
RIGHT JOIN bridge_cover_fctsong
ON fct_song.id_cover = bridge_cover_fctsong.id_cover