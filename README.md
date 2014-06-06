SwiftDateUtils
==============

A number of NSDate utilities written in Swift.

# Usage

This module introduces two new methods on NSDate, and a couple of overloaded operators, too.

## Formatting

First of all, `.format`. Let's face it, setting up an NSDateFormatter every time you want to format a date is tedious. We all just want a format function. Now we have one. It takes either a string:

    //July 4, 2008, Midnight GMT
    let d1 = NSDate(timeIntervalSince1970: 1215129600)
    
    d1.format("YYYY-MM-dd'T'hh:mm:ss")
    // > 2008-07-04T12:00:00
    
or one or two NSDateFormatStyles, named `date:` and `time:`

    d1.format(date: .ShortStyle, time: .ShortStyle)
    // > "7/4/08, 12:00 AM" (depending on your locale)

    d1.format(date: .FullStyle)
    // > "Friday, July 4, 2008"
    
    d1.format(time: .FullStyle)
    // > "12:00:00 AM GMT"
  
## Adding and subtracting time

`NSDate` already has a handy `dateByAddingTimeInterval` function. Can we make it better? Damn right we can. You can add time more safely - respecting calendar changes - in two syntaxes. First, the `add` function, using named parameters.

    d1.add(hours: 2)
    // > July 4, 2008, 2:00 AM GMT
    
    d1.add(weeks: 3, days: 2, hours: 1)
    // > July 27, 2008, 1:00 AM GMT

Any usage of `add` can also be used with `subtract`, which does the same thing, but in reverse.

Or you can use the *significantly cooler* operator overloading.

    d1 + 5.hours()
    // > July 4, 2008, 5:00 AM GMT
    
    d1 - 2.days() - 1.hour() + 5.minutes()
    // > July 1, 2008, 11:05 PM GMT

# Using it in your project

It's a Swift library, so just build the framework, drop it into your project and `import SwiftDateUtils`.

# Known issues

Any module that imports SwiftDateUtils will magically gain a module-level constant called `formatter`. You can still declare your own variables and constants, of any type, called `formatter`, or just ignore it, but it will turn up in your auto-complete. Any suggestions for getting rid of this, I am happy to hear them.
