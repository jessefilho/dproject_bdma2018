#!/usr/bin/env python
# coding: utf-8

# In[66]:


import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import pandas as pd
import time 
from openpyxl import load_workbook
import os.path 
import psycopg2
import pgdb

hostname = '10.195.25.10'
username = 'postgres'
password = '123'
database = 'musicbrainz'
port='54587'
cid ="a154f4842df643a99f9057fb741c86e0" 
secret = "543080531fce4f30be3da2c36782ace1"

client_credentials_manager = SpotifyClientCredentials(client_id=cid, client_secret=secret)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

today_date=(time.strftime("%d_%m_%Y"))
date=(time.strftime("%d/%m/%Y"))

def doQuery( conn ) :
    
    cur = conn.cursor()
    cur.execute( "SELECT  name , 'x' FROM musicbrainz.artist where area = 73 group by name limit 10" )
    return cur.fetchall()
 
    
artist_musicbrainz =[]
myConnection = psycopg2.connect( host=hostname, user=username, password=password, dbname=database,port=port )
artist_musicbrainz =doQuery( myConnection )
myConnection.close()
# print size list



#Verify if File in certain date already exists
filename='D:\ProjetDecisonnel\Artistsout'+today_date+'.xlsx'
if os.path.exists(filename):
    print(filename+' '+'exists')
else: 
    # create empty lists where the results are going to be stored
    artist_name = []
    artist_genre= []
    artist_popularity = []
    artist_id = []
    artist_followers = []
    artist_x = []
 
    for i in range(0,len(artist_musicbrainz)-1,1):
        for name,x in artist_musicbrainz :
            track_results = sp.search(q=name, type='artist',market='FR', limit=50)
           # print (track_results)
            
            if  not track_results[t]['items'] :
                print(track_results[t]['items'])
                print('artiste non trouvé')
        
            else : 
                #print (track_results)
                for i, t in enumerate(track_results):
                    print (track_results[t]['items'][0]['name'])                    
                    artist_name.append(track_results[t]['items'][0]['name'])
                    artist_genre.append(track_results[t]['items'][0]['genres'])
                    artist_popularity.append(track_results[t]['items'][0]['popularity'])
                    artist_id.append(track_results[t]['items'][0]['id'])
                    artist_followers.append(track_results[t]['items'][0]['followers']['total'])
                    artist_x.append(x)
                    
                    
                    print ('finish')
                print ('finish for')
                df_tracks = pd.DataFrame({'artist_name':artist_name,
                                          'artist_genre':artist_genre,
                                          'artist_popularity':artist_popularity,
                                          'artist_id.':artist_id,
                                          'Date':date,
                                          'artist_followers':artist_followers,
                                          'x': artist_x
                                         })

  
                  #Create xlsx File 
                writer = pd.ExcelWriter(filename, engine='xlsxwriter')
                df_tracks.to_excel(writer,encoding='utf8')
                writer.save()
        


# In[20]:





# In[ ]:




