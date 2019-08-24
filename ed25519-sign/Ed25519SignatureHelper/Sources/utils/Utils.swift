//
//  Utils.swift
//  Ed25519SparkleHelper
//
//  Created by Hung Truong on 5/14/19.
//

import Foundation

class Utils {
    
    private var publicKey: String
    private var privateKey: String
    private var signature: String
    
    private var keyPair: SwiftEd25519KeyPair
    
//    init() {
//
//        let seed = try! SwiftEd25519Seed()
//        self.keyPair = SwiftEd25519KeyPair(seed: seed)
//
//        let publicKeyBytes = keyPair.publicKey.bytes
//        let publicKeyData = Data(_: publicKeyBytes)
//        publicKey = publicKeyData.base64EncodedString(options: [])
//
//        let privateKeyBytes = keyPair.privateKey.bytes
//        let privateKeyData = Data(_: privateKeyBytes)
//        privateKey = privateKeyData.base64EncodedString(options: [])
//
//        self.signature = ""
//        print("Utils: __Init")
//    }
//
    init(_ publicBytes: [UInt8], _ privateBytes: [UInt8]) {
        keyPair = try! SwiftEd25519KeyPair(publicKey: publicBytes, privateKey: privateBytes)
        let publicKeyBytes = keyPair.publicKey.bytes
        let privateKeyBytes = keyPair.privateKey.bytes
        
        let privateKeyData = Data(_: privateKeyBytes)
        privateKey = privateKeyData.base64EncodedString(options: [])
        
        let publicKeyData = Data(_: publicKeyBytes)
        publicKey = publicKeyData.base64EncodedString(options: [])
        
        self.signature = ""
    }
    
    func ed25519AppSign(_ filename: String) -> Void {
        let fileURL: URL = URL(fileURLWithPath: filename)
        let fileData: Data = try! Data(contentsOf: fileURL)
        var bytes = [UInt8](repeating: 0, count: fileData.count)
        fileData.copyBytes(to: &bytes, count: fileData.count)
        
        let signature = keyPair.sign(bytes)
        
        let signatureData = Data(_: signature)
        self.signature = signatureData.base64EncodedString(options: [])
    }
    
    func getPublicKey() -> String {
        return publicKey
    }
    
    func getPrivateKey() -> String {
        return privateKey
    }
    
    func getSignature() -> String {
        return signature
    }
}
