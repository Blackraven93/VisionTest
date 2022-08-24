//
//  helper.swift
//  VisionTest
//
//  Created by blackRaven on 2022/08/25.
//

import UIKit

extension UIViewController {
    private func convertUnitToPoint (originalImageRect: CGRect, targetRect: CGRect) -> CGRect {
        var pointRect = targetRect
        
        pointRect.origin.x = originalImageRect.origin.x + (targetRect.origin.x * originalImageRect.size.width)
        pointRect.origin.y = originalImageRect.origin.y + (1 - targetRect.origin.y - targetRect.height) * originalImageRect.size.height
        pointRect.size.width *= originalImageRect.size.width
        pointRect.size.height *= originalImageRect.size.height
        
        return pointRect
    }
}
