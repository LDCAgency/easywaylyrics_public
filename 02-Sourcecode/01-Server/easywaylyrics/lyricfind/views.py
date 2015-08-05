from django.http import HttpResponse
from models import *
import requests
import json
import re
from shared import response as sharedresponse
from shared import googletranslate

# Constants
HOST = 'https://api.lyricfind.com/'
ENDPOINTSEARCH = 'search.do?apikey=%s&reqtype=default&searchtype=track&displaykey=%s&alltracks=no&artist=%s&track=%s&output=json'
ENDPOINTLYRICS = 'lyric.do?apikey=%s&lrckey=%s&reqtype=default&format=lrc&trackid=amg:%d&output=json'
ENDPOINTSEARCH_APIKEY = '<your-search-api-key>'
ENDPOINTSEARCH_DISPLAYKEY = '<your-search-display-key>'
ENDPOINTLYRIC_LRCKEY = '<your-lyric-lrc-key>'
ENDPOINTLYRIC_APIKEY = '<your-lyric-api-key>'


# Create your views here.
def search_create_artist_by_name(artist):
    artist_search = Artist.objects.filter(name=artist)[:1]
    if len(artist_search) > 0:
        artist_instance = artist_search[0]
    else:
        artist_instance = Artist(name=artist)
        artist_instance.save()
    return artist_instance


def search_by_artist_song_name_to_lang(request, artist='', song='',
                                       to_lang='default'):
    artist = re.sub(r"\(.*\)", "", artist).strip()
    song = re.sub(r"\(.*\)", "", song).strip()

    song_with_lyrics_search = SongWithLyrics.objects.filter(artist__name=artist,
                                                            name=song)[:1]
    song_without_lyrics_search = SongWithoutLyrics.objects.filter(
        artist__name=artist, name=song)[:1]
    if len(song_with_lyrics_search) == 0 and len(song_without_lyrics_search) == 0:

        response_endpoint_search = requests.get((HOST + ENDPOINTSEARCH) % (
        ENDPOINTSEARCH_APIKEY, ENDPOINTSEARCH_DISPLAYKEY, artist, song)).json()

        # Checking if we found the artist and song. If so we'll request its lyrics
        #  to send back to user
        if response_endpoint_search['response']['code'] == 100 and \
                        response_endpoint_search['totalresults'] > 0:
            # Replace strategy by the greatest score instead of the first element
            amg_track = resolve_best_amg(response_endpoint_search['tracks'])

            response_endpoint_lyric = requests.get((HOST + ENDPOINTLYRICS) % (
            ENDPOINTLYRIC_APIKEY, ENDPOINTLYRIC_LRCKEY, amg_track)).json()
            if response_endpoint_lyric['response']['code'] == 111 or \
                            response_endpoint_lyric['response']['code'] == 101:
                # Get the predominant language if it's not set to default value
                predominant_language = googletranslate.GoogleTranslateService.get_predominant_language(
                    txt=response_endpoint_lyric['track']['lyrics'])

                # For some reason we don't know why yet, some musics
                # google translate isn't capable of tell you what's
                # the predominant language

                if predominant_language == u'? ':
                    predominant_language = 'en'

                # Check whether we already have this artist on our database
                artist_instance = search_create_artist_by_name(artist)

                if to_lang == 'default':
                    to_lang = resolve_to_lang_for_song(predominant_language)

                if response_endpoint_lyric['response']['code'] == 111:
                    song_instance = SongWithLyrics(artist=artist_instance,
                                                   name=song,
                                                   predominant_language=predominant_language,
                                                   copyright=
                                                   response_endpoint_lyric[
                                                       'track']['copyright'],
                                                   writer=response_endpoint_lyric[
                                                       'track']['writer'],
                                                   lrc=json.dumps(
                                                       response_endpoint_lyric[
                                                           'track']['lrc']))
                    song_instance.save()

                    #Translating and persisting it in database
                    google_translate_lrc = googletranslate.GoogleTranslateLyricFindService(
                        from_lang=predominant_language,
                        response_lrc=response_endpoint_lyric['track']['lrc'],
                        to_lang=to_lang).execute_multi_thread()
                    translated_song_instance = TranslatedSongWithLyrics(
                        language=to_lang, song=song_instance,
                        lrc=json.dumps(google_translate_lrc))
                    translated_song_instance.save()

                    response = build_response(translated_song_instance)

                elif response_endpoint_lyric['response']['code'] == 101:

                    song_instance = SongWithoutLyrics(artist=artist_instance,
                                                      name=song,
                                                      predominant_language=predominant_language,
                                                      copyright=
                                                      response_endpoint_lyric[
                                                          'track']['copyright'],
                                                      writer=
                                                      response_endpoint_lyric[
                                                          'track']['writer'],
                                                      original=
                                                      response_endpoint_lyric[
                                                          'track']['lyrics'])
                    song_instance.save()

                    #Translating and persisting it in database
                    google_translate_lyrics = googletranslate.GoogleTranslateService().execute_multi_thread(
                        from_lang=predominant_language, to_lang=to_lang,
                        txt=response_endpoint_lyric['track']['lyrics'])[:-2]
                    translated_song_instance = TranslatedSongWithoutLyrics(
                        language=to_lang, song=song_instance,
                        lyrics=google_translate_lyrics)
                    translated_song_instance.save()

                    response = build_response(translated_song_instance)
            else:
                response = sharedresponse.BaseResponse(
                    code=sharedresponse.HTTP_RESPONSE_ERROR)
            return HttpResponse(json.dumps(response.__dict__),
                                content_type="application/json")
        else:
            response = sharedresponse.BaseResponse(
                code=sharedresponse.HTTP_RESPONSE_ARTIST_SONG_NOTFOUND)
        return HttpResponse(json.dumps(response.__dict__),
                            content_type="application/json")
    else:

        if len(song_with_lyrics_search) > 0:
            song_instance = song_with_lyrics_search[0]

            if to_lang == 'default':
                to_lang = resolve_to_lang_for_song(
                    song_instance.predominant_language)

            translated_song_with_lyrics_search = TranslatedSongWithLyrics.objects.filter(
                song=song_instance, language=to_lang)[:1]

            if len(translated_song_with_lyrics_search) == 0:
                #Translating and persisting it in database
                google_translate_lrc = googletranslate.GoogleTranslateLyricFindService(
                    from_lang=song_instance.predominant_language,
                    response_lrc=json.loads(song_instance.lrc),
                    to_lang=to_lang).execute_multi_thread()
                translated_song_instance = TranslatedSongWithLyrics(
                    language=to_lang, song=song_instance,
                    lrc=json.dumps(google_translate_lrc))
                translated_song_instance.save()
                response = build_response(translated_song_instance)
            else:
                response = build_response(translated_song_with_lyrics_search[0])

        elif len(song_without_lyrics_search) > 0:
            song_instance = song_without_lyrics_search[0]

            if to_lang == 'default':
                to_lang = resolve_to_lang_for_song(
                    song_instance.predominant_language)

            translated_song_without_lyrics_search = TranslatedSongWithoutLyrics.objects.filter(
                song=song_instance, language=to_lang)[:1]

            if len(translated_song_without_lyrics_search) == 0:
                #Translating and persisting it in database
                google_translate_lyrics = googletranslate.GoogleTranslateService().execute_multi_thread(
                    from_lang=song_instance.predominant_language, to_lang=to_lang,
                    txt=song_instance.original)[:-2]
                translated_song_instance = TranslatedSongWithoutLyrics(
                    language=to_lang, song=song_instance,
                    lyrics=google_translate_lyrics)
                translated_song_instance.save()
                response = build_response(translated_song_instance)
            else:
                response = build_response(
                    translated_song_without_lyrics_search[0])

    return HttpResponse(json.dumps(response.__dict__),
                        content_type="application/json")


def build_response(translated_song=None):
    if type(translated_song) is TranslatedSongWithLyrics:
        return sharedresponse.SearchArtistSongLyricWithLyricsResponse(
            code=sharedresponse.HTTP_RESPONSE_OK,
            copyright=translated_song.song.copyright,
            writer=translated_song.song.writer,
            predominant_language=translated_song.song.predominant_language,
            translated_to_lang=translated_song.language,
            lrc=json.loads(translated_song.lrc))
    elif type(translated_song) is TranslatedSongWithoutLyrics:
        return sharedresponse.SearchArtistSongLyricWithoutLyricsResponse(
            code=sharedresponse.HTTP_RESPONSE_TIMESTAMPED_LYRICS_NOTFOUND,
            copyright=translated_song.song.copyright,
            writer=translated_song.song.writer,
            predominant_language=translated_song.song.predominant_language,
            translated_to_lang=translated_song.language,
            lyrics=translated_song.lyrics,
            original=translated_song.song.original)
    else:
        return sharedresponse.BaseResponse(
            code=sharedresponse.HTTP_RESPONSE_ERROR)


def resolve_to_lang_for_song(from_lang):
    if from_lang == 'pt':
        to_lang = 'en'
    elif from_lang == 'en':
        to_lang = 'pt'
    else:
        to_lang = 'en'
    return to_lang


def resolve_best_amg(response_endpoint_search_tracks=[]):
    amg_track = None
    for track in response_endpoint_search_tracks:
        amg_track = track['amg']
        break

    return amg_track
