# Projeto de Projeção de Frotas de Veículos por UF

### Ferramentas e dados utilizados

-   Pacote Prophet
-   Dataset compilado com dados de frotas de veículos de Março de 2020 até Setembro de 2022, por UF, município e categoria de veículo, obtido por meio do Portal de Dados Abertos do gov.br (disponível em https://drive.google.com/drive/folders/1ibODObZ_NIeDThD9qGGSMgz4Ov0ie_VF?usp=sharing).
-   Tidyverse para manipulação dos dados

Ao rodar o script, o algoritmo gerará uma série de projeções por categoria de veículo, para o número de meses futuros estipulado

Rode o script no shell usando o interpretador com a sintaxe abaixo

``` R
Rscript script.R [número de meses]
```

Os plots com as projeções estarão armazenados na pasta 'resultados'.
