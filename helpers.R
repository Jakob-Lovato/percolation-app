### This script contains the functions used in the percolation shiny app
### Functions are reused/modified from my Spring 2022 
### Stat 753 (Stochastic Models and Simulations) final project
### Jakob Lovato, 2022

library(ggplot2)
library(reshape2)
library(raster)
library(igraph)

### Site percolation
#create a grid of dimension n with each siite being occupied with probability p
createGrid <- function(N, p){
  grid <- matrix(sample(c(1, 0), prob = c(p, 1 - p), N^2, 
                        replace = TRUE), nrow = N)
  return(grid)
}

#function takes in matrix corresponding to site percolation system
#returns FALSE if grid does NOT percolate, returns value of percolating "clump" if it does percolate
percolates <- function(grid){
  Rmat <- raster(grid)
  clumps <- as.matrix(clump(Rmat, directions = 4))
  clumps[is.na(clumps)] <- 0
  upper <- max(clumps)
  for(i in 1:upper){
    if((any(clumps[,1] == i) && any(clumps[,ncol(clumps)] == i)) || 
       (any(clumps[1,] == i) && any(clumps[nrow(clumps),] == i))){
      return(i)
    }
  }
  return(FALSE)
}

#plot percolating grid with cluster
plotPerc <- function(grid){
  Rmat <- raster(grid)
  clumps <- as.matrix(clump(Rmat, directions = 4))
  clumps[is.na(clumps)] <- 0
  cluster <- as.matrix(clumps == percolates(clumps)) * 2
  percMat <- grid + cluster
  ggplot(melt(percMat[nrow(percMat):1,]), aes(x = Var1, y = Var2, fill = factor(value))) +
    geom_tile() +
    coord_fixed(ratio = 1) +
    scale_fill_manual(values = c(rgb(245, 245, 245, maxColorValue = 255), 
                                 rgb(211, 219, 224, maxColorValue = 255),
                                 rgb(138, 220, 221, maxColorValue = 255))) +
    theme(panel.background = element_blank(),
          axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.line = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          plot.background = element_rect(fill = "transparent"),
          legend.position = "none"
    )
}
