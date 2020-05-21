
from time import sleep

from SeleniumLibrary import TableElementKeywords
from SeleniumLibrary.base import keyword, LibraryComponent
from SeleniumLibrary.errors import ElementNotFound
from selenium.common.exceptions import StaleElementReferenceException, ElementNotVisibleException, \
    NoSuchElementException
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.remote.webelement import WebElement


class TableElement(LibraryComponent):
    def __init__(self, ctx):
        LibraryComponent.__init__(self, ctx)
        self._max_retry = 5
        self._retry_interval = 5

    @property
    def element_finder(self):
        return self.ctx._element_finder

    @keyword
    def sfdc_lwc_datatable_cell_should_contain(self, table_locator, row, column, expected, loglevel='TRACE'):
        for i in range(0, self._max_retry):
            try:
                element_keywords = TableElementKeywords(self.ctx)
                element_keywords.table_cell_should_contain(table_locator, row, column, expected, loglevel)
                row = int(row)
                column = int(column)
                if row == 0 or column == 0:
                    raise ValueError('Both row and column must be non-zero, '
                                     'got row %d and column %d.' % (row, column))
                cell = element_keywords._get_cell(table_locator, row, column)
                self.driver.execute_script("arguments[0].scrollIntoView(true);", cell)
                self.flash_element(cell)
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
    def sfdc_lwc_datatable_cell_value_set(self, table_locator, row, column, newvalue):
        for i in range(0, self._max_retry):
            try:
                element_keywords = TableElementKeywords(self.ctx)
                row = int(row)
                column = int(column)
                if row == 0 or column == 0:
                    raise ValueError('Both row and column must be non-zero, '
                                     'got row %d and column %d.' % (row, column))
                cell = element_keywords._get_cell(table_locator, row, column)
                self.flash_element(cell)
                cell.click()
                cell.send_keys(Keys.HOME)
                cell.send_keys(Keys.SHIFT, Keys.END)
                cell.send_keys(newvalue)
                head_cell1 = self.driver.find_element_by_xpath("("+table_locator+"//thead//div)[1]")
                self.driver.execute_script("arguments[0].scrollIntoView(true);", head_cell1)
                head_cell1.click()
                head_cell1.click()
        # self.driver.execute_script("var path = \"//input[@class='slds-input']\";"
        # "node = document.evaluate(path, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;"
        # "node.setAttribute(\"class\", \"slds-hide\");"
        # "var path = \"//div[@class='slds-hide' and @c-sdf_lwc_datatable_sdf_lwc_datatable]\";"
        # "node = document.evaluate(path, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;"
        # "node.setAttribute(\"class\", \"\");")
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
        if type(locator) is WebElement:
            elem = locator
        for i in range(0, 4):
            self.driver.execute_script("arguments[0].style.border='3px solid orange'", elem)
            sleep(0.2)
            self.driver.execute_script("arguments[0].style.border='3px solid white'", elem)
            sleep(0.2)
