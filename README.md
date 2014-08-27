# Fantasy Football

This repository contains a few R scripts that I'm trying this year for my Fantasy Football drafts. There's a really good chance that I have no idea what I'm doing, but hopefully you can find some inspiration here!

## Script Descriptions

`GetProjections.R` downloads the latest projection data from FantasyPros and stores it into `Projections-2014.Rdata` for later use. Run this first.

`CalculateFantasyPoints.R` needs to be configured with the scoring rules for your particular league. Then it will add projected fantasy points to the projections downloaded earlier.

`CalculateVORP.R` adds the Value Over Replacement Player, which was shown by [a Harvard Study](http://harvardsportsanalysis.files.wordpress.com/2012/04/fantasyfootballdraftanalysis1.pdf) to be the most effective way to sort your draft picks. There are a lot of ways to calculate the VORP. The approach I'm using needs to be configured for your league. Basically, you're looking at the rank for which a particular position was drafted at the end of Round 10. So if 13 quarterbacks were drafted at the end of round 10, you'd enter 13. This is your "replacement rank" and it sort of makes the whole thing work.

Some more information about VORP and value-based drafting can be found at [Fantasy Football Analytics](http://fantasyfootballanalytics.net/2013/04/win-your-snake-draft-calculating-value.html), which also inspired me to go down this path in the first place.