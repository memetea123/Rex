
from time import sleep

from SeleniumLibrary.base import keyword, LibraryComponent
from SeleniumLibrary.errors import ElementNotFound
from SeleniumLibrary.keywords import ElementKeywords, FormElementKeywords
from SeleniumLibrary.utils import (is_falsy, is_noney, is_truthy)
from selenium.common.exceptions import StaleElementReferenceException, ElementNotVisibleException, \
    NoSuchElementException


class ValidationsLibrary(LibraryComponent):
    def __init__(self, ctx):
        LibraryComponent.__init__(self, ctx)
        self._max_retry = 5
        self._retry_interval = 5

    @property
    def element_finder(self):
        return self.ctx._element_finder

    @keyword
    def page_should_contain_element(self, locator, message=None,
                                    loglevel='TRACE', limit=None):
        for i in range(0, self._max_retry):
            try:
                self.flash_element(locator)
                element_keywords = ElementKeywords(self.ctx)
                element_keywords.page_should_contain_element(locator, message, loglevel, limit)
            except (StaleElementReferenceException, ElementNotVisibleException,
                    NoSuchElementException, ElementNotFound) as error:
                self.info("QA Bot Keyword '%s' catch exception: '%s'. QA Bot will retry '%s' again!"
                          % (__name__,  error, __name__))
                if i == self._max_retry - 1:
                    raise error
                else:
                    sleep(self._retry_interval)
                    continue
            break

    @keyword
    def page_should_contain_text(self, text):
        for i in range(0, self._max_retry):
            try:
                locator = "xpath:(//*[contains(text(),'" + text + "')])[1]"
                self.flash_element(locator)
                element_keywords = ElementKeywords(self.ctx)
                element_keywords.page_should_contain(locator)
            except (StaleElementReferenceException, ElementNotVisibleException,
                    NoSuchElementException, ElementNotFound) as error:
                self.info("QA Bot Keyword '%s' catch exception: '%s'. QA Bot will retry '%s' again!"
                          % (__name__,  error, __name__))
                if i == self._max_retry - 1:
                    raise error
                else:
                    sleep(self._retry_interval)
                    continue
            break

    @keyword
    def element_should_contain(self, locator, expected, message=None, ignore_case=False):
        for i in range(0, self._max_retry):
            try:
                self.flash_element(locator)
                element_keywords = ElementKeywords(self.ctx)
                element_keywords.element_should_contain(locator, expected, message, ignore_case)
            except (StaleElementReferenceException, ElementNotVisibleException,
                    NoSuchElementException, ElementNotFound) as error:
                self.info("QA Bot Keyword '%s' catch exception: '%s'. QA Bot will retry '%s' again!"
                          % (__name__,  error, __name__))
                if i == self._max_retry - 1:
                    raise error
                else:
                    sleep(self._retry_interval)
                    continue
            break

    @keyword
    def sfdc_lwc_lightning_input_should_be_disabled(self, locator):
        for i in range(0, self._max_retry):
            try:
                if self.is_element_enabled(locator):
                    raise AssertionError("Element '%s' is enabled." % locator)
                self.flash_element(locator)
            except (StaleElementReferenceException, ElementNotVisibleException,
                    NoSuchElementException, ElementNotFound) as error:
                self.info("QA Bot Keyword '%s' catch exception: '%s'. QA Bot will retry '%s' again!"
                          % (__name__,  error, __name__))
                if i == self._max_retry - 1:
                    raise error
                else:
                    sleep(self._retry_interval)
                    continue
            break

    @keyword
    def sfdc_lwc_lightning_input_value_should_contain(self, locator, expected, message=None, ignore_case=False):
        for i in range(0, self._max_retry):
            try:
                actual = actual_before = self.find_element(locator).get_attribute("value")
                expected_before = expected
                if is_truthy(ignore_case):
                    actual = actual.lower()
                    expected = expected.lower()
                if expected not in actual:
                    if is_noney(message):
                        message = "Element '%s' should have contained text '%s' but " \
                                  "its text was '%s'." % (locator, expected_before, actual_before)
                    raise AssertionError(message)
                self.info("Element '%s' contains text '%s'." % (locator, expected_before))
                self.flash_element(locator)
            except (StaleElementReferenceException, ElementNotVisibleException,
                    NoSuchElementException, ElementNotFound) as error:
                self.info("QA Bot Keyword '%s' catch exception: '%s'. QA Bot will retry '%s' again!"
                          % (__name__,  error, __name__))
                if i == self._max_retry - 1:
                    raise error
                else:
                    sleep(self._retry_interval)
                    continue
            break

    def flash_element(self, locator, tag=None, required=True, parent=None):
        """ Flash and highlight element to users"""
        elem = self.element_finder.find(locator, tag, True, required, parent)
        self.driver.execute_script("arguments[0].scrollIntoView({behavior: \"smooth\", block: \"center\", inline: "
                                   "\"center\"});", elem)
        for i in range(0, 4):
            self.driver.execute_script("arguments[0].style.border='3px solid orange'", elem)
            sleep(0.2)
            self.driver.execute_script("arguments[0].style.border='3px solid white'", elem)
            sleep(0.2)

