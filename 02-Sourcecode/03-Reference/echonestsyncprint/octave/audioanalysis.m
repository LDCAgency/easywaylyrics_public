clear all; clc;

Fs_Mic=Fs_Compared=11025; 
Y_Mic=wavread('FearOfTheDarkMic.wav');
Y_Compared=wavread('FearOfTheDark.wav');

[C1,lag1] = xcorr(Y_Compared,Y_Mic);
[maxValue,maxIdx] = max(C1);
int32(lag1(maxIdx)/Fs_Mic)

