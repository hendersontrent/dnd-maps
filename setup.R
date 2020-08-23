#----------------------------------------
# This script sets out to set up the
# necessary dependencies for the project
#----------------------------------------

#----------------------------------------
# Author: Trent Henderson, 23 August 2020
#----------------------------------------

# Load packages

library(tidyverse)
library(ggvoronoi)
library(ggpubr)
library(jpeg)
library(Cairo)
library(extrafont)

# Create an output folder if none exists:

if(!dir.exists('output')) dir.create('output')
