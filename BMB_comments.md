# BMB comments

## 6 Feb

- You should be more explicit about where your data files came from
- Code generally looks good (see comments therein). You could consider being more tidyverse-ish (but this is an aesthetic choice, you don't have to), using pipes/`mutate`/etc. - would make your code a little cleaner
- you should definitely look at the `forecast` package and Rob Hyndman's work in general <https://robjhyndman.com/>;  you can probably get some of his [books](https://robjhyndman.com/publications/) on SpringerLink. He's probably the most prominent time-series/forecasting guy working in R.
- you should definitely think carefully about how you're going to evaluate out-of-sample error (see Roberts et al. paper referenced in `readings.md` on the course web site; Hyndman and others probably have more to say about this)
- should probably also spend some time thinking about the scale on which you are most interested in forecasting (and why!): minutes, hours, days?  More generally, explain more about **why** you want to solve this technical problem
