######################################################################
######### GRÁFICO DE BARRAS CON BARRAS DE ERROR ESTÁNDAR #############
# Ander Raso Vázquez anderraso@gmail.com
# fuente: https://morevine.wordpress.com/2010/05/06/statistics-with-r-barplots-with-errorbars/
######################################################################

# obtener datos del csv
mouse <- read.csv("farma.csv", header = T)

# medias para el gráfico Grafico
m1 <- mean(mouse$salino.t0)
m2 <- mean(mouse$salino.t20)
m3 <- mean(mouse$naloxona.5mg.kg)
m4 <- mean(mouse$morfina.10mg.kg.t0)
m5 <- mean(mouse$morfina.10mg.kg.t.20)
m6 <- mean(mouse$Morf.naloxona.5mg.kg)

heights = c(m1, m2, m3, m4, m5, m6)

# Crear el gráfico de barras
bp = barplot(heights, ylim=c(0,130))

barplot(heights, ylim=c(0,130), xlim=c(0,12), 
        las    = 1,  # las gives orientation of axis labels
        col    = c("#727272", "#f1595f", "#79c36a", "#599ad3", "#f9a65a", "#9e66ab"),
        border = NA,  # No borders on bars
        main   = "Resultados obtenidos (tiempo en segundos) sobre medida \n de la actividad analgésica en la placa caliente",  # \n = line break
        legend = c("Control t0", "Control t20", "Control t20 + naloxona", "Morfina t0", "Morfina t20", "Morfina t20 + naloxona"))

# colorines
#727272
#f1595f
#79c36a
#599ad3
#f9a65a
#9e66ab
#cd7058
#d77fb3







# install.packages("psych")
library("psych") # para la función "describe"

# Sacar el error estándar
se1 <- describe(mouse$salino.t0)$se
se2 <- describe(mouse$salino.t20)$se
se3 <- describe(mouse$naloxona.5mg.kg)$se
se4 <- describe(mouse$morfina.10mg.kg.t0)$se
se5 <- describe(mouse$morfina.10mg.kg.t.20)$se
se6 <- describe(mouse$Morf.naloxona.5mg.kg)$se

# media - error estándar = parte inferior de la barra de error
# media + error estándar = parte superior de la barra de error
lower = c(m1-se1, m2-se2, m3-se3, m4-se4, m5-se5, m6-se6)
upper = c(m1+se1, m2+se2, m3+se3, m4+se4, m5+se5, m6+se6)

#install.packages("Hmisc")
library("Hmisc") # para la función "errbar"

print(bp) # importante quedarnos con [,1]
print(bp[,1]) # localización del centro de la barra

# errbar(x, y, upper, lower)
# Añadir al gráfico de barras las barras de error
errbar(bp[,1], heights, upper, lower, add=T, xlab="")

