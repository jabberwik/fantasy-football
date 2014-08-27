if (!exists("projections"))
{
  load("Projections-2014.Rdata")
}

# League scoring settings
points = list()

points["pass_yds"] <-    0.04 # Passing - Points per yard
points["pass_tds"] <-    6    # Passing - Points per touchdown
points["pass_ints"] <-  -2    # Passing - Points per interception
points["rush_yds"] <-    0.1  # Rushing - Points per yard
points["rush_tds"] <-    6    # Rushing - Points per touchdown
points["rec_att"] <-     0.5  # Receiving - Points per reception
points["rec_yds"] <-     0.1  # Receiving - Points per yard
points["rec_tds"] <-     6    # Receiving - Points per touchdown
points["fumbles"] <-    -2    # Points per fumble
points["fg"] <-          3    # Points per field goal
points["xpt"] <-         1    # Points per extra point

# Apply the scoring rules above to the stat projections to come up with our projected fantasy points
projections$fantasy_points <- rowSums(projections[,c(6:8,10:16,18)] * points)
