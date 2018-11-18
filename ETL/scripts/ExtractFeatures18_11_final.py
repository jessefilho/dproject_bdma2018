#!/usr/bin/env python
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
database = 'stages'
port='54587'

date_popularity=(time.strftime("%d/%m/%Y"))

cid ="a154f4842df643a99f9057fb741c86e0" 
secret = "543080531fce4f30be3da2c36782ace1"

client_credentials_manager = SpotifyClientCredentials(client_id=cid, client_secret=secret)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

query = """ SELECT artist_name, artist_id_msbz, artist_id_spotify, album_id, album_name FROM public.stage_album ; """

queryInsert=""" INSERT INTO public.stage_track_features(
            artist_id_spotify, artist_id_msbz, artist_name, album_id, album_name, 
            track_id, track_name, popularity, date_popularity, acousticness, 
            danceability, duration_ms, energy, instrumentalness, key_f, liveness, 
            loudness, mode_f, speechiness, tempo, time_signature, valence)
    VALUES (%s, %s, %s, %s, %s, 
            %s, %s, %s, %s, %s, 
            %s, %s, %s, %s, %s, %s, %s, 
            %s, %s, %s,%s, %s);

"""

def doQuery( conn ) :
    
    cur = conn.cursor()
    cur.execute(query)
    return cur.fetchall()

def doInsertTracks(artist_id_spotify, artist_id_msbz, artist_name, album_id, album_name, 
            track_id, track_name, popularity, date_popularity, acousticness, 
            danceability, duration_ms, energy, instrumentalness, key_f, liveness, 
            loudness, mode_f, speechiness, tempo, time_signature, valence) :
    myconnection =psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
    cur = myconnection.cursor()
    cur.execute(queryInsert,(artist_id_spotify, artist_id_msbz, artist_name, album_id, album_name, 
            track_id, track_name, popularity, date_popularity, acousticness, 
            danceability, duration_ms, energy, instrumentalness, key_f, liveness, 
            loudness, mode_f, speechiness, tempo, time_signature, valence))
    cur.close()
    myconnection.commit()
    myConnection.close()

myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
album_lists = doQuery( myConnection )
myConnection.close()
print ('here')


for i in range(0,len(album_lists)-1,1):
    print ('*here')
    print(i)
    for artist_name, artist_id_msbz, artist_id_spotify, album_id, album_name in album_lists : 
        track_results=sp.album_tracks(album_id ,limit=20, offset=0)
        for i, t in enumerate(track_results['items']):
            print ('**here')
            track_name=t['name'] #track name
            print(t['name']) #track name
            print(artist_name) #artist name
            print(album_name)#album name
            track_id=t['id']#track id 
            print(t['id']) #track id 
            print('**here')
            track_features=sp.audio_features(t['id'])
            track_populartiy=sp.track(t['id'])
            popularity =track_populartiy['popularity']
            for r in track_features:
                doInsertTracks(artist_id_spotify, artist_id_msbz,artist_name, album_id, album_name,track_id,track_name,popularity,
                               date_popularity,r['acousticness'],r['danceability'],r['duration_ms'],r['energy'],r['instrumentalness'],
                               r['key'],r['liveness'],r['loudness'],r['mode'],r['speechiness'],r['tempo'],r['time_signature'],r['valence'])
  

