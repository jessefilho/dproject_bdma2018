#!/usr/bin/python
#python -m pip install -U textblob

from PyLyrics import *
from collections import Counter
from textblob import TextBlob
from textblob.sentiments import NaiveBayesAnalyzer
import matplotlib.pyplot as plt
import os
from os import path
from wordcloud import WordCloud
import numpy as np
import csv

Text=""
spamreader = []
file = 'pop_song_200.csv'

polarity_subj_PatternAnalyzer = []
pos_neg_NaiveBayesAnalyzer = []
			
			 

# Cleaning text and lower casing all words
for char in '-.,\n':
    Text=Text.replace(char,' ')

def bobAnalyzerTextNaiveBayesAnalyzer(Text):
	blob = TextBlob(Text, analyzer=NaiveBayesAnalyzer())
	print blob.sentiment	
	return blob.sentiment

def bobAnalyzerTextPatternAnalyzer(Text):	
	blob2 = TextBlob(Text)
	print blob2.sentiment
	return blob2.sentiment
	
def bubbles():
	fig, ax = plt.subplots()
	scale = 500.0
	for sentimentList in polarity_subj_PatternAnalyzer:
		x = sentimentList.polarity
		y = sentimentList.subjectivity
		print x
		print y
		if (x < 0.0):
			ax.scatter(x, y, c='red', s=scale, label='red',alpha=0.3, edgecolors='none')			
		if (x >= 0.0 and x <= 0.1):
			ax.scatter(x, y, c='yellow', s=scale, label='yellow',alpha=0.3, edgecolors='none')			
			
		if (x > 0.1 and x <= 0.5):
			ax.scatter(x, y, c='green', s=scale, label='green',alpha=0.3, edgecolors='none')			
			
		if (x > 0.5):
			ax.scatter(x, y, c='blue', s=scale, label='blue',alpha=0.3, edgecolors='none')
	ax.grid(True)

	# ax.legend()
					



with open(file, 'rb') as csvfile:
		spamreader = csv.reader(csvfile, delimiter=',', quotechar='"')
		for row in spamreader:
			
			try:
				Text = Text +' '+ PyLyrics.getLyrics(row[0],row[1]).encode('utf-8','ignore').lower()
				polarity_subj_PatternAnalyzer.append(bobAnalyzerTextPatternAnalyzer(PyLyrics.getLyrics(row[0],row[1]).encode('utf-8','ignore').lower()));
				# pos_neg_NaiveBayesAnalyzer.append(bobAnalyzerTextNaiveBayesAnalyzer(PyLyrics.getLyrics(row[0],row[1]).encode('utf-8','ignore').lower()));
			except Exception as e:
				print e

print "AQUI"

# cloudWord(Text);
print "chamando cloudWord";
bubbles();
plt.show()





	










# word_list = Text.split()


# Counter(word_list).most_common()
# Initializing Dictionary
# d = {}

# # counting number of times each word comes up in list of words (in dictionary)
# for word in word_list: 
#     d[word] = d.get(word, 0) + 1

# word_freq = []
# for key, value in d.items():
#     word_freq.append((value, key))

# Initializing Dictionary
# d = {}

# # Count number of times each word comes up in list of words (in dictionary)
# for word in word_list:
#     if word not in d:
#         d[word] = 0
#     d[word] += 1

# word_freq = []
# for key, value in d.items():
#     word_freq.append((value, key))
# word_freq.sort(reverse=True)


# # print word_freq

# count = 0
# for word in word_freq :
# 	count+=1
# 	if count <= 5:
# 		print word[1]
		
	
		
	


