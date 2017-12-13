//
//  CloudKitSyncable.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 12/11/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit

protocol CloudKitSyncable {
    
    var recordID: CKRecordID? { get }
    var recordType: String { get }
}

extension CloudKitSyncable {
    var isSynced: Bool {
        return recordID != nil
    }
    
    var cloudKitReference: CKReference? {
        
        guard let recordID = recordID else { return nil }
        
        return CKReference(recordID: recordID, action: .none)
    }
}
