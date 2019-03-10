##aim: to use esquisse as an add-in to create ggplot's

rm(list = ls())
if(!require("pacman")) install.packages("pacman")
pacman::p_load(esquisse, ggplot2)

iris <- datasets::iris
mtcars <- datasets::mtcars

options("esquisse.display.mode" = "browser") ##can launch add-in in browser

esquisse::esquisser() ##launching the add-in

