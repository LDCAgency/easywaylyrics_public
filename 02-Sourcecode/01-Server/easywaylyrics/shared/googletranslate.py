__author__ = 'pauloalmeida'

import requests
import json
import math
from threading import Thread

HOST = 'http://<your-website>/'
ENDPOINTTRANSLATE = '/translate.php?from=%s&to=%s&txt=%s'


class GoogleTranslateService:

    def __init__(self):
        pass

    @staticmethod
    def execute(from_lang='en', to_lang='', txt='', add_carriage=True):
        translated_lyrics = ''
        textDict = txt.split('\r\n')
        for t in textDict:
            response = requests.get((HOST + ENDPOINTTRANSLATE) % (from_lang, to_lang, t)).text
            response = json.loads(response)['translation']['txt']
            translated_lyrics += response + ('\r\n' if add_carriage is True else '')

        return translated_lyrics

    def execute_multi_thread(self, from_lang='en', to_lang='', txt='', add_carriage=True):
        if txt is not None and to_lang is not None and from_lang is not None:

            text_dict = txt.split('\r\n')

            array_size = int(math.floor(len(text_dict) / 10))
            response_lrc_arrays = split(text_dict, array_size)

            processes = []
            for t in response_lrc_arrays:
                thread_t = self._GoogleTranslateServiceThread(from_lang=from_lang, to_lang=to_lang, txt=t, add_carriage=add_carriage)
                thread_t.start()
                processes.append(thread_t)

            translated_response = ''
            threads_running = True
            while threads_running:
                found_thread_alive = False
                for p in processes:
                    if not p.is_alive():
                        translated_response += p.return_value
                    else:
                        found_thread_alive = True
                        translated_response = ''
                        break

                if not found_thread_alive:
                    threads_running = False

            # elapsed_time = time.time() - start_time
            # print 'master elapsed_time', elapsed_time
            return translated_response
        return ''

    @staticmethod
    def get_predominant_language(from_lang='', txt='', to_lang=''):
        """
            Get the predominant language from a text
            Parameters:
              from_lang - From language, it detects the source language if not set.
              txt - Text which is going to be analysed
              to_lang - To language, default to 'pt' if not set
        """
        response = requests.get((HOST + ENDPOINTTRANSLATE) % (from_lang, to_lang, txt[:500].replace('\r\n', ' '))).text
        return json.loads(response)['translation']['from']

    class _GoogleTranslateServiceThread(Thread):
        def __init__(self, from_lang=None, to_lang=None, txt=None, add_carriage=True):
            Thread.__init__(self)
            self.return_value = None
            self.txt = txt
            self.to_lang = to_lang
            self.from_lang = from_lang
            self.add_carriage = add_carriage

        def run(self):
            if self.txt is not None and self.to_lang is not None and self.from_lang is not None:
                self.return_value = ''
                for t in self.txt:
                    self.return_value += GoogleTranslateService.execute(from_lang=self.from_lang, to_lang=self.to_lang, txt=t, add_carriage=self.add_carriage)
                return


class GoogleTranslateLyricFindService:

    def __init__(self, response_lrc=None, from_lang='', to_lang=''):
        self.response_lrc = response_lrc
        self.to_lang = to_lang
        self.from_lang = from_lang

    def execute(self):
        if self.response_lrc is not None:
            for t in self.response_lrc:
                translated = GoogleTranslateService.execute(from_lang=self.from_lang, to_lang=self.to_lang, txt=t['line'], add_carriage=False)
                t['line'] = translated
            return self.response_lrc
        return ''

    def execute_multi_thread(self):
        if self.response_lrc is not None:
            array_size = int(math.floor(len(self.response_lrc) / 5))
            response_lrc_arrays = split(self.response_lrc, array_size)

            processes = []
            for t in response_lrc_arrays:
                thread_t = self._GoogleTranslateLyricFindServiceThread(response_lrc=t, from_lang=self.from_lang, to_lang=self.to_lang)
                thread_t.start()
                processes.append(thread_t)

            translated_response = []
            threads_running = True
            while threads_running:
                found_thread_alive = False
                for p in processes:
                    if p.is_alive():
                        found_thread_alive = True

                if not found_thread_alive:
                    threads_running = False
                    for p in processes:
                        translated_response += p.return_value

            return translated_response
        return ''

    class _GoogleTranslateLyricFindServiceThread(Thread):
        def __init__(self, response_lrc=None, from_lang=None, to_lang=None):
            Thread.__init__(self)
            self.return_value = None
            self.response_lrc = response_lrc
            self.to_lang = to_lang
            self.from_lang = from_lang

        def run(self):
            if self.response_lrc is not None and self.from_lang is not None and self.to_lang is not None:
                self.return_value = GoogleTranslateLyricFindService(response_lrc=self.response_lrc, from_lang=self.from_lang, to_lang=self.to_lang).execute()
                return


def split(array, size):
        arrays = []
        if size > 0:
            while len(array) > size:
                piece = array[:size]
                arrays.append(piece)
                array = array[size:]
            arrays.append(array)
        return arrays