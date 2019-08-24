//
//  SwiftEd25519Error.swift
//  Ed25519SparkleHelper
//
//  Created by Hung Truong on 5/16/19.
//

public enum SwiftEd25519Error: Error {
    case seedGenerationFailed
    case invalidSeedLength
    case invalidScalarLength
    case invalidPublicKeyLength
    case invalidPrivateKeyLength
    case invalidSignatureLength
}
