//
//  NSAttributedString+GXAdd.swift
//  GXCategoriesSample
//
//  Created by Gin on 2025/5/28.
//

import Foundation

public extension NSAttributedString {
    
    func size(maxSize: CGSize) -> CGSize {
        let rect = self.boundingRect(with: maxSize,
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     context: nil)
        return rect.size
    }

    func height(width: CGFloat) -> CGFloat {
        let size = self.size(maxSize: CGSize(width: width, height: CGFLOAT_MAX))
        return size.height
    }
    
    func width() -> CGFloat {
        let size = self.size(maxSize: CGSize(width: CGFLOAT_MAX, height: CGFLOAT_MAX))
        return size.width
    }

}
