 clc;
clear all;
close all;

%get the audio files
folder='\1\record\audio';
curDir = mfilename('fullpath');
folder = strcat(curDir(1:end-3),folder);
audio_files=dir(fullfile(folder,'*.wav'));
C = {};
fs = 16000;
%filenames format [*reference vowel*,*similar vowel 1*,*similar vowel 2*,*dissimilar vowel 1*, *dissimilar vowel 2*]
filenames = ["194102304_a_9.wav","194102304_a_10.wav","194102304_a_11.wav","194102304_e_8.wav","194102304_u_8.wav"];

%extract the mfcc features and store it in C( a cell variable)
for k = 1:numel(audio_files)
  filename = audio_files(k).name;
  fullFileName = fullfile(folder,filename);
  audio = audioread(fullFileName);
  audio = (1/max(audio(:))).* audio;
  [coeffs,delta,deltaDelta] = (mfcc(audio,fs));
  l = size(coeffs);
  featureVector = zeros(l(1),39);  
  featureVector(:,1:13) = coeffs(:,2:14);
  featureVector(:,14:26) = delta(:,2:14);
  featureVector(:,27:39) = deltaDelta(:,2:14);
  C{1,end+1} = filename;
  C{2,end} = featureVector;
end


%Estimate DTW scores of reference against compare variables
%for count 1- reference is picked
%for count- 2,3 similar vowel DTW scores are computed
%for other for other count values are dissimilar dtw scores are computed
count = 0;
for filename=filenames
  count = count+1;
  index = false(1, 400);
  for k = 1:400
    index(k) = (strcmp(C{1,k},filename));
  end
  index = find(index == 1);
  compare = C{2,index};
  if mod(count,2) == 0
      figure;
  end
  switch count
    case 1
      reference = C{2,index};
      refenceFileName = filename;
    case {2,3}
      disp(refenceFileName);
      [scoreSimilar,ix,iy] = dtw(reference',compare');
      subplot(2,1,(count-1));
      plot(ix,iy);
      xlabel(string(refenceFileName));
      ylabel(string(filename))
      title(strcat("DTW: Similar Vowels...Distance = ",string(scoreSimilar)));
      fprintf("DTW Score between %s and %s is %f\n",refenceFileName,filename,scoreSimilar);
    otherwise
      [scoreDisimilar,ix,iy] = dtw(reference',compare');
      subplot(2,1,(count-3));
      plot(ix,iy);
      xlabel(string(refenceFileName));
      ylabel(string(filename))
      title(strcat("DTW:  Disimilar Vowels...Distance = ",string(scoreDisimilar)));
      fprintf("DTW Score between %s and %s is %f\n",refenceFileName,filename,scoreDisimilar);
  end
end





