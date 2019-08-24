//
//  SwiftEd25519KeyPair.swift
//  Ed25519SparkleHelper
//
//  Created by Hung Truong on 5/16/19.
//

import Foundation

public final class SwiftEd25519KeyPair {
    public let publicKey: SwiftEd25519PublicKey
    public let privateKey: SwiftEd25519PrivateKey
    
    public init(publicKey: SwiftEd25519PublicKey, privateKey: SwiftEd25519PrivateKey) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
    public convenience init(seed: SwiftEd25519Seed) {
        var pubBuffer = [UInt8](repeating: 0, count: 32)
        var privBuffer = [UInt8](repeating: 0, count: 64)
        
        privBuffer.withUnsafeMutableBufferPointer { priv in
            pubBuffer.withUnsafeMutableBufferPointer { pub in
                seed.bytes.withUnsafeBufferPointer { seed in
                    ed25519_create_keypair(pub.baseAddress,
                                           priv.baseAddress,
                                           seed.baseAddress)
                }
            }
        }
        
        self.init(publicKey: SwiftEd25519PublicKey(unchecked: pubBuffer),
                  privateKey: SwiftEd25519PrivateKey(unchecked: privBuffer))
    }
    
    public convenience init(publicKey: [UInt8], privateKey: [UInt8]) throws {
        let pub = try SwiftEd25519PublicKey(publicKey)
        let priv = try SwiftEd25519PrivateKey(privateKey)
        self.init(publicKey: pub, privateKey: priv)
    }
    
    public func sign(_ message: [UInt8]) -> [UInt8] {
        var signature = [UInt8](repeating: 0, count: 64)
        
        signature.withUnsafeMutableBufferPointer { signature in
            privateKey.bytes.withUnsafeBufferPointer { priv in
                publicKey.bytes.withUnsafeBufferPointer { pub in
                    message.withUnsafeBufferPointer { msg in
                        ed25519_sign(signature.baseAddress,
                                     msg.baseAddress,
                                     message.count,
                                     pub.baseAddress,
                                     priv.baseAddress)
                    }
                }
            }
        }
        
        return signature
    }
    
    public func verify(signature: [UInt8], message: [UInt8]) throws -> Bool {
        return try publicKey.verify(signature: signature, message: message)
    }
    
    public func keyExchange() -> [UInt8] {
        var secret = [UInt8](repeating: 0, count: 32)
        
        publicKey.bytes.withUnsafeBufferPointer { pub in
            privateKey.bytes.withUnsafeBufferPointer { priv in
                secret.withUnsafeMutableBufferPointer { sec in
                    ed25519_key_exchange(sec.baseAddress,
                                         pub.baseAddress,
                                         priv.baseAddress)
                }
            }
        }
        
        return secret
    }
    
    public static func keyExchange(publicKey: SwiftEd25519PublicKey, privateKey: SwiftEd25519PrivateKey) -> [UInt8] {
        let keyPair = SwiftEd25519KeyPair(publicKey: publicKey, privateKey: privateKey)
        return keyPair.keyExchange()
    }
    
    public static func keyExchange(publicKey: [UInt8], privateKey: [UInt8]) throws -> [UInt8] {
        let keyPair = try SwiftEd25519KeyPair(publicKey: publicKey, privateKey: privateKey)
        return keyPair.keyExchange()
    }
    
    public func add(scalar: [UInt8]) throws -> SwiftEd25519KeyPair {
        guard scalar.count == 32 else {
            throw SwiftEd25519Error.invalidScalarLength
        }
        
        var pub = publicKey.bytes
        var priv = privateKey.bytes
        
        pub.withUnsafeMutableBufferPointer { pub in
            priv.withUnsafeMutableBufferPointer { priv in
                scalar.withUnsafeBufferPointer { scalar in
                    ed25519_add_scalar(pub.baseAddress,
                                       priv.baseAddress,
                                       scalar.baseAddress)
                }
            }
        }
        
        return SwiftEd25519KeyPair(publicKey: SwiftEd25519PublicKey(unchecked: pub),
                       privateKey: SwiftEd25519PrivateKey(unchecked: priv))
    }
}
