//
//  UITableView+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/13.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension UITableView {
    
    /// 配置tableView
    /// - Parameters:
    ///   - estimated: 是否开启估算
    ///   - mode: 键盘隐藏模式
    ///   - separatorLeft: 分割线是否居左
    ///   - footerZero: 页脚设置（去掉多余分割线）
    func configuration(estimated: Bool = false, mode: UIScrollView.KeyboardDismissMode = .onDrag, separatorLeft: Bool = true, footerZero: Bool = true) {
        if !estimated {
            self.estimatedRowHeight = 0
            self.estimatedSectionHeaderHeight = 0
            self.estimatedSectionFooterHeight = 0
        }
        self.keyboardDismissMode = mode
        if separatorLeft {
            if #available(iOS 7.0, *) {
                self.separatorInset = .zero
            }
            if #available(iOS 8.0, *) {
                self.layoutMargins = .zero
            }
        }
        if footerZero {
            self.tableFooterView = UIView()
        }
    }
    
    /// 批量更新
    /// - Parameters:
    ///   - block: 内容处理block
    ///   - completion: 完成回调
    func updateWithBlock(_ block: (UITableView?)->Void, completion: ((Bool) -> Void)? = nil) {
        if #available(iOS 11.0, *) {
            self.performBatchUpdates {[weak self] in
                block(self)
            } completion: { (finished) in
                completion?(finished)
            }
        }
        else {
            self.beginUpdates()
            block(self)
            self.endUpdates()
            completion?(true)
        }
    }

    func scrollToRow(row: Int, section: Int, scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        let indexPath = IndexPath(row: row, section: section)
        self.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    func insertRow(at indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self.insertRows(at: [indexPath], with: animation)
    }
    
    func insertRow(row: Int, section: Int, with animation: UITableView.RowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        self.insertRows(at: [indexPath], with: animation)
    }
    
    func reloadRow(at indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self.reloadRows(at: [indexPath], with: animation)
    }
    
    func reloadRow(row: Int, section: Int, with animation: UITableView.RowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        self.reloadRows(at: [indexPath], with: animation)
    }
    
    func deleteRow(at indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self.deleteRows(at: [indexPath], with: animation)
    }
    
    func deleteRow(row: Int, section: Int, with animation: UITableView.RowAnimation) {
        let indexPath = IndexPath(row: row, section: section)
        self.deleteRows(at: [indexPath], with: animation)
    }
    
    func insertSection(_ section: Int, with animation: UITableView.RowAnimation) {
        let sections = IndexSet(arrayLiteral: section)
        self.insertSections(sections, with: animation)
    }

    func deleteSection(_ section: Int, with animation: UITableView.RowAnimation) {
        let sections = IndexSet(arrayLiteral: section)
        self.deleteSections(sections, with: animation)
    }
    
    func reloadSection(_ section: Int, with animation: UITableView.RowAnimation) {
        let sections = IndexSet(arrayLiteral: section)
        self.reloadSections(sections, with: animation)
    }
    
    func clearSelectedRows(animated: Bool) {
        if let indexs = self.indexPathsForSelectedRows {
            for indexPath in indexs {
                self.deselectRow(at: indexPath, animated: animated)
            }
        }
    }

}
