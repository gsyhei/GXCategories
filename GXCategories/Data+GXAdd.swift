//
//  Data+GXAdd.swift
//  GXCategoriesDemo
//
//  Created by Gin on 2020/10/2.
//  Copyright © 2020 Gin. All rights reserved.
//

import Foundation
import CommonCrypto
import zlib

/// base64算法在swift已自带self.base64EncodedString(), self.base64EncodedData()

public extension Data {
    var bytes: Array<UInt8> {
        return Array(self)
    }
}

public extension Data {
    
    // MARK: - 编解码（MD5/SHA）
    
    @available(iOS, introduced: 2.0, deprecated: 13.0, message: "This function is cryptographically broken and should not be used in security contexts. Clients should migrate to SHA256 (or stronger).")
    func md5String() -> String {
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(self.bytes, CC_LONG(self.count), result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return hash as String
    }
    
    @available(iOS, introduced: 2.0, deprecated: 13.0, message: "This function is cryptographically broken and should not be used in security contexts. Clients should migrate to SHA256 (or stronger).")
    func md5Data() -> Data {
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(self.bytes, CC_LONG(self.count), result)
        let data = Data(bytes: result, count: digestLen)
        free(result)
        return data
    }
    
    func sha1String() -> String {
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(self.bytes, CC_LONG(self.count), result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return hash as String
    }
    
    func sha1Data() -> Data {
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(self.bytes, CC_LONG(self.count), result)
        let data = Data(bytes: result, count: digestLen)
        free(result)
        return data
    }
    
    func sha224String() -> String {
        let digestLen = Int(CC_SHA224_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA224(self.bytes, CC_LONG(self.count), result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return hash as String
    }
    
    func sha224Data() -> Data {
        let digestLen = Int(CC_SHA224_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA224(self.bytes, CC_LONG(self.count), result)
        let data = Data(bytes: result, count: digestLen)
        free(result)
        return data
    }
    
    func sha256String() -> String {
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA256(self.bytes, CC_LONG(self.count), result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return hash as String
    }
    
    func sha256Data() -> Data {
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA256(self.bytes, CC_LONG(self.count), result)
        let data = Data(bytes: result, count: digestLen)
        free(result)
        return data
    }
    
    func sha384String() -> String {
        let digestLen = Int(CC_SHA384_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA384(self.bytes, CC_LONG(self.count), result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return hash as String
    }
    
    func sha384Data() -> Data {
        let digestLen = Int(CC_SHA384_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA384(self.bytes, CC_LONG(self.count), result)
        let data = Data(bytes: result, count: digestLen)
        free(result)
        return data
    }
    
    func sha512String() -> String {
        let digestLen = Int(CC_SHA512_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA512(self.bytes, CC_LONG(self.count), result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return hash as String
    }
    
    func sha512Data() -> Data {
        let digestLen = Int(CC_SHA512_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA512(self.bytes, CC_LONG(self.count), result)
        let data = Data(bytes: result, count: digestLen)
        free(result)
        return data
    }
        
    func hmacStringUsing(alg: CCHmacAlgorithm, key: String) -> String? {
        var digestLen: Int
        switch alg {
        case CCHmacAlgorithm(kCCHmacAlgMD5):
            digestLen = Int(CC_MD5_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA1):
            digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA224):
            digestLen = Int(CC_SHA224_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA256):
            digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA384):
            digestLen = Int(CC_SHA384_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA512):
            digestLen = Int(CC_SHA512_DIGEST_LENGTH)
        default: return nil
        }
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CCHmac(alg, key, key.count, self.bytes, self.count, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return hash as String
    }
    
    func hmacDataUsing(alg: CCHmacAlgorithm, key: Data) -> Data? {
        var digestLen: Int
        switch alg {
        case CCHmacAlgorithm(kCCHmacAlgMD5):
            digestLen = Int(CC_MD5_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA1):
            digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA224):
            digestLen = Int(CC_SHA224_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA256):
            digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA384):
            digestLen = Int(CC_SHA384_DIGEST_LENGTH)
        case CCHmacAlgorithm(kCCHmacAlgSHA512):
            digestLen = Int(CC_SHA512_DIGEST_LENGTH)
        default: return nil
        }
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CCHmac(alg, key.bytes, key.count, self.bytes, self.count, result)
        let data = Data(bytes: result, count: digestLen)
        free(result)
        return data
    }
        
    func hmacDataUsing(key: Data) -> Data? {
        return self.hmacDataUsing(alg: CCHmacAlgorithm(kCCHmacAlgMD5), key: key)
    }
    
    func hmacMD5String(key: String) -> String? {
        return self.hmacStringUsing(alg: CCHmacAlgorithm(kCCHmacAlgMD5), key: key)
    }
    
    func hmacSHA1Data(key: Data) -> Data? {
        return self.hmacDataUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA1), key: key)
    }
    
    func hmacSHA1String(key: String) -> String? {
        return self.hmacStringUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA1), key: key)
    }
    
    func hmacSHA224Data(key: Data) -> Data? {
        return self.hmacDataUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA224), key: key)
    }
    
    func hmacSHA224String(key: String) -> String? {
        return self.hmacStringUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA224), key: key)
    }
    
    func hmacSHA256Data(key: Data) -> Data? {
        return self.hmacDataUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA256), key: key)
    }
    
    func hmacSHA256String(key: String) -> String? {
        return self.hmacStringUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA256), key: key)
    }
    
    func hmacSHA384Data(key: Data) -> Data? {
        return self.hmacDataUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA384), key: key)
    }
    
    func hmacSHA384String(key: String) -> String? {
        return self.hmacStringUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA384), key: key)
    }
    
    func hmacSHA512Data(key: Data) -> Data? {
        return self.hmacDataUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA512), key: key)
    }
    
    func hmacSHA512String(key: String) -> String? {
        return self.hmacStringUsing(alg: CCHmacAlgorithm(kCCHmacAlgSHA512), key: key)
    }
    
    // MARK: - crc32/aes256
    
    func crc32UInt() -> UInt32 {
        let uPointer: UnsafePointer<Bytef> = self.withUnsafeBytes {$0.load(as: UnsafePointer<Bytef>.self)}
        let result = zlib.crc32(0, uPointer, uInt(self.count))
        return UInt32(result)
    }
    
    func crc32String() -> String {
        return String(format: "%08x", self.crc32UInt())
    }
    
    func aes256Encrypt(key: Data, iv: Data) -> Data? {
        guard key.count == 16 || key.count == 24 || key.count == 32 else { return nil }
        guard iv.count == 16 || iv.count == 0 else { return nil }
        let bufferSize = self.count + kCCBlockSizeAES128
        let buffer = malloc(bufferSize)
        guard buffer != nil else { return nil }
        var encryptedSize: size_t = 0
        let cryptStatus: CCCryptorStatus = CCCrypt(CCOperation(kCCEncrypt),
                                                   CCAlgorithm(kCCAlgorithmAES128),
                                                   CCOptions(kCCOptionPKCS7Padding),
                                                   key.bytes,
                                                   key.count,
                                                   iv.bytes,
                                                   self.bytes,
                                                   self.count,
                                                   buffer,
                                                   bufferSize,
                                                   &encryptedSize)
        if (cryptStatus == kCCSuccess) {
            let result = Data(bytes: buffer!, count: encryptedSize)
            free(buffer)
            return result
        }
        else {
            free(buffer)
            return nil
        }
    }
    
    func aes256Decrypt(key: Data, iv: Data) -> Data? {
        guard key.count == 16 || key.count == 24 || key.count == 32 else { return nil }
        guard iv.count == 16 || iv.count == 0 else { return nil }
        let bufferSize = self.count + kCCBlockSizeAES128
        let buffer = malloc(bufferSize)
        guard buffer != nil else { return nil }
        var decryptedSize: size_t = 0
        let cryptStatus: CCCryptorStatus = CCCrypt(CCOperation(kCCDecrypt),
                                                   CCAlgorithm(kCCAlgorithmAES128),
                                                   CCOptions(kCCOptionPKCS7Padding),
                                                   key.bytes,
                                                   key.count,
                                                   iv.bytes,
                                                   self.bytes,
                                                   self.count,
                                                   buffer,
                                                   bufferSize,
                                                   &decryptedSize)
        if (cryptStatus == kCCSuccess) {
            let result = Data(bytes: buffer!, count: decryptedSize)
            free(buffer)
            return result
        }
        else {
            free(buffer)
            return nil
        }
    }
    
    // MARK: - Utility
    
    func utf8String() -> String {
        return String(data: self, encoding: .utf8) ?? ""
    }
    
    func hexString() -> String {
        var result = String()
        for byte in self.bytes {
            result = result.appendingFormat("%02X", byte)
        }
        return result
    }
    
    static func dataWithHexString(hex: String) -> String? {
        let length = hex.count/2
        guard length > 0 else { return nil }
        var bytes = [UInt8]()
        bytes.reserveCapacity(length/2)
        var index = hex.startIndex
        for _ in 0..<length {
            let nextIndex = hex.index(index, offsetBy: 2)
            if let b = UInt8(hex[index..<nextIndex], radix: 16) {
                bytes.append(b)
            } else {
                return nil
            }
            index = nextIndex
        }
        return String(bytes: bytes, encoding: .utf8)
    }
        
    func jsonValueDecoded() -> Any? {
        return try? JSONSerialization.jsonObject(with: self)
    }
    
    func dataNamed(_ name: String, ext: String?) -> Data? {
        let url = Bundle.main.url(forResource: name, withExtension: ext)
        if let fileUrl = url {
            return try? Data(contentsOf: fileUrl)
        }
        else {
            return nil
        }
    }
}
