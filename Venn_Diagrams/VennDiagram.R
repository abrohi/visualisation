rm(list = ls())

##https://cran.r-project.org/web/packages/VennDiagram/VennDiagram.pdf
##venn diagrams
if (!require("pacman")) install.packages("pacman")
pacman::p_load(VennDiagram, ggsci, scales)


# A simple two-set diagram
venn.plot <- draw.pairwise.venn(100, 70, 30, c("First", "Second")) ##plot a simple two-set digram
grid.draw(venn.plot)

venn.plot <- draw.pairwise.venn(100, 70, 30, c("First", "Second"), scaled = FALSE) ##plot without scaling so first and second group will have the same size
grid.newpage() ##clear the venn diagrams plots


# A more complicated diagram Demonstrating external area labels
venn.plot <- draw.pairwise.venn(
  area1 = 100,
  area2 = 70,
  cross.area = 30,
  category = c("First", "Second"),
  fill = c("blue", "red"),
  lty = "blank",
  cex = 2,
  cat.cex = 2,
  cat.pos = c(285, 105),
  cat.dist = 0.09,
  cat.just = list(c(-1, -1), c(1, 1)),
  ext.pos = 30,
  ext.dist = -0.05,
  ext.length = 0.85,
  ext.line.lwd = 2,
  ext.line.lty = "dashed"
)
grid.draw(venn.plot) ##drawing the grid line
grid.newpage() ##clearing all plots

# Demonstrating an Euler diagram
venn.plot <- draw.pairwise.venn(
  area1 = 100,
  area2 = 70,
  cross.area = 0,
  category = c("First", "Second"),
  cat.pos = c(0, 180),
  euler.d = TRUE,
  sep.dist = 0.03,
  rotation.degree = 45
)

##create colour pallete
##
##https://cran.r-project.org/web/packages/ggsci/vignettes/ggsci.html to see the different avaiable palletes and types#
##
show_col(pal_jco("default", alpha = 0.6)(10)) ##see the different colours in pallete and hexicons

pal_4 <- pal_jco("default", alpha = 0.6)(4) ##creating a list of colours - 4 in particular


# Reference four-set diagram
venn.plot <- draw.quad.venn(
  area1 = 13306,
  area2 = 16698,
  area3 = 10861,
  area4 = 10410,
  n12 = 9143,
  n13 = 6936,
  n14 = 6685,
  n23 = 8157,
  n24 = 7534,
  n34 = 6959,
  n123 = 5923,
  n124 = 5569,
  n134 = 5223,
  n234 = 5869,
  n1234 = 4694,
  category = c("MoneySupermarket", "CompareTheMarket", "Confused", "GoCompare"),
  fill = pal_4,
  lty = "dashed",
  cex = 2,
  cat.cex = 2,
  cat.col = pal_4,
  print.mode = 'percent' ##can be either raw or percent
  #sigdigs = 3 ##how many digits kept if chosen percent
  )

grid.newpage() ##clearing all plots if needed

# Writing to file
tiff("Quad_Venn_diagram.tiff", width = 18, height = 10, units = 'in', res = 300)
grid.draw(venn.plot)
dev.off()
