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
	
	
	


def cloudWord(Text):

	# get data directory (using getcwd() is needed to support running example in generated IPython notebook)
	# d = path.dirname(__file__) if "__file__" in locals() else os.getcwd()

	# Read the whole text.
	# text = open(path.join(d, 'constitution.txt')).read()

	# Generate a word cloud image
	wordcloud = WordCloud().generate(Text)

	# Display the generated image:
	# the matplotlib way:
	
	plt.imshow(wordcloud, interpolation='bilinear')
	plt.axis("off")

	# lower max_font_size
	wordcloud = WordCloud(max_font_size=40).generate(Text)
	plt.figure()
	plt.imshow(wordcloud, interpolation="bilinear")
	plt.axis("off")
	



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

cloudWord(Text);
plt.show()




	
		
	


