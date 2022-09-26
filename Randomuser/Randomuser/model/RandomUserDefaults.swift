//
//  RandomUserDefaults.swift
//  Randomuser
//
//  Created by David Lopez on 26/9/22.
//

import Foundation

final class RandomUserDefaults {
    static let seedKey: String = "responseSeed"
    
    class func saveSeed(seed: String) {
        UserDefaults.standard.set(seed, forKey: RandomUserDefaults.seedKey)
    }
    
    class func isSeedSaved() -> Bool {
        UserDefaults.standard.string(forKey: RandomUserDefaults.seedKey) != nil
    }
    
    class func retrieveSeed() -> String? {
        UserDefaults.standard.string(forKey: RandomUserDefaults.seedKey)
    }
    
    class func clearSeed() {
        UserDefaults.standard.removeObject(forKey: RandomUserDefaults.seedKey)
    }
}
