#install.packages(c("DBI", "RSQLite", "dbplyr"))

library(RSQLite)
library(DBI)
library(dplyr)

db <- dbConnect(SQLite(), dbname="airline2.db")

#able to choose the file 
flights00 <- read.csv(file.choose())
flights01 <-read.csv(file.choose())
flights02 <- read.csv(file.choose())
flights03 <- read.csv(file.choose())
flights04 <- read.csv(file.choose())
flights05 <-  read.csv(file.choose())

# is to merge all data tgt with same variable names and data types 
allFlights <- rbind(flights00, flights01, flights02, flights03, flights04, flights05)
allFlights

airStore <- read.csv(file.choose())
airlines <- read.csv(file.choose())

#creating database table for allFlights
dbWriteTable(db, 'allFlightsDb', allFlights)

#writing database command
dbWriteTable(db, 'airStoredb', airStore)

#Listing out ur database 
dbListTables(db)
    
# bGetQuery(conn,"SELECT car_names, hp, cyl FROM cars_data WHERE cyl = 8")
dbGetQuery(db, 'SELECT * FROM airStoredb LIMIT 3')

# showing which airplane has the lowest associated average departure delay
lowAvegDep = dbGetQuery(db, "SELECT flightNum, AVG(DepDelay) As Average_Delay FROM allFlightsDb GROUP BY flightNum" )


#showing which cities has the highest number of in flight 
cityHighflight= dbGetQuery(db, "SELECT origin, SUM(taxiin) As highest_no_inbound FROM allFlightsDb GROUP BY origin")


#Getting which company has the highest cancelled flights
comHighCanFlight= dbGetQuery(db, "SELECT Uniquecarrier, SUM(Cancelled) As No_of_cancelled FROM allFlightsDb GROUP BY Uniquecarrier ")

#Getting the highest number of flights. 

df.to_csv 