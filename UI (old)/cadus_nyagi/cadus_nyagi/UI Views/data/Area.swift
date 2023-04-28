//
//  areas.swift
//  cadus_nyagi
//
//  Created by Anna Easter on 2/24/23.
//

import Foundation
import SwiftUI
import RealmSwift

class Area: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var image = ""
    @Persisted private var imageName: String

}


