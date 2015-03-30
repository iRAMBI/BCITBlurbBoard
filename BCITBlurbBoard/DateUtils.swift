//
//  DateUtils.swift
//  BCITBlurbBoard
//
//  Created by Ryan Sadio on 2015-03-18.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import Foundation

extension NSDate {
    
    // -> Date System Formatted Medium
    func ToDateMediumString() -> NSString? {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        return formatter.stringFromDate(self)
        
    }
    
    convenience
    init(dateString:String) {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    // -> Date System Formatted Medium
    func ToMsSqlString() -> NSString? {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter.stringFromDate(self)
        
    }
}