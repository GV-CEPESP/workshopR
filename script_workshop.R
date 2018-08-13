# CepespR -----------------------------------------------------------------

# O CepespR é um pacote criado para auxiliar o acesso dos usuários a API do CepespData. Por meio
# deste pacote é possível ter um acesso mais rápido e organizado aos dados do TSE a respeito das eleições
# ocorridas no Brasil entres os anos de 1998 e 2016.

# Pensando nisto, este script tem como seu objetivo principal mostrar exemplos de como o pacote CepespR funciona e,
# assim, facilitar a vida dos usuários na hora de utilizar o R. Seguindo a rotina de cógidos abaixo, o usuário ao final 
# deste script terá as consultas realizadas salvas com sucesso em formato compatível com o excel(.csv).


# 1. Instalando o CepespR -------------------------------------------------

# Para instalar o pacote CepespR é preciso rodar o código abaixo apenas 
# uma vez (apenas em caso de troca de computador é preciso instalar novamente o pacote):


if (!require("devtools")) install.packages("devtools")
devtools::install_github("Cepesp-Fgv/cepesp-r") 

# Uma vez instalado o CepespR, é preciso "ativar" a library toda vez.
# Por isso SEMPRE que for utilizar o CepespData, é necessário rodar o código abaixo:

library(cepespR)


# 2. Explorando as funções do CepespR -------------------------------------

# Uma vez carregado o pacote do CepespR, o usuário poderá fazer uso de 4 tipos de funções: 
# get_candidates, get_coalitions, get_votes e get_elections. Cada função mostra
# ao usuário diferentes partes dos dados do TSE, retornando sempre ao final da consulta
# uma tabela com os detalhes das eleições. Veja abaixo o que cada função faz:


## 2.1. Consultar perfil dos candidatos -----------------------------------

# Para obter detalhes a respeito das características individuais dos candidatos que 
# concorreram em uma eleição específica, a função get_candidates é a indicada:

# A função funciona assim:
# base_de_dados<-get_candidates(year= "Ano escolhido", position = "cargo escolhido"). 
# Como no exemplo abaixo:

candpres_14 <- get_candidates(year=2014, position="Presidente")

,# Para visualizar os dados do data frame criado usamos a função VIEW

View(candpres_14)

# A ordem da função é sempre esta: nome do data frame onde você quer salvar estas 
# informações + nome da função + variáveis de interesse

# Também é possível realizar as consultas indicando os códigos dos cargos.
# Para visualizar quais códigos representam cada cargo, por favor, acesse: 
# https://github.com/Cepesp-Fgv/cepesp-rest/blob/master/EleicoesPorCargo_BETA.md
# Vamos fazer uma consulta usando o código do cargo:

# Suponhamos que estamos interessados nas eleições para prefeito ocorridas em 2012. Neste caso, 
# é preciso mudar apenas os valores dos parâmetros da função. Veja:

candpref_12 <- get_candidates(year=2012, position=11)
# Você também poderia ter escrito "Prefeito" no lugar do código 11, que o resultado seria o mesmo.
# Note que apenas o ano e o nome(código) do cargo foram alterados

View(candpref_12)


## 2.2. Consultar Coligações ----------------------------------------------

# Para obter detalhes a respeito dos partidos que compuseram as coligacões em 
# uma eleição específica, a função get_coalitions é a indicada:

# Ela funciona de forma similar a get_candidates:

colpres_14 <- get_coalitions(year=2014, position="Presidente")
View(colpres_14)

# Suponhamos que agora estamos interessados nas coligações da eleição para 
# presidente em 2002. Neste caso, a função será escrita assim:

colpres_02 <- get_coalitions(year=2002, position="Presidente")
View(colpres_02)


## 2.3. Consultar votos por eleição ---------------------------------------

# Para obter detalhes a respeito do número de votos de cada candidato em uma 
# eleição específica, a função get_votos é a indicada:

vtpres_14_mun <- get_votes(year=2014, position="Presidente", regional_aggregation="Municipio")
View(vtpres_14_mun)

# Diferente das funções anteriores, essa função precisa de uma AGREGAÇÃO REGIONAL. 
# Ou seja, você pode escolher a que nível de detalhe você quer ver os dados, se é por seção, municipio, nacional, etc. 
# Os diferentes níveis de agregação disponíveis podem ser consultados em: https://github.com/Cepesp-Fgv/cepesp-r

# E se estivéssemos interessados em ver a agregação por Estado (unidade da federação)?

vtpres_14_estad <-get_votes(year=2014, position="Presidente", regional_aggregation="Estado")
View(vtpres_14_estad)


## 2.4. Consultar resultado de eleições por cargo -------------------------

# Além das consultas disponíveis no TSE, é possível fazer uma consulta integrada as eleições.
# Esta consulta agrega informações de candidato, coligações e votos. 
# A consulta ainda está em fase BETA e podem haver pontos de melhoria.

# Para obter detalhes a respeito de uma eleição especificando-se o cargo, 
# use a função get_elections:

elpres_14 <- get_elections(year=2014, position="Presidente", regional_aggregation="Municipio", political_aggregation="Candidato")
View(elpres_14)

# Esta função permite também consultar o resultado por diferentes agregações: 
# Candidato, Partido, Coligação e Consolidado

# Em resultado consolidado da eleição você pode encontrar dados de comparecimento, votos válidos
# e votos brancos e nulos. Veja:

elpres_14_2 <- get_elections(year=2014, position="Presidente", regional_aggregation="Estado", political_aggregation="Consolidado")
View(elpres_14_2)

# Caso você queira restringir sua busca, é possível filtrar na consulta valores específicos.
# Para limitar os resultados a valores específicos (um estado, um partido ou a um candidato, por exemplo), 
# basta acrescentar os parâmetros STATE, PARTY ou CANDIDATE_NUMBER e alterá-los de acordo com o interesse

# Para mostrar apenas os resultados do Rio Grande do Sul, por exemplo, acrescente o parâmetro STATE

elpres_14_RS <- get_elections(year=2014, position="Presidente", regional_aggregation="Estado", political_aggregation="Partido", state="RS")
View(elpres_14_RS)

# Para mostrar apenas os resultados referentes ao PT, por exemplo, acrescente o parâmetro PARTY

elpres_14_PT <- get_elections(year=2014, position="Presidente", regional_aggregation="Estado", political_aggregation="Partido", party="13")
View(elpres_14_PT)

# Para mostrar apenas os resultados referentes ao candidato 2511, por exemplo, acrescente o parâmetro CANDIDATE_NUMBER
# Vamos escrever os parâmetros usando os códigos. Para o cargo de deputado federal o código é 6, para a agregação por UF
# o código é 2 e para a agregação por candidato o código é 2

eldepfed_2511 <- get_elections(year=2014, position=6, regional_aggregation=2, political_aggregation=2, candidate_number=2511)
View(eldepfed_2511)


# 4. Selecionando apenas as colunas que me interessam ---------------------

# As funções do CepespR retornam todas as colunas disponíveis, mas é possivel limitar 
# o tamanho dos resultados selecionando apenas as colunas de interesse. Veja:

## PASSO 1: Primeiro visualizamos quais são as colunas padrões através da função NAMES. Veja:

# Na função get_candidates,por exemplo, as colunas padrões são:

names(get_candidates(year = 2014, position = "Presidente"))

# Note que uma lista de 46 colunas apareceu no seu console. E para as outras funções?

names(get_coalitions(year = 2014, position = "Presidente"))#Lista as colunas da função get_coalition

names(get_votes(year = 2014, position = "Presidente"))#Lista as colunas da função get_votes

names(get_elections(year = 2014, position = "Presidente"))#Lista as colunas da função get_elections

## PASSO 2: Em segundo, criamos uma lista com o nome das colunas que desejamos: 

# Se queremos analisar os dados referentes aos votos, por exemplo, poderíamos
# reduzir nosso data frame a seguintes colunas:

colunas <- list("NUMERO_CANDIDATO", "UF", "QTDE_VOTOS", "COD_MUN_IBGE")

## PASSO 3: Acrescentamos o parâmetro columns_list a nossa função e indicamos a lista criada com o nome das colunas:

vtpres_14_new <- get_votes(year="2014", position="Presidente", regional_aggregation="Municipio", columns_list=colunas)
View(vtpres_14_new)

# Outra maneira de selecionar as colunas de interesse é através da função SUBSET. Para isto, basta:

elpres_14_ <- subset(elpres_14_2,select= c("ANO_ELEICAO", "QT_VOTOS_BRANCOS", "QT_VOTOS_NULOS"))
View(elpres_14_)

# Note que a função foi escrita na seguinte ordem: nome do novo data frame+subset+nome do antigo data frame+
# nome das colunas de interesse


# 5. Analisando os resultados ---------------------------------------------

# É possível fazer análises descritivas das variáveis contidas nos data frames. Por exemplo:
# Para variáveis qualitativas (categóricas), podemos usar a função TABLE. Esta função retorna a distribuição de frequência absoluta
# das categorias. Veja:

# Suponhamos que estamos interessados na quantidade de candidatas do sexo feminino para as eleições a prefeito de 2016.
# A função abaixo retorna a frequência absoluta de homens e mulheres:

elpref_16 <- get_elections(year=2016, position="Prefeito", regional_aggregation="Municipio", political_aggregation="Candidato")
table(elpref_16$DESCRICAO_SEXO)

# Note que a função foi escrita assim: table(nome do data frame$variável do data frame em que estou interessado)

# E para as eleições a deputado federal em 2014? Quantas mulheres se candidataram neste ano? Veja:

eldepfed_14 <- get_elections(year=2014, position="Deputado Federal", regional_aggregation="Estado", political_aggregation="Candidato")
table(eldepfed_14$DESCRICAO_SEXO)

# Para variáveis quantitativas (contínuas), podemos usar a função SUMMARY. Esta função retorna média, mediana, mínimo 
# e máximo das variáveis. Veja: 

# Suponhamos que estamos interessados na média das idades dos candidatos nas eleições a presidente de 2014. Veja:

summary(elpres_14$IDADE_DATA_ELEICAO)

# Note que a função SUMMARY funciona de maneira similar a TABLE:
# summary(nome do data frame$variável do data frame em que estou interessado)


# 6. Salvando os resultados -----------------------------------------------

# Para salvar os data frames gerados neste script em formato .csv, basta usar a função abaixo:

# A função está organizada da seguinte maneira:
# write.csv2(nome do data frame que quero exportar, nome que quero dar ao meu arquivo .csv)

write.csv2(elpres_14, "eleicoes_presidente_2014.csv")
