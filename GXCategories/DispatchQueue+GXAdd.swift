//
//  DispatchQueue+GXAdd.swift
//  GXCategoriesSample
//
//  Created by Gin on 2022/4/8.
//

import Foundation

extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    public class func once(token: String, block: () -> ()) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) { return }
        _onceTracker.append(token)
        block()
    }
}
