# Spotify.sample

###Plays a 30 Second Preview of a random Spotify Track using a random word from a 60,000-word dictionary.

###Because words like "love" and words like "Hofbrau" have equal chance of coming up in the dictionary search, this app's results are not completely random, and could be said to biased towards "weird" music or music made by musicians for whom English is not their first language.

####TODO:
1. Make track history into a drop-down list. 
2. Verify that authorization works (still some problems with the Spotify API not responding/ the server timing out).
3. Include links to previews or to Spotify URIs in track history list.
4. Find a good dictionary API and make seed word a clickable link to the dictionary definition. 
5. Set a maximum size for the session[:history] cookie to avoid cookie overflow errors. (Set to instance variable and have session[:history] just read the last X items, perhaps.)
6. Refactor styling.