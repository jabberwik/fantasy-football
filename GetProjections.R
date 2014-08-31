library("plyr")

# Set up handling numbers in the format X,XXX.XX (as.numeric can't handle the commas)
setClass("num.with.commas")
setAs("character", "num.with.commas", function(from) as.numeric(gsub(",","",from)))

# Download the projections from FantasyPros.
# There are many sources of projections, but FP consistently has highly-rated sets
# http://fantasyfootballanalytics.net/2014/06/best-fantasy-football-projections-2014.html

qb <- read.table("http://www.fantasypros.com/nfl/projections/qb.php?export=xls",
                 header = TRUE, skip = 5, sep = "\t", quote="\"", strip.white = TRUE,
                 colClasses = c("character", "character", rep("num.with.commas", 9), "NULL", "NULL"))
qb$pos = "QB"
rb <- read.table("http://www.fantasypros.com/nfl/projections/rb.php?export=xls",
                 header = TRUE, skip = 5, sep = "\t", quote="\"", strip.white = TRUE,
                 colClasses = c("character", "character", rep("num.with.commas", 7), "NULL", "NULL"))
rb$pos = "RB"
wr <- read.table("http://www.fantasypros.com/nfl/projections/wr.php?export=xls",
                 header = TRUE, skip = 5, sep = "\t", quote="\"", strip.white = TRUE,
                 colClasses = c("character", "character", rep("num.with.commas", 7), "NULL", "NULL"))
wr$pos = "WR"
te <- read.table("http://www.fantasypros.com/nfl/projections/te.php?export=xls",
                 header = TRUE, skip = 5, sep = "\t", quote="\"", strip.white = TRUE,
                 colClasses = c("character", "character", rep("num.with.commas", 4), "NULL", "NULL"))
te$pos = "TE"
k <- read.table("http://www.fantasypros.com/nfl/projections/k.php?export=xls",
                header = TRUE, skip = 5, sep = "\t", quote="\"", strip.white = TRUE,
                colClasses = c("character", "character", rep("num.with.commas", 3), "NULL", "NULL"))
k$pos = "K"

# Download IDP Projections from FantasySharks, because it's the only source I could find
# (ESPN has some too, but they're *much* more difficult to download & parse)

idp <- read.csv("http://www.fantasysharks.com/apps/bert/forecasts/projections.php?csv=1&Segment=490&Position=98&scoring=1&uid=4",
                strip.white = TRUE,
                colClasses = c("NULL",rep("character",3),rep("numeric",8),"NULL"))

# IDP Names come down as "Last, First". Change to "First Last".
names <- matrix(unlist(strsplit(idp$Player, ", ")), ncol = 2, byrow = TRUE)
idp$Player <- paste(names[,2], names[,1])

# Rename IDP columns to align with FantasyPros columns
colnames(idp) <- c("Player.Name","Team","pos","tack","asst","scks","pass_def","int","fum_frc","fumbles","def_td")

# Put all the tables into one and fill in 0's for missing values
projections <- join_all(list(qb,rb,wr,te,k,idp), by=c("Player.Name","pos","Team"), type="full")
projections[is.na(projections)] <- 0

# Make it pretty
projections$pos <- as.factor(projections$pos)
projections$Team <- as.factor(projections$Team)
projections <- projections[,c(1,12,2:10,13:15,11,16:25)] # reorder columns
colnames(projections)[1] <- "player" # rename column
colnames(projections)[3] <- "team" # rename column
rm(qb,rb,wr,te,k,idp) # remove unused variables

save(projections, file = "Projections-2014.Rdata")