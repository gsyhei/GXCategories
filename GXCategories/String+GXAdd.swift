//
//  String+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/10/22.
//  Copyright © 2020 Gin. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    // MARK: - 字符串截取subscript
    
    /// String使用下标截取字符串
    /// string[index] 例如："abcdefg"[3] // c
    subscript (i: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: i)
        let endIndex = self.index(startIndex, offsetBy: 1)
        return String(self[startIndex..<endIndex])
    }
    
    /// String使用下标截取字符串
    /// string[index..<index] 例如："abcdefg"[3..<4] // d
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    /// String使用下标截取字符串
    /// string[index,length] 例如："abcdefg"[3,2] // de
    subscript (index: Int, length: Int) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let endIndex = self.index(startIndex, offsetBy: length)
            return String(self[startIndex..<endIndex])
        }
    }
    /// 截取 从头到i位置
    func substring(to: Int) -> String{
        return self[0..<to]
    }
    
    /// 截取 从i到尾部
    func substring(from: Int) -> String {
        return self[from..<self.count]
    }
    
    /// 截取 NSRange
    func substring(range: NSRange) -> String {
        return self[range.location, range.length]
    }
    
    /// range of all
    func rangeOfAll() -> NSRange {
        return NSRange(location: 0, length: self.count)
    }
    
    // MARK: - 编解码（MD5/SHA）
    
    @available(iOS, introduced: 2.0, deprecated: 13.0, message: "This function is cryptographically broken and should not be used in security contexts. Clients should migrate to SHA256 (or stronger).")
    func md5String() -> String? {
        return self.data(using: .utf8)?.md5String()
    }
    
    func sha1String() -> String? {
        return self.data(using: .utf8)?.sha1String()
    }
    
    func sha224String() -> String? {
        return self.data(using: .utf8)?.sha224String()
    }
    
    func sha256String() -> String? {
        return self.data(using: .utf8)?.sha256String()
    }
    
    func sha384String() -> String? {
        return self.data(using: .utf8)?.sha384String()
    }
    
    func sha512String() -> String? {
        return self.data(using: .utf8)?.sha512String()
    }
    
    func crc32String() -> String? {
        return self.data(using: .utf8)?.crc32String()
    }
    
    func hmacMD5String(key: String) -> String? {
        return self.data(using: .utf8)?.hmacMD5String(key: key)
    }
    
    func hmacSHA1String(key: String) -> String? {
        return self.data(using: .utf8)?.hmacSHA1String(key: key)
    }
    
    func hmacSHA224String(key: String) -> String? {
        return self.data(using: .utf8)?.hmacSHA224String(key: key)
    }
    
    func hmacSHA256String(key: String) -> String? {
        return self.data(using: .utf8)?.hmacSHA256String(key: key)
    }
    
    func hmacSHA384String(key: String) -> String? {
        return self.data(using: .utf8)?.hmacSHA384String(key: key)
    }
    
    func hmacSHA512String(key: String) -> String? {
        return self.data(using: .utf8)?.hmacSHA512String(key: key)
    }
    
    func base64EncodedString() -> String? {
        return self.data(using: .utf8)?.base64EncodedString()
    }
    
    func base64DecodedString() -> String? {
        if let base64Data = Data(base64Encoded: self) {
            return String(data: base64Data, encoding: .utf8)
        }
        return nil
    }
    
    func stringByURLEncode() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)
    }
    
    func stringByURLDecode() -> String? {
        return self.removingPercentEncoding
    }
    
    /// 包含判断
    /// - Parameters:
    ///   - find: 目标字符串
    ///   - options: 匹配方式
    /// - Returns: Bool
    func contains(find: String, options: CompareOptions = []) -> Bool {
        return self.range(of: find, options: options) != nil
    }
    
    /// 获取字符串size
    /// - Parameters:
    ///   - size: 限制size
    ///   - font: 字体
    /// - Returns: 字符串显示的size
    func size(size: CGSize, font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size
    }
    
    /// 获取字符串的height
    /// - Parameters:
    ///   - width: 限制宽度
    ///   - font: 字体
    /// - Returns: 字符串高度
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return self.size(size: maxSize, font: font).height
    }
    
    /// 获取字符串的width
    /// - Parameter font: 字体
    /// - Returns: 字符串宽度
    func width(font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        return self.size(size: maxSize, font: font).width
    }
    
    /// 正则匹配
    func matches(regex: String, options: NSRegularExpression.Options = []) -> Bool {
        guard let pattern = try? NSRegularExpression(pattern: regex, options: options) else { return false }
        return (pattern.numberOfMatches(in: self, options: [], range: self.rangeOfAll()) > 0)
    }
    
    /// 枚举正则匹配
    func enumerateMatches(regex: String, options: NSRegularExpression.Options = [], usingBlock: (String?, NSRange?, UnsafeMutablePointer<ObjCBool>) -> Void) {
        guard let pattern = try? NSRegularExpression(pattern: regex, options: options) else { return }
        pattern.enumerateMatches(in: self, range: self.rangeOfAll()) { (result, flags, stop) in
            if (result != nil) {
                usingBlock(self.substring(range: result!.range), result!.range, stop)
            }
            else {
                usingBlock(nil, nil, stop)
            }
        }
    }
    
    /// 正则替换
    func stringByReplacing(regex: String, options: NSRegularExpression.Options = [], replacement: String) -> String {
        guard let pattern = try? NSRegularExpression(pattern: regex, options: options) else { return self }
        return pattern.stringByReplacingMatches(in: self, range: self.rangeOfAll(), withTemplate: replacement)
    }
    
    /// UUID
    static func stringWithUUID() -> String? {
        let uuid = CFUUIDCreate(kCFAllocatorDefault)
        let cfString = CFUUIDCreateString(kCFAllocatorDefault, uuid)
        return cfString as String?
    }
    
    /// 去掉首尾空格
    func stringByTrim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 判断自是否为nil
    func isNotBlank() -> Bool {
        return self.stringByTrim().count > 0
    }
    
    /// json解码
    func jsonValueDecoded() -> Any? {
        return self.data(using: .utf8)?.jsonValueDecoded()
    }
    
    /// 字符串转拼音
    /// - Parameter isUppercase: 是否大写
    /// - Returns: 转换后的拼音字符串
    func transformToPinYin(isUppercase: Bool = false) -> String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        if isUppercase {
            return string.uppercased()
        }
        else {
            return string
        }
    }
    
    /// 字符串转拼音
    /// - Parameter isUppercase: 是否大写
    /// - Returns: 转换后的拼音字符串
    func transformToPinYinInitial(isUppercase: Bool = false) -> String {
        let mutableString = NSMutableString()
        for i in 0..<self.count {
            let subStr = self[i]
            let pinyin = subStr.transformToPinYin(isUppercase: isUppercase)
            if pinyin.count > 0 {
                mutableString.append(pinyin[0])
            }
        }
        return mutableString as String
    }

}

public extension String {
    /// 正则匹配手机号
    var isMobile: Bool {
        /**
         * 手机号码
         * 移动：134 135 136 137 138 139 147 148 150 151 152 157 158 159  165 172 178 182 183 184 187 188 198
         * 联通：130 131 132 145 146 155 156 166 171 175 176 185 186
         * 电信：133 149 153 173 174 177 180 181 189 199
         * 虚拟：170
         */
        return isMatch("^(1[3-9])\\d{9}$")
    }
    /// 正则匹配用户身份证号15或18位
    var isUserIdCard: Bool {
        return isMatch("(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)")
    }
    /// 正则匹配用户登录密码6-12位数字或字母组合
    var isPassword: Bool {
        //return isMatch("^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,12}") //正则匹配用户登录密码6-12位数字和字母组合
        return isMatch("^[0-9A-Za-z]{6,12}")
    }
    /// 正则匹配URL
    var isURL: Bool {
        return isMatch("^[0-9A-Za-z]{1,50}")
    }
    /// 正则匹配用户姓名,20位的中文或英文
    var isUserName: Bool {
        return isMatch("^[a-zA-Z\\u4E00-\\u9FA5]{1,20}")
    }
    /// 正则匹配用户真实姓名,1～20位的中文
    var isRealName: Bool {
        return isMatch("^[\\u4E00-\\u9FA5]{1,20}")
    }
    /// 正则匹配用户email
    var isEmail: Bool {
        return isMatch("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    /// 正则匹配银行卡号
    var isBankCardNumber: Bool {
        /*    /^(\d{16}|\d{19}|\d{17})$/    */
        return isMatch("^(\\d{16}|\\d{19}|\\d{17})$")
    }
    /// 正则匹配支付密码
    var isPayPwd: Bool {
        return isMatch("^(\\d{6})$") && isNumber
    }
    /// 判断是否都是数字
    var isNumber: Bool {
        return isMatch("^[0-9]*$")
    }
    /// 只能输入由26个英文字母组成的字符串
    var isLetter: Bool {
        return isMatch("^[A-Za-z]+$")
    }
    /// 正则匹配
    func isMatch(_ pred: String ) -> Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", pred)
        let isMatch: Bool = pred.evaluate(with: self)
        return isMatch
    }
}
