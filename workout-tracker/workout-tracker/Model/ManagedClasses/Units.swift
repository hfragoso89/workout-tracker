//
//  Units.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import Foundation

struct Weight {
    
    private var lbValue:Double
    private var kgValue:Double
    
    init(withKgValue kg:Double) {
        self.kgValue = kg
        self.lbValue = kg * 2.20462
    }
    
    init(withLbValue lb:Double) {
        self.lbValue = lb
        self.kgValue = lb / 2.20462
    }
    
    func doubleValue(for type:WeightUnits, withPrecision precision:Int?) -> Double {
        if type == .kg {
            return kgValue.rounded(toPlaces: precision ?? 1)
        } else {
            return lbValue.rounded(toPlaces: precision ?? 1)
        }
    }
    
    func stringValue(for type:WeightUnits, withPrecision precision:Int?) -> String {
        if type == .kg {
            return "\(kgValue.rounded(toPlaces: precision ?? 1)) kg."
        } else {
            return "\(lbValue.rounded(toPlaces: precision ?? 1)) lb."
        }
    }
    
    func intValue(for type:WeightUnits) -> Int {
        if type == .kg {
            return Int(kgValue.rounded(toPlaces:0))
        } else {
            return Int(lbValue.rounded(toPlaces:0))
        }
    }
}

enum WeightUnits {
    case lb
    case kg
}

struct Height {
    private var cmValue:Double
    private var mValue:Double
    private var inchValue:Double
    private var ftValue:Double
    private var ftInchValue:(ft:Int,inch:Int)
    private var mCmValue:(m:Int,cm:Int)
    
    init(withCmValue value:Double) {
        self.cmValue = value
        self.mValue = value / 100
        self.inchValue = value / 2.54
        self.ftValue = value * 0.0328084
        self.mCmValue.m = Int(self.cmValue.truncatingRemainder(dividingBy: 100))
        self.mCmValue.cm = Int(value - Double(self.mCmValue.m * 100))
        self.ftInchValue.ft = Int(self.ftValue.truncatingRemainder(dividingBy: 1.0))
        self.ftInchValue.inch = Int(value - (Double(self.ftInchValue.ft) / 0.0328084))
    }
    
    init(withMValue value:Double) {
        self.cmValue = value * 100
        self.mValue = value
        self.inchValue = value * 39.37008
        self.ftValue = value * 3.28084
        self.mCmValue.m = Int(self.cmValue.truncatingRemainder(dividingBy: 100))
        self.mCmValue.cm = Int(value - Double(self.mCmValue.m * 100))
        self.ftInchValue.ft = Int(self.ftValue.truncatingRemainder(dividingBy: 1.0))
        self.ftInchValue.inch = Int(value - (Double(self.ftInchValue.ft) / 0.0328084))
    }
    
    init(withInchValue value:Double) {
        self.cmValue = value * 2.54
        self.mValue = value * 0.0254
        self.inchValue = value
        self.ftValue = value * 0.08333333
        self.mCmValue.m = Int(self.cmValue.truncatingRemainder(dividingBy: 100))
        self.mCmValue.cm = Int(value - Double(self.mCmValue.m * 100))
        self.ftInchValue.ft = Int(self.ftValue.truncatingRemainder(dividingBy: 1.0))
        self.ftInchValue.inch = Int(value - (Double(self.ftInchValue.ft) / 0.0328084))
    }
    
    init(withFtValue value:Double) {
        self.cmValue = value * 30.48
        self.mValue = value * 0.3048
        self.inchValue = value * 12
        self.ftValue = value
        self.mCmValue.m = Int(self.cmValue.truncatingRemainder(dividingBy: 100))
        self.mCmValue.cm = Int(value - Double(self.mCmValue.m * 100))
        self.ftInchValue.ft = Int(self.ftValue.truncatingRemainder(dividingBy: 1.0))
        self.ftInchValue.inch = Int(value - (Double(self.ftInchValue.ft) / 0.0328084))
    }
    
    init(withFtInchValue value:(ft:Int,inch:Int)) {
        let cmCalculatedValue = (Double(value.ft) * 0.3048) + (Double(value.inch) * 30.48)
        self.cmValue = cmCalculatedValue
        self.mValue = cmCalculatedValue / 100
        self.inchValue = cmCalculatedValue / 2.5
        self.ftValue = cmCalculatedValue * 0.0328084
        self.mCmValue.m = Int(self.cmValue.truncatingRemainder(dividingBy: 100))
        self.mCmValue.cm = Int(cmCalculatedValue - Double(self.mCmValue.m * 100))
        self.ftInchValue = value
    }
    
    func doubleValue(for type:LenghtUnit, withPrecision precision:Int?) -> Double {
        switch type {
        case .m:
            return mValue.rounded(toPlaces: precision ?? 2)
        case .cm:
            return cmValue.rounded(toPlaces: precision ?? 1)
        case .inch:
            return inchValue.rounded(toPlaces: precision ?? 1)
        case .ft:
            return ftValue.rounded(toPlaces: precision ?? 2)
        }
    }
    
    func ftInchRawValue() -> (ft: Int, inch: Int) {
        return ftInchValue
    }
    
    func mCmRawValue() -> (m: Int, cm: Int) {
        return mCmValue
    }
    
    func stringValue (for type:LenghtUnit, withPrecision precision:Int?) -> String {
        switch type {
        case .m:
            return "\(mValue.rounded(toPlaces: precision ?? 2)) m."
        case .cm:
            return "\(cmValue.rounded(toPlaces: precision ?? 1)) cm."
        case .inch:
            return "\(inchValue.rounded(toPlaces: precision ?? 1)) inch."
        case .ft:
            return "\(ftValue.rounded(toPlaces: precision ?? 2)) ft."
        }
    }
    
    func americanHeightString() -> String {
        return "\(self.ftInchValue.ft)' \(self.ftInchValue.inch)''"
    }
}

enum LenghtUnit {
    case m
    case cm
    case inch
    case ft
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
