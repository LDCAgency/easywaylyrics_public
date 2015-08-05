from django.conf.urls import patterns, url
from lyricfind import views

urlpatterns = patterns('',
    url(r'^search/(?P<artist>[\w\d\s\,\.\'\"\!\?\&\@\#\$\%\*\-]+)/(?P<song>[\w\d\s\,\.\'\"\!\?\&\@\#\$\%\*\(\)\-]+)/(?P<to_lang>[\w\s\-]+)$',
        views.search_by_artist_song_name_to_lang, name='search_by_artist_song_name_to_lang'),

)
