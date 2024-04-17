//
//  JSONUtil.swift
//  NC1
//
//  Created by Seol WooHyeok on 4/17/24.
//

import Foundation

struct JSONUtil {
    // Read data from JSON
    static func read<T: Codable>(filename: String) -> T? {
        var data: Data?
        var file: URL
        
        //get file directory
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
        
        //get data
        do {
            data = try Data(contentsOf: file)
        } catch {
            print("Couldn't load \(filename) from main bundle or document directory :\n\(error)")
        }

        guard data != nil else { return nil }
        
        //decode data (convert data to model)
        do {
            let decoder = JSONDecoder()
            print("Reading...  📖: \(file.description)")
            return try decoder.decode(T.self, from: data!)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

    // Write data to JSON
    func write<T: Codable>(array: [T], filename: String) {
//        var array1 = array
//        array1 = []
        // get file URL
        var file: URL
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
        
        // encode the array with new entry and write to JSON file
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            print("Writing...  📖: \(file.description)")
            try encoder.encode(array).write(to: file)
        } catch {
            print("Couldn’t save new entry to \(filename), \(error.localizedDescription)")
        }
    }
}
