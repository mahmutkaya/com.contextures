from SeleniumLibrary import SeleniumLibrary
from robot.api.deco import keyword
from selenium.webdriver.common.by import By


class SeleniumUtils(SeleniumLibrary):

    @keyword
    def get_element_index(self, locator, element_text):
        elements = self.find_elements(locator)
        texts = [el.text for el in elements]
        return texts.index(element_text)

    @keyword
    def get_list_of_elements_text(self, locator):
        """
        :param locator: elements locator
        :return: list of unique elements text
        """
        elements = self.find_elements(locator)
        texts = [el.text for el in elements]
        return list(dict.fromkeys(texts))

    @keyword
    def get_all_table_data(self, keys_locator, values_locator):
        all_table_data = []

        keys = self.get_list_of_elements_text(keys_locator)
        rows = self.find_elements(values_locator)

        for row in rows:
            row_cells = row.find_elements(By.TAG_NAME, 'p')
            values = [el.text for el in row_cells]

            dictx = {}
            for i in range(len(keys)):
                dictx[keys[i]] = values[i]

            all_table_data.append(dictx)

        return all_table_data

    @keyword
    def get_orders_with_item_name(self, data_list, item_name):
        items = []
        for data in data_list:
            if data['Item'] == item_name:
                items.append(data)

        return items

    @keyword
    def get_units_in_range_of(self, data_list, _range):
        """
        :param data_list: all table data - list of dicts
        :param _range: has start and end properties
        :return: filtered row data based on units range as list of dicts
        """
        items = []
        print(range)
        for data in data_list:
            if int(_range[0]) <= int(data['Units']) < int(_range[1]):
                items.append(data)

        return items

    @keyword
    def sort_table_data_by_column(self, data_list, column):
        return sorted(data_list, key=lambda k: float(k[column]))

    @keyword
    def get_value_from_list_of_dict(self, args):
        """
        :param args: has data_list, index and key parameters
        :return: value of a key from specified index of list of dict
        """
        indx = int(args['index'])
        return args['data_list'][indx][args['key']]
