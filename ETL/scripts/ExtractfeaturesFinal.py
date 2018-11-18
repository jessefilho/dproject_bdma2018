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
today_date=(time.strftime("%d_%m_%Y"))
date=(time.strftime("%d_%m_%Y"))
#SpotifyCredentials
cid ="5f0b01a1813a41d1b360ed91e890a93f" 
secret ="39877ef7e0a9467db85353f6090b0cbd"

client_credentials_manager = SpotifyClientCredentials(client_id=cid, client_secret=secret)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

# Request MusicBrainz For Frensh artists using StageArtist
query = """ SELECT id_msbz, name_group, id_spotify FROM public.stage_artist; """

queryInsert=""" INSERT INTO public.stage_track (artist_id_spotify,
artist_id_msbz,
artist_name,
track_name,
track_id,
popularity,
date_popularity ) values (%s,%s,%s,%s,%s,%s,%s)"""

queryInsertFeatures =""" INSERT INTO stage_track_features(artist_id_spotify,
artist_id_msbz,
artist_name,
track_name,
track_id,
popularity,
date_popularity,
acousticness,
danceability,
duration_ms,
energy,
instrumentalness,
key,
liveness,
loudness,
mode,
speechiness,
tempo,
time_signature,
valence ) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"""

def doQuery( conn ) :
    
    cur = conn.cursor()
    cur.execute(query)
    return cur.fetchall()


def doInsertTracks( artist_id_spotify,artist_id_msbz,artist_name,track_name,track_id,popularity,date_popularity) :
    myconnection =psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
    cur = myconnection.cursor()
    cur.execute(queryInsert,(artist_id_spotify,artist_id_msbz,artist_name,track_name,track_id,popularity,date_popularity))
    cur.close()
    myconnection.commit()
    myConnection.close()

def doInsertTrackFeatures (artist_id_spotify,artist_id_msbz,artist_name,track_name,track_id,popularity,
                           date_popularity,acousticness, danceability, duration_ms, 
                           energy, instrumentalness, key, liveness, loudness, mode, speechiness, 
                           tempo, time_signature, valence) :
    myconnection =psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
    cur = myconnection.cursor()
    cur.execute(queryInsertFeatures,(artist_id_spotify,artist_id_msbz,artist_name,track_name,track_id,popularity,
               date_popularity,acousticness, danceability, duration_ms, 
               energy, instrumentalness, key, liveness, loudness, mode, speechiness, 
                tempo, time_signature, valence))
    cur.close()
    myconnection.commit()
    myConnection.close()

 
artist_musicbrainz =[]
myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
artist_musicbrainz = doQuery( myConnection )
myConnection.close()


print ('je suis ici')
    
# create empty lists where the results are going to be stored
artist_name = []
track_name = []
popularity = []
track_id = []
artist_id_spotifylist=[]
artist_id_msbzlist=[]
for i in range(0,len(artist_musicbrainz)-1,1):
    print ('je suis ici*')
    for id_msbz,name_group,id_spotify in artist_musicbrainz : 
        track_results = sp.search(q=name_group, type='track', limit=5,offset=i)
        for i, t in enumerate(track_results['tracks']['items']):
            print ('je suis ici **')
            artist_id_spotifylist.append(id_spotify)
            artist_id_msbzlist.append(id_msbz)
            artist_name.append(t['artists'][0]['name'])
            track_name.append(t['name'])
            print (t['name'])
            track_id.append(t['id'])
            popularity.append(t['popularity'])
            doInsertTracks(id_spotify,id_msbz,t['artists'][0]['name'],t['name'],t['id'],t['popularity'],date)
            print('Inserted ***')
        df_tracks = pd.DataFrame({'artist_id_spotify':artist_id_spotifylist,'artist_id_msbz':artist_id_msbzlist,'artist_name':artist_name,'track_name':track_name,'track_id':track_id,'popularity':popularity,'date_popularity':date})

rows = []
batchsize = 100
None_counter = 0
for i in range(0,len(df_tracks['track_id']),batchsize):
    batch = df_tracks['track_id'][i:i+batchsize]
    feature_results = sp.audio_features(batch)
    for i, t in enumerate(feature_results):
        if t == None:
            None_counter = None_counter + 1
        else:
            rows.append(t)
            
print('Number of tracks where no audio features were available:',None_counter)
df_audio_features = pd.DataFrame.from_dict(rows,orient='columns')
columns_to_drop = ['analysis_url','track_href','type','uri']
df_audio_features.drop(columns_to_drop, axis=1,inplace=True)
df_audio_features.rename(columns={'id': 'track_id'}, inplace=True)
# merge both dataframes
# the 'inner' method will make sure that we only keep track IDs present in both datasets
df = pd.merge(df_tracks,df_audio_features,on='track_id',how='inner')

#put the result in database 
print('now Im inserting into table ')


for index, row in df.iterrows():
    doInsertTrackFeatures(row['artist_id_spotify'],row['artist_id_msbz'],row['artist_name'],row['track_name'],row['track_id'],row['popularity'],row['date_popularity'],row['acousticness'],
                         row['danceability'],row['duration_ms'],row['energy'],row['instrumentalness'],row['key'],row['liveness'],row['loudness'],row['mode'],row['speechiness'],row['tempo'],row['time_signature'],row['valence'])


