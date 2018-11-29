#!/usr/bin/python
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import pandas as pd
import psycopg2
import time 
from sqlalchemy import create_engine

#musicBrainzCredentials
hostname = '10.195.25.10'
username = 'userbkp'
password = 'goma123'
database = 'dw'
port='54587'

date_popularity=(time.strftime("%d/%m/%Y"))

cid ="2bd34bb428a8456abb5d3ef8c1fd1580" 
secret ="4bbed5c375e840d68b6c00df0cea790a"


client_credentials_manager = SpotifyClientCredentials(client_id=cid, client_secret=secret)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

Selectquery="""SELECT id_spotify_artist, name_artist, id_album, name_album, date_release
FROM stages.stage_albums  limit5 ;
"""

def doQuery( conn ) :
    
    cur = conn.cursor()
    cur.execute(Selectquery)
    return cur.fetchall()

Insertquery="""INSERT INTO stages.stage_track_features_bkp(
            artist_id_spotify, artist_name, album_id, album_name, track_id, 
            track_name, date_release, popularity, date_popularity, acousticness, 
            danceability, duration_ms, energy, instrumentalness, key_f, liveness, 
            loudness, mode_f, speechiness, tempo, time_signature, valence)
    VALUES (%s, %s, %s, %s, %s, 
            %s, %s, %s, %s, %s, 
            %s, %s, %s, %s, %s, %s, 
            %s, %s, %s, %s, %s, %s);
"""

def doInsertTracks(artist_id_spotify, artist_name, album_id, album_name, 
            track_id, track_name,date_release, popularity, date_popularity, acousticness, 
            danceability, duration_ms, energy, instrumentalness, key_f, liveness, 
            loudness, mode_f, speechiness, tempo, time_signature, valence) :
	myconnection =psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
	cur = myconnection.cursor()
	print("ok ok ok #########################")
	cur.execute(Insertquery,(artist_id_spotify, 
		artist_name, 
		album_id, 
		album_name,
		track_id, 
		track_name,
		date_release,
		popularity,
		date_popularity,
		acousticness,
		danceability,
		duration_ms,
		energy,
		instrumentalness,
		key_f,
		liveness,
		loudness, 
		mode_f, 
		speechiness, 
		tempo, 
		time_signature, 
		valence))
	print("###############")
	print(cur.rowcount)
	cur.close()
	myconnection.commit()
	myconnection.close()


myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
albums_lists = doQuery( myConnection )
myConnection.close()
print ('here')

id_tracksList = []

for id_spotify_artist, name_artist, id_album, name_album,date_release in albums_lists:
	track_results = sp.album_tracks(album_id=id_album, limit=10, offset=0)
	
	for i,t in enumerate(track_results['items']):
		
		print ('**here')
		print(t['id']) #track id 
		track_name= t['name'] #track name
		print('######### >>>>>>>>>>>>>>>>><'+t['name']) #track name
		track_id=t['id']#track id

		track_populartiy = sp.track(t['id'])
		#sex lines
		id_tracksList.append(t['id'])
		track_features = sp.audio_features(id_tracksList)
		del id_tracksList[-1]
		popularity = track_populartiy['popularity']
		print track_features
	
	
	# track_features = sp.audio_features(id_tracksList)
		
		# print(track_features)
		for r in track_features:			
			try:
				print(r)
				doInsertTracks(id_spotify_artist,
								name_artist, 
								id_album,  
								name_album,
								track_id,
								track_name,
								date_release,
								popularity,
								date_popularity,
								r['acousticness'],
								r['danceability'],
								r['duration_ms'],
								r['energy'],
								r['instrumentalness'],
								r['key'],
								r['liveness'],
								r['loudness'],
								r['mode'],
								r['speechiness'],
								r['tempo'],
								r['time_signature'],
								r['valence'])
			except Exception as e:
				print e