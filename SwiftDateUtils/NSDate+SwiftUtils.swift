//
//  NSDate+SwiftUtils.swift
//  SwiftDateUtils
//
//  Created by Morgan Harris on 6/06/2014.
//  Copyright (c) 2014 Morgan Harris. All rights reserved.
//

import Foundation

let formatter: NSDateFormatter = NSDateFormatter()

extension NSDate {
    
    func format(s:String) -> String {
        formatter.dateFormat = s
        return formatter.stringFromDate(self)
    }
    
    func format(date: NSDateFormatterStyle = .NoStyle, time: NSDateFormatterStyle = .NoStyle) -> String {
        formatter.dateFormat = nil;
        formatter.timeStyle = time;
        formatter.dateStyle = date;
        return formatter.stringFromDate(self)
    }
    
    func add(components: NSDateComponents) -> NSDate {
        let cal = NSCalendar.currentCalendar()
        return cal.dateByAddingComponents(components, toDate: self, options: nil)
    }
    
    func add(years: NSInteger = NSUndefinedDateComponent, months: NSInteger = NSUndefinedDateComponent, weeks:NSInteger = NSUndefinedDateComponent, days: NSInteger = NSUndefinedDateComponent, hours: NSInteger = NSUndefinedDateComponent, minutes: NSInteger = NSUndefinedDateComponent, seconds: NSInteger = NSUndefinedDateComponent) -> NSDate {
        var components = NSDateComponents()
        components.year = years
        components.month = months
        components.weekOfYear = weeks
        components.day = days
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        
        return self.add(components)
    }
    
    func subtract(years: NSInteger = NSUndefinedDateComponent, months: NSInteger = NSUndefinedDateComponent, weeks:NSInteger = NSUndefinedDateComponent, days: NSInteger = NSUndefinedDateComponent, hours: NSInteger = NSUndefinedDateComponent, minutes: NSInteger = NSUndefinedDateComponent, seconds: NSInteger = NSUndefinedDateComponent) -> NSDate {
        return self.add(years:-years, months:-months, weeks:-weeks, days:-days, hours:-hours, minutes:-minutes, seconds:-seconds)
    }
    
    func subtract(components: NSDateComponents) -> NSDate {
        
        func negateIfNeeded(i: NSInteger) -> NSInteger {
            if i == NSUndefinedDateComponent {
                return i
            }
            return -i
        }
        
        components.year         = negateIfNeeded(components.year)
        components.month        = negateIfNeeded(components.month)
        components.weekOfYear   = negateIfNeeded(components.weekOfYear)
        components.day          = negateIfNeeded(components.day)
        components.hour         = negateIfNeeded(components.hour)
        components.minute       = negateIfNeeded(components.minute)
        components.second       = negateIfNeeded(components.second)
        components.nanosecond   = negateIfNeeded(components.nanosecond)
        return self.add(components)
    }
}

@infix func + (left: NSDate, right:NSTimeInterval) -> NSDate {
    return left.dateByAddingTimeInterval(right)
}

@infix func + (left: NSDate, right:NSDateComponents) -> NSDate {
    return left.add(right);
}

@infix func - (left: NSDate, right:NSTimeInterval) -> NSDate {
    return left.dateByAddingTimeInterval(-right)
}

@infix func - (left: NSDate, right:NSDateComponents) -> NSDate {
    return left.subtract(right);
}

extension Int {

    func seconds() -> NSDateComponents {
        var components = NSDateComponents()
        components.second = self
        return components
    }
    
    func minutes() -> NSDateComponents {
        var components = NSDateComponents()
        components.minute = self
        return components
    }
    
    func hour() -> NSDateComponents {
        var components = NSDateComponents()
        components.hour = self
        return components
    }
    
    func days() -> NSDateComponents {
        var components = NSDateComponents()
        components.day = self
        return components
    }
    
    func weeks() -> NSDateComponents {
        var components = NSDateComponents()
        components.weekOfYear = self
        return components
    }
    
    func month() -> NSDateComponents {
        var components = NSDateComponents()
        components.month = self
        return components
    }
    
    func years() -> NSDateComponents {
        var components = NSDateComponents()
        components.year = self
        return components
    }
    
}

@infix func + (left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
    func addIfPossible(left: NSInteger, right:NSInteger) -> NSInteger {
        if left == NSUndefinedDateComponent && right == NSUndefinedDateComponent {
            return NSUndefinedDateComponent
        }
        if left == NSUndefinedDateComponent {
            return right
        }
        if right == NSUndefinedDateComponent {
            return left
        }
        return left + right
    }
    
    var components = NSDateComponents()
    components.year         = addIfPossible(left.year, right.year)
    components.month        = addIfPossible(left.month, right.month)
    components.weekOfYear   = addIfPossible(left.weekOfYear, right.weekOfYear)
    components.day          = addIfPossible(left.day, right.day)
    components.hour         = addIfPossible(left.hour, right.hour)
    components.minute       = addIfPossible(left.minute, right.minute)
    components.second       = addIfPossible(left.second, right.second)
    components.nanosecond   = addIfPossible(left.nanosecond, right.nanosecond)

    return components
    
}
