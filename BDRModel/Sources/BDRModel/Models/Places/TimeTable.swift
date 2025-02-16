//
//  File.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 13/02/24.
//

import Foundation

public struct TimeTable{
    public let mondayHoursFrom : String
    public let mondayHoursTo : String
    public let tuesdayHoursFrom : String
    public let tuesdayHoursTo : String
    public let wednesdayHoursFrom : String
    public let wednesdayHoursTo : String
    public let thursdayHoursFrom : String
    public let thursdayHoursTo : String
    public let fridayHoursFrom : String
    public let fridayHoursTo : String
    public let saturdayHoursFrom : String
    public let saturdayHoursTo : String
    public let sundayHoursFrom : String
    public let sundayHoursTo : String
    public let extra : String
    
    public init(mondayHoursFrom: String?, mondayHoursTo: String?, tuesdayHoursFrom: String?, tuesdayHoursTo: String?, wednesdayHoursFrom: String?, wednesdayHoursTo: String?, thursdayHoursFrom: String?, thursdayHoursTo: String?, fridayHoursFrom: String?, fridayHoursTo: String?, saturdayHoursFrom: String?, saturdayHoursTo: String?, sundayHoursFrom: String?, sundayHoursTo: String?, extra: String?) {
        self.mondayHoursFrom = mondayHoursFrom ?? "-"
        self.mondayHoursTo = mondayHoursTo ?? "-"
        self.tuesdayHoursFrom = tuesdayHoursFrom ?? "-"
        self.tuesdayHoursTo = tuesdayHoursTo ?? "-"
        self.wednesdayHoursFrom = wednesdayHoursFrom ?? "-"
        self.wednesdayHoursTo = wednesdayHoursTo ?? "-"
        self.thursdayHoursFrom = thursdayHoursFrom ?? "-"
        self.thursdayHoursTo = thursdayHoursTo ?? "-"
        self.fridayHoursFrom = fridayHoursFrom ?? "-"
        self.fridayHoursTo = fridayHoursTo ?? "-"
        self.saturdayHoursFrom = saturdayHoursFrom ?? "-"
        self.saturdayHoursTo = saturdayHoursTo ?? "-"
        self.sundayHoursFrom = sundayHoursFrom ?? "-"
        self.sundayHoursTo = sundayHoursTo ?? "-"
        self.extra = extra ?? "-"
    }
    
    public var monday: String {
        if mondayHoursFrom != "-" {
            "Lunes: \(mondayHoursFrom) a \(mondayHoursTo)"
        } else {
            "Lunes: Cerrado"
        }
    }
    public var tuesday: String {
        if tuesdayHoursFrom != "-" {
            "Martes: \(tuesdayHoursFrom) a \(tuesdayHoursTo)"
        } else {
            "Martes: Cerrado"
        }
    }
    public var wednesday: String {
        if tuesdayHoursFrom != "-" {
            "Miercoles: \(wednesdayHoursFrom) a \(wednesdayHoursTo)"
        } else {
            "Miercoles: Cerrado"
        }
    }
    public var thursday: String {
        if thursdayHoursFrom != "-" {
            "Jueves: \(thursdayHoursFrom) a \(thursdayHoursTo)"
        } else {
            "Jueves: Cerrado"
        }
    }
    public var friday: String {
        if fridayHoursFrom != "-" {
            "Viernes: \(fridayHoursFrom) a \(fridayHoursTo)"
        } else {
            "Viernes: Cerrado"
        }
    }
    public var saturdar: String {
        if saturdayHoursFrom != "-" {
            "Sábado: \(saturdayHoursFrom) a \(saturdayHoursTo)"
        } else {
            "Sábado: Cerrado"
        }
    }
    public var sunday: String {
        if sundayHoursFrom != "-" {
            "Domingo: \(sundayHoursFrom) a \(sundayHoursTo)"
        } else {
            "Domingo: Cerrado"
        }
    }
}
