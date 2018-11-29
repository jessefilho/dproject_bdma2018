#!/usr/bin/env python
# coding: utf-8
#python -m pip install create_engine
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import pandas as pd
import time 
from openpyxl import load_workbook
import os.path 
import psycopg2
import xlsxwriter
#import pgdb

hostname = '10.195.25.10'
username = 'userbkp'
password = 'goma123'
database = 'musicbrainz'
port='54587'
cid ="a154f4842df643a99f9057fb741c86e0" 
secret = "543080531fce4f30be3da2c36782ace1"

today_date=(time.strftime("%d_%m_%Y  %M_%S"))
date=(time.strftime("%d/%m/%Y"))
date_monthYear = (time.strftime("%m%Y"))
date_year = (time.strftime("%Y"))

filepath = 'F:\Documents\dproject_bdma2018\DATA'+today_date+'.xlsx'


checkifexist ="""SELECT id_msbz FROM public.stage_artist WHERE id_msbz ="""     
    


query = """SELECT distinct artist_table.name_group,
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
              ON musicbrainz.artist.id = musicbrainz.artist_credit_name.artist where musicbrainz.artist.type = 2) as artist_table
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

              WHERE artist_table.area is not null AND artist_table.begin_area is not null AND artist_table.area != artist_table.begin_area 
              """

client_credentials_manager = SpotifyClientCredentials(client_id=cid, client_secret=secret)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)



def doQuery( conn ) :
    
    cur = conn.cursor()
    cur.execute(query)
    return cur.fetchall()
 
def existsOnStageQuery( check_id ) :
    connec = psycopg2.connect( host=hostname, user=username, password=password, dbname='stages',port=port )
    cursor = connec.cursor()
    cursor.execute(checkifexist+str(check_id))
    print (cursor.rowcount)
    if cursor.rowcount == 0:
      
      cursor.close()
      connec.close()
      return False
    else:
      cursor.close()
      connec.close()
      return True

    
    
    
      
       
artist_musicbrainz =[]

myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
artist_musicbrainz = doQuery( myConnection )
myConnection.close()
# print size list



#Verify if File in certain date already exists
filename=filepath
if os.path.exists(filename):
    print(filename+' '+'exists')
    print("Extraction is starts...")
else: 
    # create empty lists where the results are going to be stored
    artist_name_group = []
    artist_id_msbz = []
    artist_id_member_position = []
    artist_id_type_group = []
    artist_id_country_origin =[]
    artist_country_origin =[]
    artist_id_city_origin = []
    artist_city_origin = []
    artist_gender_sex = []
    #spotify attributes
    artist_popularity = []
    artist_id_spotify = []
    artist_followers = []
    artist_type = []
    artist_genre = []
    artist_gender = []

 

    for i in range(0,len(artist_musicbrainz)-1,1):
        for name_group,id_msbz,id_member_position,id_type_group,id_country_origin,country_origin,id_city_origin,city_origin,gender_sex in artist_musicbrainz :
            track_results = sp.search(q=name_group, type='artist',market='FR', limit=50)
            #print (track_results)
            for i, t in enumerate(track_results):
              if  not track_results[t]['items']:
                  #print(track_results[t]['items'])
                  print('artiste non trouvé')
              elif (existsOnStageQuery(id_msbz)):
                  print "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ -----------------> I am already here. Rock n' Roll .... "
              else :
                  try:
                    print ('Into try')
                    stageConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname='stages',port=port )
                    cur = stageConnection.cursor()

                    print (track_results[t]['items'][0]['name']+", FROM ---->"+country_origin)

                    cur.execute("""INSERT INTO public.stage_artist(id_msbz, 
                                                                  name_group, 
                                                                  id_member_position, 
                                                                  id_type_group, 
                                                                  id_country_origin, 
                                                                  country_origin, 
                                                                  id_city_origin, 
                                                                  city_origin, 
                                                                  gender_sex, 
                                                                  popularity, 
                                                                  id_spotify, 
                                                                  followers, 
                                                                  genre,date_full,date_monthYear,date_year) 
                                                    VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)""", (id_msbz,
                                                      track_results[t]['items'][0]['name'],
                                                      id_member_position,
                                                      id_type_group,
                                                      id_country_origin,
                                                      country_origin,
                                                      id_city_origin, 
                                                      city_origin,
                                                      gender_sex,
                                                      track_results[t]['items'][0]['popularity'],
                                                      track_results[t]['items'][0]['id'],
                                                      track_results[t]['items'][0]['followers']['total'],
                                                      track_results[t]['items'][0]['genres'],
                                                      date,
                                                      date_monthYear,
                                                      date_year))
                    
                    cur.close()
                    stageConnection.commit()
                    stageConnection.close()

                    print ('finish -> connection')
                  except :                     
                  #   print e
                      print ('##IGNORED##')                    
                  
              

