//
//  PokemonTeam+CloudKit.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/24/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit

extension PokemonTeam {
    
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[Keys.ckPokemonTeamNameKey] as? String else {return nil}
        self.init(name: name)
        self.recordID = ckRecord.recordID
    }
    
    var ckRecord: CKRecord? {
        let recordID = self.recordID ?? CKRecordID(recordName: UUID().uuidString)
        let teamRecord = CKRecord(recordType: Keys.ckTeamRecordType, recordID: recordID)
        teamRecord[Keys.ckPokemonTeamNameKey] = name as CKRecordValue
        return teamRecord
    }
}
