//
//  GradientView.swift
//  Historios
//
//  Created by Brandi Taylor on 12/7/20.
//

import Foundation
import UIKit

class GradientView: UIView {

    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [#colorLiteral(red: 0.2745098039, green: 0.7843137255, blue: 0.9294117647, alpha: 1), #colorLiteral(red: 0.07843137255, green: 0.07058823529, blue: 0.1725490196, alpha: 1)]
    }
}
