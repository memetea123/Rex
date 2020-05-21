from time import sleep

from SeleniumLibrary import BrowserManagementKeywords
from SeleniumLibrary.base import keyword, LibraryComponent
from SeleniumLibrary.errors import ElementNotFound
from SeleniumLibrary.keywords import ElementKeywords, FormElementKeywords
from selenium.common.exceptions import StaleElementReferenceException, ElementNotVisibleException, \
    NoSuchElementException


class ActionsLibrary(LibraryComponent):
    def __init__(self, ctx):
        LibraryComponent.__init__(self, ctx)
        self._max_retry = 5
        self._retry_interval = 5

    @property
    def element_finder(self):
        return self.ctx._element_finder

    @keyword
    def click_element(self, locator, modifier=False, action_chain=False):
        for i in range(0, self._max_retry):
            try:
                self.flash_element(locator)
                element_keywords = ElementKeywords(self.ctx)
                element_keywords.click_element(locator, modifier, action_chain)
            except (StaleElementReferenceException, ElementNotVisibleException,
                    NoSuchElementException, ElementNotFound) as error:
                self.info("QA Bot Keyword '%s' catch exception: '%s'. QA Bot will retry '%s' again!"
                          % (__name__, error, __name__))
                if i == self._max_retry - 1:
                    raise error
                else:
                    sleep(self._retry_interval)
                    continue
            break

    @keyword
    def click_text(self, text):
        for i in range(0, self._max_retry):
            try:
                locator = "xpath:(//*[contains(text(),'" + text + "')])[1]"
                self.flash_element(locator)
                element_keywords = ElementKeywords(self.ctx)
                element_keywords.click_element(locator)
            except (StaleElementReferenceException, ElementNotVisibleException,
                    NoSuchElementException, ElementNotFound) as error:
                self.info("QA Bot Keyword '%s' catch exception: '%s'. QA Bot will retry '%s' again!"
                          % (__name__, error, __name__))
                if i == self._max_retry - 1:
                    raise error
                else:
                    sleep(self._retry_interval)
                    continue
            break

    @keyword
    def input_password(self, locator, password):
        self.flash_element(locator)
        form_element_keywords = FormElementKeywords(self.ctx)
        form_element_keywords.input_password(locator, password)

    @keyword
    def input_text(self, locator, text):
        for i in range(0, self._max_retry):
            try:
                self.flash_element(locator)
                form_element_keywords = FormElementKeywords(self.ctx)
                form_element_keywords.input_text(locator, text)
            except (StaleElementReferenceException, ElementNotVisibleException,
                    NoSuchElementException, ElementNotFound) as error:
                self.info("QA Bot Keyword '%s' catch exception: '%s'. QA Bot will retry '%s' again!"
                          % (__name__, error, __name__))
                if i == self._max_retry - 1:
                    raise error
                else:
                    sleep(self._retry_interval)
                    continue
            break

    @keyword
    def open_chrome_browser(self, url):
        browser_management = BrowserManagementKeywords(self.ctx)
        browser_management.open_browser(url, 'chrome')
        # wait for page redirection
        for i in range(0, self._max_retry):
            url1 = browser_management.get_location
            sleep(8)
            url2 = browser_management.get_location
            if url1 == url2:
                break
            self.driver.maximize_window()

    @keyword
    def sfdc_lwc_select_radio_button(self, group_name, value):
        """Sets the radio button group ``group_name`` to ``value``.

        The radio button to be selected is located by two arguments:
        - ``group_name`` is the name of the radio button group.
        - ``value`` is the ``id`` or ``value`` attribute of the actual
          radio button.

        Examples:
        | `Sfdc Lwc Select Radio Button` | size    | XL    |
        | `Sfdc Lwc Select Radio Button` | contact | email |
        """
        for i in range(0, self._max_retry):
            try:
                self.info("Selecting '%s' from radio button '%s'."
                          % (value, group_name))
                locator_path = "//lightning-radio-group[descendant::*[text()=\"" + group_name + "\"]]//span[text()=\"" + value + "\"]"
                elem = self.element_finder.find(locator_path, None, True, True, None)
                self.flash_element(elem)
                elem.click()
            except (StaleElementReferenceException, ElementNotVisibleException,
                    NoSuchElementException, ElementNotFound) as error:
                self.info("QA Bot Keyword '%s' catch exception: '%s'. QA Bot will retry '%s' again!"
                          % (__name__, error, __name__))
                if i == self._max_retry - 1:
                    raise error
                else:
                    sleep(self._retry_interval)
                    continue
            break

    def flash_element(self, locator, tag=None, required=True, parent=None):
        """ Flash and highlight element to users"""
        elem = self.element_finder.find(locator, tag, True, required, parent)
        self.driver.execute_script(
            "arguments[0].scrollIntoView({behavior: \"smooth\", block: \"center\", inline: \"center\"});", elem)
        for i in range(0, 4):
            self.driver.execute_script("arguments[0].style.border='3px solid orange'", elem)
            sleep(0.2)
            self.driver.execute_script("arguments[0].style.border='3px solid white'", elem)
            sleep(0.2)
