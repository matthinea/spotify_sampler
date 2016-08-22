# Spotify.sample

###Plays a 30 Second Preview of a random Spotify Track using a random word from a 60,000-word dictionary.

###Because words like "love" and words like "Hofbrau" have equal chance of coming up in the dictionary search, this app's results are not completely random, and could be said to biased towards "weird" music or music made by musicians for whom English is not their first language.

##Build it yourself with my instructional blog post [here](https://medium.com/@ol___o/making-a-random-song-app-in-ruby-on-rails-a-complete-beginners-guide-8a239f9561a0#.ovi65p54r).

####TODO:
1. Verify that authorization works (still some problems with the Spotify API not responding/ the server timing out).
2. Refactor production version to read words from an array stored in a constant rather than the DB (due to Heroku's 10,000 row limitation).
3. Include links to previews or to Spotify URIs in track history list.
4. Find a good dictionary API and make seed word a clickable link to the dictionary definition. 
5. Set a maximum size for the session[:history] cookie to avoid cookie overflow errors. (Set to instance variable and have session[:history] just read the last X items, perhaps.)
6. Refactor.
