import UIKit
import Foundation

// Probb 1
do {
    let m = 2.9
    let l = 3.0
    let d = 0.6
    let monkeyMass = 1.45

    let t1 = ((m + monkeyMass) * 9.8 * 3/2) / (l - d)

    let t2 = (m + monkeyMass) * 9.8 - t1
}

// Mountaineers often use a rop
do {
//    let massClimber = 75.7
//    let weightClimber = 741.86
//    let heightClimber = 1.88
//    let distanceOfCenter = 1.3
//    let angleCliffMan = 35.0
//    let heightHoldingPoint = 1.58
//    let angleRopeCliff = 22.3
    
    let massClimber = 82.0
    let weightClimber = 741.86
    let heightClimber = 1.9
    let distanceOfCenter = 1.1
    let angleCliffMan = 35.0
    let heightHoldingPoint = 1.4
    let angleRopeCliff = 25
    
    
    let T = (weightClimber * distanceOfCenter * cos(angleCliffMan))
            / (heightHoldingPoint * cos(10))
}


var m = 0.652
var v = 0.33
var r = 0.192
var fi = 35.0

var L = m*v*r*sin(fi)
