Project - Server
---

The main goal of this document is to explain how to download dependencies and prepare you environment in order to get this project running on whatever machine. Anything which has been created,updated,deleted must be added in this document.

###Dependencies

+ Installing 
```Shell
    sudo pip install virtualenv
    virtualenv env
    source env/bin/activate
    pip install django
    pip install requests
```        
+ Check whether it's working or not
```Shell
    which python
    ./easywaylyrics_pubic/02-Sourcecode/01-Server/env/bin/python
    
    python -c "import django; print(django.get_version())"
    1.6.2
```   
###Running application

+ Running application 
```Shell
    #How to run it on whatever machine assuming you've followed the steps above
    cd easywaylyrics
    python manage.py runserver
```   
