from logging import \
    INFO, \
    basicConfig, \
    debug, \
    error, \
    exception, \
    getLogger, \
    info, \
    warning
from sys import stdout


class Logspike:
    def __init__(self):
        basicConfig(
            level=INFO,
            format='\r\n%(asctime)s:%(msecs)03d %(levelname)s: %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S',
            stream=stdout)

    @staticmethod
    def set_logging_level(level):
        getLogger().setLevel(level)
