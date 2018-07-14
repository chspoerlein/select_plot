The "select\_plot"-ShinyApp
================

What is educational selectivity?
----------------

Educational selectivity is a classic concept in migration studies that refers to the idea that immigrants are not a random sample of the population at origin. In fact, migrants oftentimes tend to be more selective in terms of age and health (i.e., they are younger and healthier on average). Educational selectivity applies this idea to migrant's educational attainment by asking how selective (i.e., non-randomly selected) are immigrants in terms of education relative to those who stayed behind. More specifically, higher values of educational selectivity thus imply that those individuals were drawn from highly educated segments of the origin population. Note that that the terms educational selectivity (i.e., the overarching concept) and relative education (i.e., the specific way we measure educational selectivity) are used interchangeably.

What does the "Distributions" plot panel show?
----------------

This panel depicts the distributions of immigrant's educational selectivity for different years of immigration using so-called "joy plots". Let's take the default setup showing all origin groups of both sexes who have been in Germany no more than 5 years over the whole time frame and using 5-year aggregation, then we see that in the 1970's, relative education is largely concentrated at the right of the scale. In other words, the higher the distribution, the more individiuals scored the respective value of relative education. Over time, this concentration is broken up and immigrants now (2010) cover the whole spectrum of relative education with noticeable "bumps" at the lower end, the middle and the upper end of the distribution.

What does the "Average trend lines" plot panel show?
----------------

This panel condenses the information presented in the distributions panel down to only the mean of each distribution. Hence, Turkish immigrants in 1970 (the top, purplish line) had an average educational selectivity of 91.72 (hovering the mouse over the beginning of the line will give additional information such as the exact value of relative education, the origin group depicted as well as the year of immigration). Note that although average trend lines are easier to read, a lot of insightful information is missing by reducing distributions to single measures of tendency.


How is it measured?
--------------

Put simply, educational selectivity measures on individual's position in the origin countries educational attainment distribution of his/her peers, that is compared to others of the same sex and age category. Hence, a value of 75 means that an individual's educational attainment is higher or equal to 75 percent of the population in the country of origin with the same sex and a similar age. Obviously, this measure is strongly related to individual's absolute educational attainment in that highly educated individuals tend to score high on relative education whereas individual's with little or no education tend to score low. More formally, relative education is defined as the sum of the proportion of individuals in educational category i-1 and half the proportion of individuals in educational category i. Let's assume we have four educational categories with each containing a quarter of individuals, then an individual who attained the third category would score 0.25+0.25+(0.25/2)=0.625. In individual in the first category (i.e., lowest level of educational attainment) would score (0.25/2)=0.125.  

What data sources were used?
---------------

Measuring educational selectivity requires at least two sources of information: information on the population of origin and information on immigrants in the respective destination societies. Origin information was derived from the Barro-Lee "Educational Attainment Dataset" (http://www.barrolee.com/) which collected educational attainment data by sex and 5-year age categories from 1950 to 2010 for a broad range of countries. Destination data is based in the German Microcensus (1976-2013) where immigrants are identified based on their citizenship (see the following paragraph for more information on why this might be problematic).

What are potential problems when looking at these plots?
---------------

Number of cases: Make sure that the number of cases is large enough to show meaningful comparisons! Restricting, for example, the time frame too much may only plot the distributions for a small number of cases. See also each figures subtitle for the exact number of cases.

Years since immigration: The default of 5 years was chosen for the specific reason of minimizing potential bias introduced through measuring immigrant status using information on citizenship as well as selective remigration. Because it virtually impossible to gain German citizenship with only five years in the country, immigrants should be reliably identified. Moreover, it is unclear how selective remigration affects the results. If less selective individuals have a higher likelihood of remigration, then this inflates the extent of educational selectivity of those remaining in Germany. If, however, more selective individuals remigrate more often, then the extent of educational selectivity is understated. In addition, we simply don't know whether one or the other pattern is more likely and this is also likely to vary across origin groups. Hence, changing years since immigration should be done with these pitfalls in mind!

Using national averages for the origin data: Note that outmigration from origin countries can be highly regionalized (think of Anatolian guest workers in Germany). When these regions with high outmigration rates are misrepresented by the national average, then the measurement of relative education is likely to be biased. Moreover, the direction of this bias is oftentimes not easy to assess. Regions differ at the very least with respect to their capabilities in providing educational infrastructure (which is probably better in urban compared to rural regions). In other words, a secondary school degree means something different when attained in Anatolia as compared to Istanbul.

Additional resources:
---------------
https://academic.oup.com/esr/article/30/6/750/2800036


