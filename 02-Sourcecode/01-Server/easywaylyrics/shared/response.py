__author__ = 'pauloalmeida'

"""
Constants for BaseResponse
"""

HTTP_RESPONSE_ERROR = -1
HTTP_RESPONSE_ARTIST_SONG_NOTFOUND = -2

HTTP_RESPONSE_OK = 0
HTTP_RESPONSE_TIMESTAMPED_LYRICS_NOTFOUND = 1

"""
Constants for SearchArtistSongLyricWithLyricsResponse
"""

HTTP_RESPONSE_LYRICS_TRACKINSTRUMENTAL=2


class BaseResponse:
    """
    Class which defines a basic response to mobile application
    """
    def __init__(self, code=HTTP_RESPONSE_OK):
        self.code = code


class BaseLyricFindResponse(BaseResponse):

    def __init__(self, code=HTTP_RESPONSE_OK, predominant_language=None, copyright=None, writer=None, translated_to_lang=None):
        self.code = code
        self.copyright = copyright
        self.writer = writer
        self.predominant_language = predominant_language
        self.translated_to_lang = translated_to_lang


# SearchArtistSongLyricWithLyricsResponse classes

class SearchArtistSongLyricWithLyricsResponse(BaseLyricFindResponse):

    def __init__(self, code=HTTP_RESPONSE_OK, predominant_language=None, copyright=None, writer=None, lrc=None, translated_to_lang=None):
        self.code = code
        self.lrc = lrc
        self.copyright = copyright
        self.writer = writer
        self.predominant_language = predominant_language
        self.translated_to_lang = translated_to_lang


class SearchArtistSongLyricWithoutLyricsResponse(BaseLyricFindResponse):

    def __init__(self, code=HTTP_RESPONSE_OK, predominant_language=None, copyright=None, writer=None, lyrics=None, original=None, translated_to_lang=None):
        self.code = code
        self.lyrics = lyrics
        self.original = original
        self.copyright = copyright
        self.writer = writer
        self.predominant_language = predominant_language
        self.translated_to_lang = translated_to_lang


# SyncLyricsSyncSongResponse
class SyncLyricsSyncSongResponse(BaseResponse):

    def __init__(self, code=HTTP_RESPONSE_OK, seconds=0):
        self.code = code
        self.seconds = seconds
