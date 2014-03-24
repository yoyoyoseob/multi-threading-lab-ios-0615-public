---
tags: multi-threading, nsoperation
languages: objective-c
---

# Multi-Threading Lab

Your goal is to make a zip code look-up application. Sadly, that is
uninteresting so let's also add a fun disco background.

## Instructions

  1. Randomly change the background color every .25 seconds. I'd recommend using `NSTimer scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:`
  2. First lets do this all synchronously. On tap of the search button, parse the included CSV file and display the lat,long, City, State,county and state flag in the appropriate locations.
  3. If you run this on your phone, you'll notice that the disco background stops updating! Oh no! So let's multi-thread this. Put the lookup on the background thread.
  4. What happens if someone puts in a new ZipCode while you are looking up the old zip code? Cancel that old operation!
  5. Use the SBA.gov api to get a link to the county's website. The format for that URL is `http://api.sba.gov/geodata/all_links_for_county_of/<COUNTY NAME>/<TWO LETTER STATE>.json`. When you tap on the flag image, go to the url for that county.


## Extra Credit

  1. Display how long it will take to *drive* to the inputted zip code by using a [google maps directions cocoapod](https://github.com/marciniwanicki/OCGoogleDirectionsAPI).

## Hints

  * To read from any file in your "Bundle" (AKA the list of files on the right) you can use something like this:

  ```objc
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"zip_codes_states" ofType:@"csv"];
    NSString *contents = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:filePath] encoding:NSUTF8StringEncoding error:nil];
  ```
