import sounddevice as sd    
from scipy.io.wavfile import write, read
import glob
import os
import random
if not os.path.exists('audio'):
    os.makedirs('audio')

def record(file_name, letter):
    fs = 16000  # Sample rate
    if letter == 'sentence':
        seconds = random.randint(800, 1100)*0.01  # Duration of recording
    else:
        seconds = random.randint(100,200)*0.01
    if letter == 'sentence':
        print("\nSentence : I'm registered with speech technology course and recording this data for course project")
    s = input('Press enter and speak "{} ({} seconds)" ! Enter q to quit!'.format(letter, seconds))
    if s == 'q':
        return False
    else:
        print('recording...')
        myrecording = sd.rec(int(seconds * fs), samplerate=fs, channels=1, dtype='int16')
        sd.wait()  # Wait until recording is finished
        write('./audio/{}.wav'.format(file_name), fs, myrecording)  # Save as WAV file 
        open('last.txt','w').write(letter)
        print(file_name, 'recorded')
        return True

fl = 0
while fl == 0:      
    aa = list('aeiou0123456789') + ['sentence']
    try:
        lst = open('last.txt','r').read()
    except FileNotFoundError:
        open('last.txt','w').write('sentence')
        lst = 'sentence'
    c = aa.index(lst)+1
    aa = aa[c:] + aa[:c] 
    
    for let in aa:
        files = glob.glob('./audio/194102323_{}_*'.format(let))
        if files !=[]:
            d = max([int(x.split('\\')[-1].split('.')[0][-1]) for x in files])
        else:
            d = 0
        name = '194102323_{}_{}'.format(let, d+1)
        if(not record(name, let)):
            fl = 1
            break
        
