__author__ = 'paulo.rodenas'

from pylab import plot, show, title, xlabel, ylabel, subplot, savefig
from scipy import fft, arange, ifft
from numpy import sin, linspace, pi
from scipy.io.wavfile import read,write


def plotSpectru(y,Fs):
    n = len(y) # lungime semnal
    k = arange(n)
    T = n/Fs
    frq = k/T # two sides frequency range
    print len(frq), len(y)
    frq = frq[range(n/2)] # one side frequency range
    # y = y[range(n/2)]
    print len(frq),len(y)
    Y = fft(y)/n # fft computing and normalization
    Y = Y[range(n/2)]

    plot(frq,abs(Y),'go') # plotting the spectrum
    xlabel('Freq (Hz)')
    ylabel('|Y(freq)|')

Fs = 11025  # sampling rate

rate,data = read('/Users/paulo.rodenas/workspaceIdea/easywaylyrics/05-Sourcecode/03-Reference/echonestsyncprint/music/JudasBeMyGuideComparedToMic.wav')
# data = data/(2.**15)
y=data[:11025/10]
lungime=len(y)
timp=len(y)/11025.
t=linspace(0,timp,len(y))

subplot(2,1,1)
plot(t,y)
xlabel('Time')
ylabel('Amplitude')
subplot(2,1,2)
plotSpectru(y,Fs)
show()
