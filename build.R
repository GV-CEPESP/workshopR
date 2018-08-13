library(magrittr)

# 1. Implementar o Conteúdo -----------------------------------------------

#Transfere os materias do repositório "materials" para o site

dir_file <- list.dirs("content", recursive = F)
file_name <- list.files(dir_file, pattern = "\\.Rmd$")

create_Rmd <- function(file_name, dir_file){
  file <- stringr::str_remove(file_name, "\\.Rmd")
  
  ezknitr::ezknit(file    = file_name,
                  wd      = paste0(getwd(),"/", dir_file),
                  out_dir = ".",
                  fig_dir = "figures",
                  keep_html = FALSE)
  
  post_name <- list.files(dir_file, pattern = paste0("^",file, ".md$"), full.names = T)
  system(sprintf("mv ./%s ./%s/index.md", post_name, dir_file))
}

# #Instala o Hugo (0.22) e constrói o site
blogdown::install_hugo(version = "0.22", force = T)
blogdown::hugo_build()
