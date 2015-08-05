from django.db import models


class Artist(models.Model):
    name = models.CharField(max_length=150, db_index=True)


class Song(models.Model):
    artist = models.ForeignKey(Artist)
    name = models.CharField(max_length=150, db_index=True)
    predominant_language = models.CharField(max_length=4)
    copyright = models.CharField(max_length=150)
    writer = models.CharField(max_length=200)

    class Meta:
        abstract = True


class SongWithLyrics(Song):
    lrc = models.TextField()


class SongWithoutLyrics(Song):
    original = models.TextField()


class TranslatedSong(models.Model):
    language = models.CharField(max_length=4, db_index=True)

    class Meta:
        abstract = True


class TranslatedSongWithLyrics(TranslatedSong):
    song = models.ForeignKey(SongWithLyrics)
    lrc = models.TextField()


class TranslatedSongWithoutLyrics(TranslatedSong):
    song = models.ForeignKey(SongWithoutLyrics)
    lyrics = models.TextField()