# percolation-app
Using R and Shiny to create a simple web app to simulate site percolation on a 2D grid

This was a personal project and first attempt at learning how to create a web app in Shiny. Emphasis was placed on theming the app so it wasn't generic looking. It was also a first attempt at using CSS, so code may be a bit messy.

The function of the app is to allow users to generate a 2D grid, where each 'site' or pixel is occupied with some probability. Clusters are formed by adjacent occupied sites (up, down, left, and right, but NOT diagonal), and the system 'percolates' if there is one cluster that touches two opposite boundaries in the sysetm (i.e. the cluster touches both the top and bottom or both the left and right edges of the grid). In particular, this is called "site percolation". See https://en.wikipedia.org/wiki/Percolation_theory

The code to generate grids with randomly occupied sites, detect percolating clusters, and plot the grid was pulled from a section of code I wrote for my final project for Stat 753 - Stochastic Models and Simulations at the University of Nevada, Reno, which I took in the Spring 2022 semester.

Known bug in the code: When plotting, ggplot swaps the colors for occupied and non-occupied sites IF there is NOT a percolating cluster. This means, if the system does not percolate, the white and grey sites are all swapped. I.e., if the site occupation probability was set to 0.1, then 10% of the pixels in the grid should be grey and 90% should be white. However, due to the bug, the occupied sites are shown in white and the non-occupied sites are grey since the system (very likely) will not percolate.

Note: this Shiny app is not optimized for mobile devices, so accessing it on a desktop browser is recommended (it will probably render messily on phone screens).
