from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),
    url(r'^lyricfind/', include('lyricfind.urls')),
    url(r'^contact/', include('contact.urls')),
)
