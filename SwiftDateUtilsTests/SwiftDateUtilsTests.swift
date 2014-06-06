//
//  SwiftDateUtilsTests.swift
//  SwiftDateUtilsTests
//
//  Created by Morgan Harris on 6/06/2014.
//  Copyright (c) 2014 Morgan Harris. All rights reserved.
//

import XCTest
import SwiftDateUtils

class SwiftDateUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NSTimeZone.setDefaultTimeZone(NSTimeZone(abbreviation: "UTC"))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        NSTimeZone.resetSystemTimeZone()
    }
    
    func testSeconds() {
        
        //July 4, 2008
        let d1 = NSDate(timeIntervalSince1970: 1215129600)
        let d2 = NSDate(timeIntervalSince1970: 1215129610)
        
        let d3 = d1 + 10.seconds();
        
        XCTAssertEqual(d2, d3)
        
        let d4 = NSDate(timeIntervalSince1970: 1215129700)
        let d5 = d1 + 100.seconds();
        
        XCTAssertEqual(d4, d5)
    }
    
    func testNewYears() {
        
        //December 31, 2008, 23:59
        let d1 = NSDate(timeIntervalSince1970: 1230767940)
        let d2 = NSDate(timeIntervalSince1970: 1230768060)
        
        let d3 = d1 + 2.minutes()
        XCTAssertEqual(d3, d2)
        
        let d4 = d2 - 2.minutes()
        XCTAssertEqual(d4, d1)
        
        let calendar = NSCalendar.currentCalendar()
        
        let d5 = d1 + 1.weeks()
        let c5 = calendar.components(NSCalendarUnit.YearCalendarUnit, fromDate: d5)
        XCTAssertEqual(c5.year, 2009)
        
        let d6 = d2 - 1.weeks()
        let c6 = calendar.components(NSCalendarUnit.YearCalendarUnit, fromDate: d6)
        XCTAssertEqual(c6.year, 2008)
        
    }
    
    func testCompounds() {
        
        //July 4, 2008, Midnight
        let d1 = NSDate(timeIntervalSince1970: 1215129600)
        
        //July 27, 2008, 01:00
        let d2 = NSDate(timeIntervalSince1970: 1217120400)
        
        let d3 = NSDate(timeIntervalSince1970: 1213138800)
        
        //these should be equivalent
        let d4 = d1 + 3.weeks() + 2.days() + 1.hour()
        let d5 = d1 + (3.weeks() + 2.days() + 1.hour())
        
        XCTAssertEqual(d2, d4)
        XCTAssertEqual(d4, d5)

        //these should be equivalent
        let d6 = d1 - 3.weeks() - 2.days() - 1.hour()
        let d7 = d1 - (3.weeks() + 2.days() + 1.hour())

        XCTAssertEqual(d3, d6)
        XCTAssertEqual(d6, d7)
    }
    
    func testFormats() {
        
        // Note: I'm pretty sure the simulator always uses the EN-US locale
        // so this should always work. If it doesn't, then... well, you could
        // modify the test or change the simulator's locale.
        
        let d1 = NSDate(timeIntervalSince1970: 1215129600)
        let s1 = d1.format(date: .ShortStyle, time: .ShortStyle)
        
        XCTAssertEqual(s1, "7/4/08, 12:00 AM")
        
        let s2 = d1.format(date: .FullStyle, time: .NoStyle)
        
        XCTAssertEqual(s2, "Friday, July 4, 2008")
        
        let s3 = d1.format(date: .NoStyle, time: .FullStyle)
        
        XCTAssertEqual(s3, "12:00:00 AM GMT")
        
        let s4 = d1.format("YYYY-MM-dd'T'hh:mm:ss")
        
        XCTAssertEqual(s4, "2008-07-04T12:00:00")
        
    }
    
}
