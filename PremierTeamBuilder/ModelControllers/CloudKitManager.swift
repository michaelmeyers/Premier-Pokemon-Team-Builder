//
//  CloudKitManager.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager{
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    func fetchCKRecord(withType type: String) -> [CKRecord] {
        let records: [CKRecord] = []

        return records
    }
    
    func saveCKRecord() {
        
    }
}
