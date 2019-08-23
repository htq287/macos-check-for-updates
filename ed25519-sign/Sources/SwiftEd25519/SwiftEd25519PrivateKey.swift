//
//  SwiftEd25519PrivateKey.swift
//  Ed25519SparkleHelper
//
//  Created by Hung Truong on 5/16/19.
//

import Foundation

public final class SwiftEd25519PrivateKey {
    private let buffer: [UInt8]
    
    public init(_ bytes: [UInt8]) throws {
        guard bytes.count == 64 else {
            throw SwiftEd25519Error.invalidPrivateKeyLength
        }
        
        self.buffer = bytes
    }
    
    init(unchecked buffer: [UInt8]) {
        self.buffer = buffer
    }
    
    public var bytes: [UInt8] {
        return buffer
    }
    
    public func add(scalar: [UInt8]) throws -> SwiftEd25519PrivateKey {
        guard scalar.count == 32 else {
            throw SwiftEd25519Error.invalidScalarLength
        }
        
        var priv = buffer
        
        priv.withUnsafeMutableBufferPointer { priv in
            scalar.withUnsafeBufferPointer { scalar in
                ed25519_add_scalar(nil,
                                   priv.baseAddress,
                                   scalar.baseAddress)
            }
        }
        
        return SwiftEd25519PrivateKey(unchecked: priv)
    }
}
