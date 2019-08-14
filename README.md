# Predic(t)ament project 
The final product can be found at this link [Iowa Property Valuation](http://35.246.108.77/iowaknn/R/).


# Installation
## 1. Program Installation

	

This project has been written in the programming language R and as such this must be installed:

[R](https://cloud.r-project.org/bin/windows/base/R-3.6.1-win.exe)

A graphical-user-interface was used to write the program in R:

[RStudio](https://download1.rstudio.org/desktop/windows/RStudio-1.2.1335.exe)

The project also requires the use of a relational database and in this project MySQL WorkBench is used:

[MySQL WorkBench](https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-community-8.0.17.0.msi)

## 2. Package Installation

Once the programs have been installed there are 3 packages that need to be installed within RStudio:
1. > install.packages("kknn")
2. > install.packages("shiny")
3. > install.packages("RMySQL")

## 3. Library Packages
These packages must now be activated within R so they may be used with the code, this is done using the library command:
1. > library(kknn)
2. > library(shiny)
3. >library(RMySQL)

# Downloads
The previously mentioned functions are made available for those who wish to write a similar program themselves and are included within the downloadable files on GitHub. There are 2 files within the repository and these are:

1. The iowknn file is a project file containing the full code necessary for creating the user interface and the code required to create and use a KKNN predictive model.
2. dump1.sql is an SQL dump file, which contains the database and its two relational tables.
# Document Management 
Both of the above files should be placed within the same directory and the working directory within R should be changed to this location. 
> setwd("Your_File_Location_Here")
# FAQ
This section is under development.
