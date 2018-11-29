#!/usr/bin/python
#python -m pip install request
import requests
import pandas as pd
import psycopg2
import time 
from sqlalchemy import create_engine

#https://secondhandsongs.com/search/performance?title=Simple+man&op_title=equals&covers&format=json --> busca pela musica, e depois filtra pelo artist. Limite de request
#musicBrainzCredentials
hostname = '10.195.25.10'
username = 'userbkp'
password = 'goma123'
database = 'dw'
port='54587'
secondhandsongs_url = 'https://secondhandsongs.com/search/performance?'
date_popularity=(time.strftime("%d/%m/%Y"))


Selectquery="""SELECT distinct id_song, artistgroup, title_song, popularity
FROM stages.stage_song
	INNER JOIN stages.stage_track_features_bkp
	ON id_song = track_id
	order by popularity desc ; """

def doQuery( conn ) :
    
    cur = conn.cursor()
    cur.execute(Selectquery)
    return cur.fetchall()

Insertquery="""INSERT INTO stages.stage_cover_bpk(id_song, artistgroup, title_song, cover_name) VALUES (%s, %s, %s, %s)
					ON CONFLICT (id_song) 
					   DO IGNORE;"""

def doInsertCover(id_song, artistgroup, title_song, cover_name) :
	myconnection =psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
	cur = myconnection.cursor()
	print("ok ok ok #########################")
	cur.execute(Insertquery,(id_song, artistgroup, title_song, cover_name))
	print("############### Into Insert")
	print(cur.rowcount)
	cur.close()
	myconnection.commit()
	myconnection.close()


myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
tracksFeatures_lists = doQuery( myConnection )
myConnection.close()
# print ('here ---> songs fetched from stages.stage_song')

id_tracksList = []

def callSecondhandsongs(song_title):
	# time.sleep(5)	
	# print " ######## callSecondhandsongs ########"
	#params = dict(title=, op_title='equals',covers='')
	resp = requests.get(url='https://secondhandsongs.com/search/performance?title='+song_title.replace(" ", "+")+'&op_title=equals&covers&format=json')
	print resp
	return resp.json() # Check the JSON Response Content documentation below


for id_song, artistgroup, title_song, popularity in tracksFeatures_lists:

	try:
		resultsPage = callSecondhandsongs(title_song)
		#print resultsPage['resultPage']
		for jsonItens in resultsPage['resultPage']:
				if jsonItens['isOriginal'] != 'True':			
					doInsertCover(id_song, artistgroup, title_song, jsonItens['performer']['name'])

	except Exception as e:
		print e
	


	