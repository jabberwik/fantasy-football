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

# Put all the tables into one and fill in 0's for missing values
projections <- join_all(list(qb,rb,wr,te,k), by="Player.Name", type="full")
projections[is.na(projections)] <- 0

# Make it pretty
projections$pos <- as.factor(projections$pos)
projections$Team <- as.factor(projections$Team)
projections <- projections[,c(1,12,2:10,13:15,11,16:18)] # reorder columns
colnames(projections)[1] <- "player" # rename column
colnames(projections)[3] <- "team" # rename column
rm(qb,rb,wr,te,k) # remove unused variables

save(projections, file = "Projections-2014.Rdata")