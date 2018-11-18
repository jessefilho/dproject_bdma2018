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

#SpotifyCredentials
cid ="5f0b01a1813a41d1b360ed91e890a93f" 
secret ="39877ef7e0a9467db85353f6090b0cbd"

#Declaration
today_date=(time.strftime("%d_%m_%Y"))
date=(time.strftime("%d_%m_%Y"))

client_credentials_manager = SpotifyClientCredentials(client_id=cid, client_secret=secret)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

# Request MusicBrainz For artists using stage_artist
querySelect = """ SELECT id_msbz,id_spotify, name_group FROM public.stage_artist ; """


def doReturnArtists( conn ) :
    
    cur = conn.cursor()
    cur.execute(querySelect)
    return cur.fetchall()

# Insert Albums in stage_Album
queryInsert= """INSERT INTO public.stage_album (artist_name,artist_id_msbz,artist_id_spotify,album_id,album_name,nb_tracks_album) values(%s,%s,%s,%s,%s,%s)"""

def doInsertAlbums( artist_id_spotify,artist_id_msbz,artist_name,album_id,album_name,nb_tracks_album) :
    myconnection =psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
    cur = myconnection.cursor()
    cur.execute(queryInsert,(artist_id_spotify,artist_id_msbz,artist_name,album_id,album_name,nb_tracks_album))
    cur.close()
    myconnection.commit()
    myConnection.close()

myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
artist_musicbrainz = doReturnArtists( myConnection )
myConnection.close()
print ('here')

# create empty lists where the results are going to be stored
artist_namelist = []
artist_id_msbzlist= []
artist_id_spotifylist = []
album_idlist = []
nb_tracks_albumlist=[]
for i in range(0,len(artist_musicbrainz)-1,1):
    print ('*here')
    for id_msbz,id_spotify, name_group in artist_musicbrainz : 
        print(id_spotify)
        albums_results=sp.artist_albums(id_spotify,album_type='album', limit=20, offset=0)
        for i, t in enumerate(albums_results['items']):
            print ('**here')
            print (t['id'])
            artist_namelist.append(name_group)
            artist_id_msbzlist.append(id_msbz)
            artist_id_spotifylist.append(id_spotify)
            album_idlist.append (t['id'])
            nb_tracks_albumlist.append(t['total_tracks'])
            print (t['total_tracks'])
            doInsertAlbums(name_group,id_msbz,id_spotify,t['id'],t['name'],t['total_tracks'])
            print('Inserted**')

