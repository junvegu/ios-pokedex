//
//  DateFormatter.swift
//  
//
//  Created by Junior on 4/12/21.
//

import Foundation

public let kDateFormatterFromPicker = "yyyy-MM-dd HH:mm:ss";
public let kDateFormatterSimple = "yyyy-MM-dd";

public let kDateFormatter = "dd-MM-yyyy hh:mm a";
public let kHour24Formatter = "HH:mm:ss";
public let kHourFormatter = "hh:mm a";
public let kJSONDateFormatter = "yyyy-MM-dd\'T\'HH:mm:ss";
public let kJSONDjangoServer = "yyyy-MM-dd";
public let kFormatLocal = "dd/MM/yyyy";
public let kServerDateFormatter  = "yyyy-MM-dd'T'HH:mm:ss.SZ"
public let kJSONDateFormatterByOrder = "EEEE dd 'de' MMMM',' HH:mm"
public let kFormatterDelivery = "EEEE, dd 'de' MMMM"
public let prettyFormat = "EEEE dd 'de' MMMM"
public let prettyFormatFull = "EEEE dd 'de' MMMM 'de' YYYY"
public let prettyFormatShort = "dd MMM YYYY"

public extension DateFormatter {
    
    class var sharedFormatter: DateFormatter {
        return DateFormatter(withFormat: kJSONDateFormatter)
    }
    
    // MARK: - Lifecycle
    fileprivate convenience init(withFormat format:String) {
        self.init()
        self.timeZone = TimeZone.autoupdatingCurrent
        self.locale = Locale(identifier: "es")
        self.dateFormat = format
    }
    
    // MARK: - Private
    fileprivate func dateFromStringAndSetBackFormat(_ dateString:String) -> Date? {
        let date = self.date(from: dateString)
        self.dateFormat = kDateFormatter
        return date;
    }
    
    fileprivate func stringFromDateAndSetBackFormat(_ date:Date) -> String {
        let dateString = self.string(from: date)
        self.dateFormat = kDateFormatter
        return dateString
    }
    
    // MARK: - Public
    func stringFromDate(_ date:Date, withFormat format:String) -> String {
        self.dateFormat = format
        return self.stringFromDateAndSetBackFormat(date)
    }
    
    func dateFromString(_ dateString:String, withFormat format:String) -> Date? {
        self.dateFormat = format
        return self.dateFromStringAndSetBackFormat(dateString)
    }
}

