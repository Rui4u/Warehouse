//
//  Animial.swift
//  ScreenLock
//
//  Created by sharui on 2022/12/30.
//

import SwiftUI

public struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    public var animatableData: CGFloat

    public init(animatableData: CGFloat, amount: CGFloat = 10, shakesPerUnit: Int = 3) {
        self.amount = amount
        self.shakesPerUnit = shakesPerUnit
        self.animatableData = animatableData
    }
    
    public func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
        
    }
}

