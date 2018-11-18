#!/usr/bin/env python
# coding: utf-8

#!/usr/bin/env python
# coding: utf-8

# In[19]:

import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import pandas as pd
import time 
from openpyxl import load_workbook
import os.path 

cid ="a154f4842df643a99f9057fb741c86e0" 
secret = "543080531fce4f30be3da2c36782ace1"

client_credentials_manager = SpotifyClientCredentials(client_id=cid, client_secret=secret)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

today_date=(time.strftime("%d_%m_%Y"))
date=(time.strftime("%d/%m/%Y"))

#Verify if File in certain date already exists
filename='D:\ProjetDecisonnel\AudioFeatures'+today_date+'.xlsx'
if os.path.exists(filename):
    print(filename+' '+'exists')
else :
    # create empty lists where the results are going to be stored
    artist_name = []
    track_name = []
    popularity = []
    track_id = []
    for i in range(0,10000,50):
        track_results = sp.search(q='year:2014-2018', type='track', limit=50,offset=i)
        for i, t in enumerate(track_results['tracks']['items']):
            artist_name.append(t['artists'][0]['name'])
            track_name.append(t['name'])
            track_id.append(t['id'])
            popularity.append(t['popularity'])
    df_tracks = pd.DataFrame({'artist_name':artist_name,'track_name':track_name,'track_id':track_id,'popularity':popularity,'date':date})
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
    #Create xlsx File 
    writer = pd.ExcelWriter(filename, engine='xlsxwriter')
    df.to_excel(writer,encoding='utf8')
    writer.save()

    #df.to_csv('D:\ProjetDecisonnel\SpotifyAudioFeatures20142018')
    #print ('finish')
