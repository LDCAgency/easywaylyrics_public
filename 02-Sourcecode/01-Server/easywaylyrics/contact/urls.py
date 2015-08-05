from django.conf.urls import patterns, include, url
from contact import views

urlpatterns = patterns('',

    url(r'^bookprivatelesson/$', views.book_private_class, name='book_private_class'),

)
