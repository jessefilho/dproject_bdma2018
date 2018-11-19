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

querySelect = """ SELECT distinct artist_id_spotify FROM public.stage_track_features ; """
queryInsert=""" INSERT INTO public.stage_artist_spotify(id_spotify, name_artistgroup)VALUES (%s, %s);"""

def doQuery( conn ) :
    
    cur = conn.cursor()
    cur.execute(querySelect)
    return cur.fetchall()


def doInsertArtists( id_spotify, name_artistgroup) :
    myconnection =psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
    cur = myconnection.cursor()
    cur.execute(queryInsert,(id_spotify, name_artistgroup))
    cur.close()
    myconnection.commit()
    myConnection.close()

artist_musicbrainz =[]
myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
artist_musicbrainz = doQuery( myConnection )
myConnection.close()


for i in range(0,len(artist_musicbrainz)-1,1):
    print ('je suis ici*')
    for artist_id_spotify in artist_musicbrainz: 
    	print(artist_id_spotify[0])
    	artist_results = sp.artist(artist_id_spotify[0])

    	doInsertArtists(artist_results['id'],artist_results['name'])


