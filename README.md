---
tags: multi-threading, nsoperation
languages: objective-c
---

# Multi-Threading Lab

Your goal is to make a zip code look-up application. Sadly, that is uninteresting so let's also add a fun disco background.

## Instructions

### Intro

  1. Randomly change the background color every .25 seconds. I'd recommend using `NSTimer scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:`
  2. First lets do this all synchronously. On tap of the search button, parse the included CSV file and display the lat,long, City, State,county and state flag in the appropriate locations.
  3. If you run this on your phone, you'll notice that the disco background stops updating! Oh no! So let's multi-thread this. Put the lookup on the background thread. Implement this however you'd like

### Advanced

  1. So let's switch the ADVANCED tests by adding the ADVANCED preprocessor macro.
  2. Our view controller shouldn't be doing any of this csv processing in the ViewController. That sort of data processing belongs in models. Create an `FISZipCode` object. This object should have the following fields:
    
    ```
    (NSString *)county
    (NSString *)latitude
    (NSString *)longitude
    (NSString *)city
    (NSString *)state
    ```

  3. The better way to implement this background operation is to implement a subclass of the `NSOperation` class. Go ahead and create the `FISZipSearchOperation`. It will need two properties

  ```
  (NSString *) searchZipCode
  (^void(FISZipCode *zipCode, NSError *error))zipCodeBlock
  ```

  4. If there are any errors, you should return `nil` for the zipCode and an `NSError` with an appropriate description.

## Hints

  * To read from any file in your "Bundle" (AKA the list of files on the right) you can use something like this:

  ```objc
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"zip_codes_states" ofType:@"csv"];
    NSString *contents = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:filePath] encoding:NSUTF8StringEncoding error:nil];
  ```
