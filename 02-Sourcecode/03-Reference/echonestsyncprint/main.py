__author__ = 'paulo.rodenas'
from scipy.io import wavfile
import numpy as np
import ewlplot
import math
import sys

rate_full_music, dat_full_music = wavfile.read('/Users/paulo.rodenas/workspaceIdea/easywaylyrics/05-Sourcecode/03-Reference/echonestsyncprint/music/Iron_Maiden_Judas_Be_My_Guide_NoiseRemoval.wav')
# rate_partial_music, dat_partial_music = wavfile.read('/Users/paulo.rodenas/workspaceIdea/easywaylyrics/05-Sourcecode/03-Reference/echonestsyncprint/music/Iron_Maiden_Judas_Be_My_Guide_part15_35.wav')
rate_partial_music, dat_partial_music = wavfile.read('/Users/paulo.rodenas/workspaceIdea/easywaylyrics/05-Sourcecode/03-Reference/echonestsyncprint/music/JudasBeMyGuideMic.wav')
# rate_partial_music, dat_partial_music = wavfile.read('/Users/paulo.rodenas/workspaceIdea/easywaylyrics/05-Sourcecode/03-Reference/echonestsyncprint/music/Iron_Maiden_Judas_Be_My_Guide_part26_46.wav')

if rate_full_music != rate_partial_music:
    print rate_partial_music, rate_full_music
    print 'They can\'t be compared since they are not on the same rate'
    sys.exit(1)

#Plotting Spectrum function
# ewlplot.plot_spectrum_basic(dat_full_music[:11025*10], 'Iron Maiden - Judas Be My Guide')
# ewlplot.plot_spectrum(dat_partial_music, 'Iron Maiden - Judas Be My Guide - Partial')

minimium_difference_frames = sys.maxint
minimium_difference_seconds = sys.maxint

total_seconds_full_music = int(math.ceil(float(len(dat_full_music))/float(rate_full_music)))
total_seconds_partial_music = int(math.ceil(float(len(dat_partial_music))/float(rate_partial_music)))

for second in range(1, total_seconds_full_music):
    # print 'second:%d rate:%d' % (second - 1, rate_full_music)
    full_music_second = dat_full_music[(second -1) * rate_full_music:((second -1) * rate_full_music) + (rate_full_music * total_seconds_partial_music)]
    print 'len(full_music_second):%d len(dat_partial_music):%d' % (len(full_music_second), len(dat_partial_music))
    if len(full_music_second) == len(dat_partial_music):
        difference = np.sum(np.subtract(np.array(full_music_second), np.array(dat_partial_music)))
        if math.fabs(difference) < minimium_difference_frames:
            minimium_difference_frames = math.fabs(difference)
            minimium_difference_seconds = second - 1
        print 'second:%d rate:%d difference:%d' % (second - 1, rate_full_music, difference)
        # print difference

print 'Apparently you\'re listening to %d seconds' % minimium_difference_seconds

#Plotting Spectrum function
# ewlplot.plot_spectrum(dat_full_music[(minimium_difference_seconds -1) * rate_full_music:((minimium_difference_seconds -1) * rate_full_music) + (rate_full_music * total_seconds_partial_music)], 'Iron Maiden - Judas Be My Guide',dat_partial_music, 'Iron Maiden - Judas Be My Guide - Partial')

# youtube-dl http://www.youtube.com/watch?v=Nba3Tr_GLZU
#
# ffmpeg -i Iron\ Maiden\ -\ Fear\ of\ the\ Dark-Nba3Tr_GLZU.mp4 -ar 11025 -ab 176 -y FearOfTheDark.wav
