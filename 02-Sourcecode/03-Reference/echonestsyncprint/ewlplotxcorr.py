__author__ = 'paulo.rodenas'
import matplotlib.pyplot as plt
import numpy as np
from scipy.io import wavfile
from numpy import linspace
import math
import sys
from utility import pcm2float


rate_full_music, dat_full_music = wavfile.read('/Users/paulo.rodenas/workspaceIdea/easywaylyrics/05-Sourcecode/03-Reference/echonestsyncprint/music/FearOfTheDark.wav')
rate_partial_music, dat_partial_music = wavfile.read('/Users/paulo.rodenas/workspaceIdea/easywaylyrics/05-Sourcecode/03-Reference/echonestsyncprint/music/FearOfTheDarkMic.wav')

normalized_full_music = pcm2float(dat_full_music, np.float16)
normalized_partial_music = pcm2float(dat_partial_music, np.float16)

plt.figure()
plt.subplot(3,1,1)
plt.plot(linspace(0, len(normalized_full_music)/rate_full_music, len(normalized_full_music)),normalized_full_music)
plt.title('Full Music')
# plt.xlabel('Time')
plt.ylabel('Amplitude')
plt.subplot(3,1,2)
plt.plot(linspace(0, len(normalized_partial_music)/rate_partial_music, len(normalized_partial_music)),normalized_partial_music)
plt.title('Mic Captured')
plt.xlabel('Time')
# plt.ylabel('Amplitude')
plt.show()
# plt.figure()
# plt.xcorr(xcorr, usevlines=True, maxlags=50, normed=True, lw=2)
#
# plt.show()