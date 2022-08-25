# com.contextures

- Web Automation Testing Using Robot Framework, SeleniumLibrary and Python with BDD approach

- Environment and specs: [com.contextures](https://www.contextures.com/xlsampledata01.html#data)

### dependencies:
- [Python 3.10.6](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#python-installation)
- [Robot Framework](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#installing-and-uninstalling-robot-framework)
- [Selenium Library](https://robotframework.org/SeleniumLibrary/#installation)

### Setting Up
These instructions will get you a copy of the project up and running on your local machine.

- *clone the repo:*
```shell
git clone https://github.com/mahmutkaya/com.contextures.git
```
- *install [chrome and firefox drivers](https://www.selenium.dev/documentation/webdriver/getting_started/install_drivers/) and move them to the ```..\Python310\Scripts``` folder*

Running tests:
```shell
robot -d test-results/ tests/
```
Running tests in CI/CD pipeline:
- In this project I used github actions.

### About scenarios:
Automated scenarios are:
- Check the amount of different items
- Check all items unit
- Check an item units
- Check the most expensive item
- Check Download File Feature
