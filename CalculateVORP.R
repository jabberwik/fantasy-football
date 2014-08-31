# Enter the replacement ranks for each position.
# There are a variety of ways to calculate this.
# See http://www.footballguys.com/05vbdrevisited.htm

qbReplacement <- 21
rbReplacement <- 36
wrReplacement <- 47
teReplacement <- 16
kReplacement <-  5
lbReplacement <- 34
dbReplacement <- 22
dlReplacement <- 19

qbReplacementPoints <- projections[projections$pos == "QB","fantasy_points"][[qbReplacement]]
rbReplacementPoints <- projections[projections$pos == "RB","fantasy_points"][[rbReplacement]]
wrReplacementPoints <- projections[projections$pos == "WR","fantasy_points"][[wrReplacement]]
teReplacementPoints <- projections[projections$pos == "TE","fantasy_points"][[teReplacement]]
kReplacementPoints <- projections[projections$pos == "K","fantasy_points"][[kReplacement]]
lbReplacementPoints <- projections[projections$pos == "LB","fantasy_points"][[lbReplacement]]
dbReplacementPoints <- projections[projections$pos == "DB","fantasy_points"][[dbReplacement]]
dlReplacementPoints <- projections[projections$pos == "DL","fantasy_points"][[dlReplacement]]

projections[projections$pos == "QB","vorp"] <- projections[projections$pos == "QB","fantasy_points"] - qbReplacementPoints
projections[projections$pos == "RB","vorp"] <- projections[projections$pos == "RB","fantasy_points"] - rbReplacementPoints
projections[projections$pos == "WR","vorp"] <- projections[projections$pos == "WR","fantasy_points"] - wrReplacementPoints
projections[projections$pos == "TE","vorp"] <- projections[projections$pos == "TE","fantasy_points"] - teReplacementPoints
projections[projections$pos == "K","vorp"] <- projections[projections$pos == "K","fantasy_points"] - kReplacementPoints
projections[projections$pos == "LB","vorp"] <- projections[projections$pos == "LB","fantasy_points"] - lbReplacementPoints
projections[projections$pos == "DB","vorp"] <- projections[projections$pos == "DB","fantasy_points"] - dbReplacementPoints
projections[projections$pos == "DL","vorp"] <- projections[projections$pos == "DL","fantasy_points"] - dlReplacementPoints

cheatSheet <- projections[order(projections$vorp, decreasing = TRUE),c("player","team","pos","fantasy_points","vorp")]
rownames(cheatSheet) <- NULL
