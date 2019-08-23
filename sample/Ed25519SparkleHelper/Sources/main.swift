//
//  main.swift
//  dsdsd
//
//  Created by Hung Truong on 5/9/19.
//  Copyright © 2019 Hung Truong. All rights reserved.
//

import Foundation

// parse command line arguments

/*
 Format: ./ed25519_sign -F filepath=@""
 */

let argCount = CommandLine.argc
let appPathArg = CommandLine.arguments[2] as String

let components: Array = appPathArg.components(separatedBy: "=@")
let appPath = components[1]
assert(appPath.count != 0)

let public_key: [UInt8] = [121, 17, 79, 45, 155, 141, 51, 169, 188, 110, 91, 102, 182, 147, 215, 225, 252, 202, 110, 231, 200, 215, 62, 171, 40, 145, 237, 128, 130, 44, 150, 89]

let self_sign_demo_only_insecure_hack: [UInt8] = [200, 238, 135, 84, 10, 189, 3, 193, 61, 208, 203, 30, 133, 47, 12, 22, 19, 52, 252, 99, 110, 205, 209, 94, 215, 144, 201, 70, 27, 162, 163, 108, 0, 164, 68, 184, 226, 93, 121, 199, 172, 17, 26, 64, 89, 68, 232, 41, 2, 26, 245, 175, 158, 165, 42, 55, 5, 97, 8, 243, 251, 164, 93, 9]

var generator: Utils = Utils(public_key, self_sign_demo_only_insecure_hack)


_ = generator.ed25519AppSign(appPath)

let publicKey = generator.getPublicKey()
let privateKey = generator.getPrivateKey()
let signature = generator.getSignature()

print("Signature: \(signature)")
print("Public Key: \(publicKey)")


