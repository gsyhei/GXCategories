//
//  UITableView+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/11/13.
//  Copyright © 2020 Gin. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func updateWithBlock(_ block: (UITableView)->Void) {
        self.beginUpdates()
        block(self)
        self.endUpdates()
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
