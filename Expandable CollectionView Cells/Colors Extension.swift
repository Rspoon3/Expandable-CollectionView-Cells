//
//  Colors Extension.swift
//  Reminder(s)
//
//  Created by Richard Witherspoon on 3/24/19.
//  Copyright © 2019 Richard Witherspoon. All rights reserved.
//

import UIKit

extension UIColor{
    
    static func random () -> UIColor {
        return UIColor(
            red   : CGFloat.random(in: 0...1),
            green : CGFloat.random(in: 0...1),
            blue  : CGFloat.random(in: 0...1),
            alpha : 1.0)
    }
    
    static let backgroundGray = UIColor.init(displayP3Red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)

    struct Apple {
        static let red = UIColor(displayP3Red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1)
        static let orange = UIColor(displayP3Red: 255.0/255.0, green: 149.0/255.0, blue: 0, alpha: 1)
        static let yellow = UIColor(displayP3Red: 255.0/255.0, green: 204.0/255.0, blue: 0, alpha: 1)
        static let green = UIColor(displayP3Red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1)
        static let tealBlue = UIColor(displayP3Red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1)
        static let blue = UIColor(displayP3Red: 0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1)
        static let purple = UIColor(displayP3Red: 88.0/255.0, green: 86.0/255.0, blue: 214.0/255.0, alpha: 1)
        static let pink = UIColor(displayP3Red: 255.0/255.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1)
    }
    
   

    
    
    
}
