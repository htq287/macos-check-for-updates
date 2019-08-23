//
//  SwiftEd25519PublicKey.swift
//  Ed25519SparkleHelper
//
//  Created by Hung Truong on 5/16/19.
//

import Foundation

public final class SwiftEd25519PublicKey {
    private let buffer: [UInt8]
    
    public convenience init(_ bytes: [UInt8]) throws {
        guard bytes.count == 32 else {
            throw SwiftEd25519Error.invalidPublicKeyLength
        }
        
        self.init(unchecked: bytes)
    }
    
    init(unchecked buffer: [UInt8]) {
        self.buffer = buffer
    }
    
    public var bytes: [UInt8] {
        return buffer
    }
    
    public func verify(signature: [UInt8], message: [UInt8]) throws -> Bool {
        guard signature.count == 64 else {
            throw SwiftEd25519Error.invalidSignatureLength
        }
        
        return signature.withUnsafeBufferPointer { signature in
            message.withUnsafeBufferPointer { msg in
                buffer.withUnsafeBufferPointer { pub in
                    ed25519_verify(signature.baseAddress,
                                   msg.baseAddress,
                                   message.count,
                                   pub.baseAddress) == 1
                }
            }
        }
    }
    
    public func add(scalar: [UInt8]) throws -> SwiftEd25519PublicKey {
        guard scalar.count == 32 else {
            throw SwiftEd25519Error.invalidScalarLength
        }
        
        var pub = buffer
        
        pub.withUnsafeMutableBufferPointer { pub in
            scalar.withUnsafeBufferPointer { scalar in
                ed25519_add_scalar(pub.baseAddress,
                                   nil,
                                   scalar.baseAddress)
            }
        }
        
        return SwiftEd25519PublicKey(unchecked: pub)
    }
}
