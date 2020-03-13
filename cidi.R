library(haven)
library(tidyverse)
library(xlsx)

keca2001 <- read_spss("keca2001_final.sav")
keca2001$gyu_id <- paste0("p2001_", 1:6275)
keca2006 <- read_spss("KECA_2006_final0430.sav")
keca2006$gyu_id <- paste0("p2006_", 1:6510)
k2001.id <- names(keca2001) %>% tolower
k2006.id <- names(keca2006) %>% tolower

names(keca2001) <- k2001.id
names(keca2006) <- k2006.id


id.vec <- which(k2001.id %in% k2006.id)
id.names<- k2001.id[id.vec]
s2001 <- keca2001 %>%
  select(id.vec) %>%
  mutate_all(as.character)

s2006 <- keca2006 %>%
  select(id.names) %>%
  mutate_all(as.character)

merge.df <- bind_rows(s2001, s2006)



keca2011 <- read_spss("KECA_2011_final0910.sav")
keca2011$gyu_id <- paste0("p2011_", 1:6022)
keca2016 <- read_spss("keca_2016.sav")
keca2016$gyu_id <- paste0("p2016_", 1:5102)
k2011.id <- names(keca2011) %>% tolower
k2016.id <- names(keca2016) %>% tolower

names(keca2011) <- k2011.id
names(keca2016) <- k2016.id

id.vec <- which(k2011.id %in% k2016.id)
id.names<- k2011.id[id.vec]

s2011 <- keca2011 %>%
  select(id.vec) %>%
  mutate_all(as.character)

s2016 <- keca2016 %>%
  select(id.names) %>%
  mutate_all(as.character)


merge.df2 <- bind_rows(s2011, s2016)

#merge.df
#merge.df2

merge.id <- names(merge.df)
merge.id2 <- names(merge.df2)
id.vec <- which(merge.id %in% merge.id2)
id.names<- merge.id[id.vec]


m.df <- merge.df %>%
  select(id.vec)

m.df2 <- merge.df2 %>%
  select(id.names) 

complete.df <- bind_rows(m.df, m.df2)

write_sav(complete.df, "CIDI.sav")
write_csv(complete.df, "CIDI.csv")
