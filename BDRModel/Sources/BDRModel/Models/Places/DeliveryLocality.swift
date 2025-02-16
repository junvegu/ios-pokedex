//
//  DeliveryLocality.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 12/02/24.
//

import Foundation

public class DeliveryLocality: NSObject {
    public let uid: String
    public let name: String

    public init(uid: String, name: String) {
        self.uid = uid
        self.name = name
    }
    
    public override var description: String {
        return name
    }
    
}

public class HourInvertal: NSObject {
    public let date: String
    public let dateF: Date
    
    public init(date: String, dateF: Date) {
        self.date = date
        self.dateF = dateF
    }
    public override var description: String {
        return date
    }
}

public class IntervalModel : NSObject {
    
    public var starts : String = ""
    public var total : Int = 0
    public var ends : String = ""
    public var select : Bool = false
    public var date : String = ""
    public var startsS : String = ""
    public var endsS : String = ""
    public override var description: String {
         return  "\(starts) a \(ends)"

    }
   /* class func serializedModel(fromJSON json: JSON?) -> IntervalModel? {
        if let data = json {
            let item = IntervalModel()
            let ends = data["ends"].stringValue
            let starts = data["starts"].stringValue
            item.endsS = data["ends"].stringValue
            item.startsS  = data["starts"].stringValue
            
            if let date = DateFormatter.sharedFormatter.dateFromString(ends,withFormat: kHour24Formatter) {
                let dateEndHour = DateFormatter.sharedFormatter.stringFromDate(date, withFormat: kHourFormatter)
                item.ends = dateEndHour
            }
            if let date = DateFormatter.sharedFormatter.dateFromString(starts,withFormat: kHour24Formatter) {
                let dateEndHour = DateFormatter.sharedFormatter.stringFromDate(date, withFormat: kHourFormatter)
                item.starts = dateEndHour
            }
        
            item.total =  data["total"].intValue
            return item
        }
        return nil
    }
    
    class func serializedArray(fromJSONArray array: [JSON]?) -> [IntervalModel] {
        var items: [IntervalModel] = []
        if let array = array {
            for json in array {
                let item = IntervalModel.serializedModel(fromJSON: json)
                items.append(item!)
            }
        }
        return items
    }*/
}
