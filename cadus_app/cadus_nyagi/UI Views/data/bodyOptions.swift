//
//  bodyOptions.swift
//  cadus_nyagi
//
//  Created by Emmett Easter on 2/24/23.
//

import Foundation

import Combine


final class bodyOptions: ObservableObject {
    
//    let newWord = Area(value: ["name": "wordName"])

    @Published var areas:[Area] = load(["shoulder", "hand", "knee", "neck"])
    
    var subSectionsDict = ["shoulder": ["Biceps", "Infraspinatus", "Subscapularis", "Supraspinatus", "Teres Minor"]]

//    var categories: [String: [Area]] {
//
//        Dictionary(
//
//            grouping: areas,
//
//            by: { $0.name }
//
//        )
//
//    }

}


func load(_ filename: [String]) -> [Area]{
    
    //    let data: Data
    //
    var arrayToReturn:[Area] = []
    //
    //    filename.forEach{areas in
    //        _ = area(from: areas as! Decoder)
    //        arrayToReturn.append()
    //    }
    
    filename.forEach{part in
        
        let newWord = Area(value: ["name": part])
        arrayToReturn.append(newWord)
        
    }
    
    return arrayToReturn
    
}

//    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//
//    else {
//
//        fatalError("Couldn't find \(filename) in main bundle.")
//
//    }

//
//    do {
//
//        data = try Data(contentsOf: filename)
//
//    } catch {
//
//        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//
//    }


//    do {
//
//        let decoder = JSONDecoder()
//
//        return try decoder.decode(T.self, from: filename)
//
//    } catch {
//
//        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//
//    }

// }


