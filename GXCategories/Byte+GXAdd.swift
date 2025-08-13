//
//  Byte+GXAdd.swift
//  GXCategoriesSample
//
//  Created by Gin on 2025/1/27.
//

import UIKit

// MARK: UInt8等于Byte，一个字节8位
public extension UInt8 {
    var gx_hexString: String {
        let str = String(format:"0x%02X", self)
        return str
    }
    var gx_bString: String {
        // 转2进制，输出的内容是有效位，左侧的0没有
        var str = String(self, radix: 2)
        // 一个UInt用二进制来方，是8位
        let preCount = 8 - str.count
        if preCount > 0 {
            let preStr = Array(repeating: "0", count: preCount).joined()
            str = preStr + str
        }
        return str
    }
    /// 读取对应位置上的数字（结果是0或者1）
    func gx_readBit(index: UInt8) -> UInt8 {
        // 确保 position 在有效范围内
        guard index < UInt8.bitWidth else {
            fatalError("Position \(index) is out of range for UInt8")
        }
        // 读取第 N 位的值
        return (self >> index) & 1
    }
    /// 按bit位得到数字
    func gx_readBits(range: NSRange) -> UInt8 {
        // 将 NSRange 转换为 UInt
        let location = range.location
        let length = range.length
        // 确保 range 有效
        guard location < UInt8.bitWidth, length > 0, location + length <= UInt8.bitWidth else {
            fatalError("Invalid bit range")
        }
        // 生成掩码
        let mask = UInt8(1) << length - 1
        // 提取 bit 值
        let bits = (self >> location) & mask
        
        return bits
    }
    /// 给对应位置上设置指定的值（只能设置0或者1），返回修改后的新值
    func gx_writeBit(index: UInt8, to value: Bool) -> UInt8 {
        // 确保 position 在有效范围内
        guard index < UInt8.bitWidth else {
            fatalError("Position \(index) is out of range for UInt8")
        }
        if value {
            // 设置第 N 位为 1
            return self | (1 << index)
        }
        else {
            // 设置第 N 位为 0
            return self & ~(1 << index)
        }
    }
    /// 给对应位置range上的bit设置指定的值，返回修改后的新值
    func gx_writeBits(range: NSRange, to value: UInt8) -> UInt8 {
        // 将 NSRange 转换为 Int
        let location = range.location
        let length = range.length
        // 确保 range 有效
        guard location < UInt8.bitWidth, length > 0, location + length <= UInt8.bitWidth else {
            fatalError("Invalid bit range")
        }
        // 确保 value 在有效范围内
        let maxValue = (1 << length) - 1
        guard value <= maxValue else {
            fatalError("Value exceeds the maximum for the specified bit range")
        }
        // 生成清除掩码
        let clearMask = ((UInt8(1) << length) - 1) << location
        // 清除目标 bit 范围
        var result = self & ~clearMask
        // 设置目标 bit 范围
        result |= (value << location)
        
        return result
    }
    
}

// MARK: Data 与 [UInt8]、NSData是等价的
public extension Data {
    var gx_nsData: NSData {
        return (self as NSData)
    }
    var gx_bytes: [UInt8] {
        return [UInt8](self)
    }
    func gx_subData(range: NSRange) -> Data {
        return self.gx_nsData.subdata(with: range)
    }
    func gx_subBytes(range: NSRange) -> [UInt8] {
        return self.gx_subData(range: range).gx_bytes
    }
    // MARK: - Data\Bytes -> 数字
    func gx_numberVal<T: FixedWidthInteger>() -> T {
        // 当前类型需要几个字节来放
        let size = MemoryLayout<T>.size
        return subdata(in: 0..<size).withUnsafeBytes { $0.load(as: T.self) }
    }
    var gx_strVal: String? {
        return String(data: self, encoding: .utf8)
    }
    var gx_hexString: String {
        self.map({ $0.gx_hexString }).joined(separator: " ")
    }
    var gx_bString: String {
        self.map({ $0.gx_bString }).joined(separator: " ")
    }
    var reversedHex: String {
        var result = "0x"
        for byte in self.bytes.reversed() {
            result = result.appendingFormat("%02X", byte)
        }
        return result
    }
    var macAddress: String {
        return self.map { String(format: "%02X", $0) }.joined(separator: ":")
    }
}

// MARK: - 字节数组（Element == UInt8）
public extension Array where Element == UInt8 {
    var gx_data: Data {
        return Data(self)
    }
    var gx_nsData: NSData {
        return self.gx_data.gx_nsData
    }
    func gx_subData(range: NSRange) -> Data {
        return self.gx_data.gx_subData(range: range)
    }
    func gx_subBytes(range: NSRange) -> [UInt8] {
        return self.gx_data.gx_subBytes(range: range)
    }
    func gx_numberVal<T: FixedWidthInteger>() -> T {
        return self.gx_data.gx_numberVal()
    }
    var gx_strVal: String? {
        return self.gx_data.gx_strVal
    }
    var gx_hexString: String {
        return self.gx_data.gx_hexString
    }
    var gx_bString: String {
        return self.gx_data.gx_bString
    }
    func gx_crc16() -> UInt16 {
        let count = self.count
        var crc: UInt16 = 0
        for i in 0..<count {
            crc = crc ^ UInt16(self[i] << 8)
            for _ in 1..<8 {
                if ((crc & 0x8000) != 0) {
                    crc = crc << 1 ^ 0x1021
                } else {
                    crc = crc << 1
                }
            }
        }
        return (crc & 0xFFFF)
    }
}

// MARK: - 数字转化 -> Data/Bytes/[UInt8]
public extension FixedWidthInteger {
    var gx_bytes: [UInt8] {
        // 当前类型需要几个字节来放
        let size = MemoryLayout<Self>.size
        var bytes = [UInt8]()
        for i in 0..<size {
            let distance = (size - 1 - i) * 8;
            let sub  = self >> distance
            let value = UInt8(sub & 0xff)
            bytes.append(value)
        }
        return bytes
    }
    var gx_data: Data {
        return self.gx_bytes.gx_data
    }
}

// MARK: - 范围扩展
public extension NSRange {
    var gx_nextLocation: Int {
        return self.location + self.length
    }
    func gx_nextRange(length: Int) -> NSRange {
        return NSRange(location: self.gx_nextLocation, length: length)
    }
}
