library(haven)
library(tidyverse)
keca2001 <- read_spss("keca2001_final.sav")
keca2006 <- read_spss("KECA_2006_final0430.sav")
keca2011 <- read_spss("KECA_2011_final0910.sav")
keca2016 <- read_spss("keca_2016.sav")

keca2001$gyu_id <- paste0("p2001_", 1:6275)
keca2006$gyu_id <- paste0("p2006_", 1:6510)
keca2011$gyu_id <- paste0("p2011_", 1:6022)
keca2016$gyu_id <- paste0("p2016_", 1:5102)

k2001.id <- names(keca2001) %>% tolower
k2006.id <- names(keca2006) %>% tolower
k2011.id <- names(keca2011) %>% tolower
k2016.id <- names(keca2016) %>% tolower

names(keca2001) <- k2001.id
names(keca2006) <- k2006.id
names(keca2011) <- k2011.id
names(keca2016) <- k2016.id

#205,161,203,148
sind.2001 <- grep("^s", k2001.id)

s2001 <- keca2001 %>%
  select(gyu_id, all_of(sind.2001)) %>%
  mutate_all(as.character)

sind.2006 <- grep("^s", k2006.id)

s2006 <- keca2006 %>%
  select(gyu_id, all_of(sind.2006)) %>%
  mutate_all(as.character)

sind.2011 <- grep("^s", k2011.id)

s2011 <- keca2011 %>%
  select(gyu_id, all_of(sind.2011)) %>%
  mutate_all(as.character)

sind.2016 <- grep("^s", k2016.id)

s2016 <- keca2016 %>%
  select(gyu_id, all_of(sind.2016)) %>%
  mutate_all(as.character)

id.2001 <- names(s2001)
id.2006 <- names(s2006) 
id.2011 <- names(s2011) 
id.2016 <- names(s2016) 

s.df <- bind_rows(s2001, s2006) # 285 column 
s.df <- bind_rows(s.df, s2011) # 377 column
s.df <- bind_rows(s.df, s2016) # 421 column

write_sav(s.df, "s_sr.sav")
write_csv(s.df, "s_sr.csv")

dput(id.2016)
