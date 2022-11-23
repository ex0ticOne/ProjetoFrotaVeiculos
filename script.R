options(scipen = 999, warn = -1)

library(prophet)
library(dygraphs)
library(dplyr)
library(htmltools)
library(readr)

argumentos <- commandArgs(trailingOnly = TRUE)

n_periodos <- as.numeric(argumentos[1])

#Prophet com algumas traduções para português brasileiro
source('ProphetPersonalizado.R')

#Carrega o dataset
dataset_frota <- read_csv('dataset_frota.csv')

#Cria as relações de UFs e Categorias de veículos para o loop
lista_UF <- data.frame(table(dataset_frota$UF))
lista_UF <- as.factor(lista_UF$Var1)

lista_tipo <- data.frame(table(dataset_frota$TIPO))
lista_tipo <- as.factor(lista_tipo$Var1)

#Cria o dataset agrupado por UF
dataset_frota_UF <- dataset_frota %>%
  group_by(UF, TIPO, ds) %>%
  summarise(y = sum(y)) %>%
  mutate(diferenca = y - lag(y))

#Cria um dataset de média de aumento de veículos por categoria por mês
media_aumento_frota_UF <- dataset_frota_UF %>%
  group_by(UF, TIPO) %>%
  summarise(media = round(mean(diferenca, na.rm = TRUE), digits = 0))

write_csv(media_aumento_frota_UF, 'media_aumento_frota_UF.csv')

#Loop For para cada UF e Categoria de Veículo, e salva o resultado em plot interativo em html
for (item_UF in lista_UF) {
  
  for(item_tipo in lista_tipo) {
    
    modelo <- prophet(dataset_frota_UF %>%
                        filter(UF == item_UF & 
                               TIPO == item_tipo) %>%
                        select(ds, y), 
                      yearly.seasonality = TRUE, 
                      weekly.seasonality = FALSE, 
                      daily.seasonality = FALSE, 
                      seasonality.mode = "multiplicative")
    
    periodos_futuros <- make_future_dataframe(modelo, n_periodos, freq = "month", include_history = TRUE)
    
    projecao <- predict(modelo, periodos_futuros)
    
    plot_projecao <- dyplot.prophet(modelo, projecao, uncertainty = TRUE, 
                                    main = paste0("Projeção - ", item_UF, " - ", item_tipo)) %>% 
      dyOptions(maxNumberWidth = 20)
    
    save_html(html = plot_projecao, 
              file = paste0("resultados/Projeção - ", item_UF, " - ", item_tipo, ".html"))
    
  }

}
