# Enter the replacement ranks for each position.
# There are a variety of ways to calculate this.
# See http://www.footballguys.com/05vbdrevisited.htm

qbReplacement <- 13
rbReplacement <- 44
wrReplacement <- 33
teReplacement <- 11
kReplacement <-  1

qbReplacementPoints <- projections[projections$pos == "QB","fantasy_points"][[qbReplacement]]
rbReplacementPoints <- projections[projections$pos == "RB","fantasy_points"][[rbReplacement]]
wrReplacementPoints <- projections[projections$pos == "WR","fantasy_points"][[wrReplacement]]
teReplacementPoints <- projections[projections$pos == "TE","fantasy_points"][[teReplacement]]
kReplacementPoints <- projections[projections$pos == "K","fantasy_points"][[kReplacement]]

projections[projections$pos == "QB","vorp"] <- projections[projections$pos == "QB","fantasy_points"] - qbReplacementPoints
projections[projections$pos == "RB","vorp"] <- projections[projections$pos == "RB","fantasy_points"] - rbReplacementPoints
projections[projections$pos == "WR","vorp"] <- projections[projections$pos == "WR","fantasy_points"] - wrReplacementPoints
projections[projections$pos == "TE","vorp"] <- projections[projections$pos == "TE","fantasy_points"] - teReplacementPoints
projections[projections$pos == "K","vorp"] <- projections[projections$pos == "K","fantasy_points"] - kReplacementPoints

cheatSheet <- projections[order(projections$vorp, decreasing = TRUE),c("player","team","pos","fantasy_points","vorp")]
rownames(cheatSheet) <- NULL
