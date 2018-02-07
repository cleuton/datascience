# R text mining

## Tag Cloud

A tag cloud (or word cloud) is a very useful way to identify trend topics in tweets or news.

Using R packages we can easily transform text files into Tidy format and apply filtering and classification on them.

Here you have a simple Tag Cloud Generator. It gathers news feeds and extracts the most common words. 

## Installing environment

You have two versions of the script: A jupyter Notebook and a R script, so suit yourself.

If you want to run the Jupyter Notebook, there are a few things you must do: 

1) [**Install Anaconda**](https://www.anaconda.com/download/)
2) **Create an environment**. [The YAML file](./rds-env.yml) is a recipe to create a Conda env: ```conda env create -f rds-env.yml```
3) **Activate your environment**. *Windows*: ```activate rdatascience```, other: ```source activate rdatascience````
4) **Run interactive R**. Just type: ```R````
5) **Execute some commands**. [Open file r-packages.txt](./r-packages.txt), copy and paste each line in the R console
6) **Open jupyter**. Type: ```jupyter notebook````
7) **Open the notebook**. Select file [NewsCloud.ipynb](./NewsCloud.ipynb)

If you want to run the R script: 

1) [**Install R**](https://www.r-project.org)
2) [**Install RStudio**](https://www.rstudio.com)
3) **Run the commands**. Run the commands inside [r-packages.txt](./r-packages.txt) inside RStudio's console.
4) **Open the script**. Open file [**newscloud.R**](./newscloud.R)

 
