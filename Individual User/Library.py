from SeleniumLibrary import SeleniumLibrary

from ActionsLibrary import ActionsLibrary
from ValidationsLibrary import ValidationsLibrary
from TableElement import TableElement

__version__ = '0.0.1.dev1'


class Library(SeleniumLibrary):

    def __init__(self, timeout=5.0, implicit_wait=0.0,
                 run_on_failure='Capture Page Screenshot',
                 screenshot_root_directory=None):
        SeleniumLibrary.__init__(self, timeout=timeout, implicit_wait=implicit_wait,
                                 run_on_failure=run_on_failure,
                                 screenshot_root_directory=screenshot_root_directory)
        self.add_library_components([ActionsLibrary(self), TableElement(self),
                                     ValidationsLibrary(self)])
