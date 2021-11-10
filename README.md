# Portfolio Projects
*This portfolio is a compliation of projects I have created for data analysis*

[Project 1 - Tokyo Olympics and World Happiness](#Tokyo)<br>
[Project 2 - Udemy Course Data Exploration](#Udemy)<br>
[Project 3 - New York City Property Data Cleaning](#NYC)<br>

---

## <a name="Tokyo"></a> Project 1 - Tokyo Olympics and World Happiness
My goal for this project was to be able to discern any connection between a country's happiness score and the overall medals they won at the 2021 Tokyo Olympics. The Olympics in Tokyo dataset provided the summary of all medals won and final standings for each country that participated in the 2020 Tokyo Olympics. The World Happiness Report dataset provided every countries' ladder score, their region and additional happiness measures.
### Datasets used:
[Olympics in Tokyo](https://www.kaggle.com/arjunprasadsarkhel/2021-olympics-in-tokyo)  
[World Happiness Report](https://www.kaggle.com/ajaypalsinghlo/world-happiness-report-2021)
### Process
* Used VLOOKUP and Conditioning Formatting in Excel to match country names between World Happiness Report and listed 2020 Tokyo Olympic Teams/Countries<br>
* Manually corrected name differences between the two reports (ie. Great Britain and United Kingdom). Teams that were not represented in the World Happiness Report were excluded from the dataset.<br>
* Results were then filtered by colour to present final matches to better identify any potential missing points of interest.<br>
* Once data had been cleaned in Excel, imported it over to MySQL and 9conducted several queries which can be found [here](https://github.com/ClementTsai/PortfolioProjects/blob/main/HappinessVMedalsProj.sql)
* Datasets were then imported to Tableau Public where several visualizations were made to better understand the relation between a country's happiness score and the medals they won at the 2021 Tokyo Olympics
### Analysis
Of the 83 participating countries, excluding dependent territories and countries with missing data in the World Happiness dataset, 71% won at least one gold medal at the 2020 Tokyo Olympics. 46 of the participating countries that won at least one gold medal had a happiness score greater or equal to 5 whereas only 13 countries with a happiness score less than 5 won at least one gold medal at the 2020 Tokyo Olympics.


Tableau Visual Dashboard:<br>
[Tokyo Olympics and World Happiness](https://public.tableau.com/app/profile/clement.tsai/viz/FirstProject-2020TokyoOlympicsandWorldHappiness/Dashboard1)<br>

## <a name="Udemy"></a> Project 2 - Udemy Course Data Exploration
The goal for the Udemy course dataset was to throughougly explore the data, and determine which courses and subjects received the most interactions, engagements and subscriptions. The Udemy course dataset provided approximately 4000 unique courses from 2011 to 2017 with their corresponding data, such as the course length and number of subscription. The dataset was also categorized by 4 different subjects: Business Finance, Graphic Design, Musical Instruments and Web Development.
### Datasets used:
[Udemy Course](https://www.kaggle.com/andrewmvd/udemy-courses)
### Process
* Dataset was imported to MySQL where all duplicate courses were expunged
* Once all duplicates were deleted, I [explored](https://github.com/ClementTsai/PortfolioProjects/blob/main/udemy.sql) the dataset in MySQL
* Dataset was then imported to Tableau Public where I created several visualizations such as the growth of Udemy from 2011-2017

Tableau Visual Dashboard:<br>
[Udemy Course Data Exploration](https://public.tableau.com/app/profile/clement.tsai/viz/Project2-UdemyCoursesDataExploration/Dashboard1)
## <a name="NYC"></a> Project 3 - New York City Property Data Cleaning
The goal for the New York City Property Dataset was to througougly clean it by removing any duplicate data, converting time format, and seperating addresses into address and neighbourhood. The New York City Property Dataset was comprised of every building or building unit sold in a twelve month period from September 2016 to September 2017. The dataset was initially altered in an excel sheet by merging the address and neighbourhood for further SQL practice. 
### Datasets used:
[New York City Property Sales](https://www.kaggle.com/new-york-city/nyc-property-sales)
### Process
* Dataset was first imported to Excel where the ID numbers were changed to be distinct
* Dataset was then imported to MySQL to be [cleaned](https://github.com/ClementTsai/PortfolioProjects/blob/main/NYCPropertyClean.sql)
