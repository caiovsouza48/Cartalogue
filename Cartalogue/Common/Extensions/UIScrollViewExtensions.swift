//
//  UIScrollViewExtensions.swift
//  Cartalogue
//
//  Created by Caio de Souza on 26/04/2018.
//  Copyright © 2018 Caio de Souza. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    var isNearBottomEdge : Bool {
        return contentOffset.y + self.frame.size.height + 20.0 > self.contentSize.height
    }
    
    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset.rounded()
    }
    
}
