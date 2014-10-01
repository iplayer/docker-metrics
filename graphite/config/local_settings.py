# Edit this file to override the default graphite settings, do not edit settings.py

# Turn on debugging and restart apache if you ever see an "Internal Server Error" page
DEBUG = True

# Set your local timezone (django will try to figure this out automatically)
TIME_ZONE = 'Europe/London'

# Setting MEMCACHE_HOSTS to be empty will turn off use of memcached entirely
MEMCACHE_HOSTS = ['127.0.0.1:11211']
DEFAULT_CACHE_DURATION = 60

# Sometimes you need to do a lot of rendering work but cannot share your storage mount
#REMOTE_RENDERING = True
#RENDERING_HOSTS = ['fastserver01','fastserver02']
LOG_RENDERING_PERFORMANCE = False
LOG_CACHE_PERFORMANCE = False

DATABASES = {
  'default': {
      'ENGINE': 'django.db.backends.sqlite3',
      'NAME': '/src/graphite/storage/graphite.db',
      'USER': '',
      'PASSWORD': '',
      'HOST': '',
      'PORT': ''
  }
}

LOG_DIR = '/src/graphite/storage'
INDEX_FILE = '/src/graphite/storage/index'
