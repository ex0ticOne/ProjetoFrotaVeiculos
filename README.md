# Projeto de Projeção de Frotas de Veículos por UF

### Ferramentas e dados utilizados

-   Pacote Prophet
-   Dataset compilado com dados de frotas de veículos de Março de 2020 até Setembro de 2022, por UF, município e categoria de veículo, obtido por meio do Portal de Dados Abertos do gov.br (disponível no Kaggle em https://www.kaggle.com/datasets/ex0ticone/number-of-cars-registered-in-brazil).
-   Tidyverse para manipulação dos dados

Ao rodar o script, o algoritmo gerará uma série de projeções por categoria de veículo, para o número de meses futuros estipulado

Rode o script no shell usando o interpretador com a sintaxe abaixo

``` R
Rscript script.R [número de meses]
```

Os plots com as projeções estarão armazenados na pasta 'resultados'.
