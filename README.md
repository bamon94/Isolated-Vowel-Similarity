# Isolated-Vowel-Similarity
DTW scores for each vowel against recordings of same vowel and that with different vowels for generating similarity scores.

# Methodology
Twenty five utterances each for the vowels (a,e,i,o,u) and the numbers (from0-9)and a sentenceare recorded and saved as .wav file. Mfcc features of these recordings are computed and saved in a corresponding 2 dimensional matrix where in, each data(feature vector)comprises of stacked up Mfcc,delta and double delta coefficients. DTW scores for each vowel against recordings of same vowel and that with different vowels are computed and corresponding plots are recorded.

# Results
Smilar vowel utterances usually have lower distances as indicated in the plots. <br/> <br/>
![Alt text](Vowel-Similarity-Plot.PNG?raw=true "Title")
