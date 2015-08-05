__author__ = 'paulo.rodenas'
import matplotlib.pyplot as plt


def plot_spectrum_basic(raw_data, title):
    plt.plot(raw_data)
    plt.title(title)
    plt.xlabel('Frames')
    plt.ylabel('Spectrum')
    plt.show()


def plot_spectrum(raw_data1,title1,raw_data2, title2):
    fig = plt.figure()

    ax1 = fig.add_subplot(211)
    ax1.plot(raw_data1)
    ax2 = fig.add_subplot(212)
    ax2.plot(raw_data2)

    plt.xlabel('Frames')
    plt.ylabel('Spectrum')
    plt.show()