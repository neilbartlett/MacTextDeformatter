//
//  JSONToTSVConverter.swift
//  MacTextDeformatter
//
//  Created by Neil Bartlett on 2025-05-04.
//  Copyright © 2025 Neil Bartlett. All rights reserved.
//


import AppKit

enum JSONToTSVConverter {
    static func convertClipboard(transpose: Bool) {
        guard let jsonText = NSPasteboard.general.string(forType: .string),
              let data = jsonText.data(using: .utf8) else {
            NSSound.beep()
            return
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])

            let tsv: String
            if let array = json as? [[String: Any]] {
                tsv = transpose ? convertArrayTransposed(array) : convertArray(array)
            } else if let dict = json as? [String: Any] {
                tsv = transpose ? convertObjectTransposed(dict) : convertObject(dict)
            } else {
                NSPasteboard.general.setString("Unsupported JSON structure", forType: .string)
                return
            }

            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(tsv, forType: .string)

        } catch {
            NSPasteboard.general.setString("JSON parse error: \(error)", forType: .string)
        }
    }

    private static func convertArray(_ array: [[String: Any]]) -> String {
        let allKeys = Set(array.flatMap { $0.keys })
        let header = Array(allKeys)
        let rows = array.map { obj in
            header.map { key in stringify(obj[key]) }
        }

        var result = [header.joined(separator: "\t")]
        result.append(contentsOf: rows.map { $0.joined(separator: "\t") })
        return result.joined(separator: "\n")
    }

    private static func convertArrayTransposed(_ array: [[String: Any]]) -> String {
        let allKeys = Set(array.flatMap { $0.keys })
        let header = ["Key"] + (0..<array.count).map { "Row\($0 + 1)" }

        var result: [String] = [header.joined(separator: "\t")]
        for key in allKeys.sorted() {
            var row = [key]
            for obj in array {
                row.append(stringify(obj[key]))
            }
            result.append(row.joined(separator: "\t"))
        }
        return result.joined(separator: "\n")
    }

    private static func convertObject(_ dict: [String: Any]) -> String {
        let keys = dict.keys.sorted()
        let header = keys.joined(separator: "\t")
        let row = keys.map { key in stringify(dict[key]) }.joined(separator: "\t")
        return "\(header)\n\(row)"
    }

    private static func convertObjectTransposed(_ dict: [String: Any]) -> String {
        let rows = dict.keys.sorted().map { key -> String in
            "\(key)\t\(stringify(dict[key]))"
        }
        return rows.joined(separator: "\n")
    }

    private static func stringify(_ value: Any?) -> String {
        if let value = value {
            if let str = value as? String {
                return str.replacingOccurrences(of: "\t", with: " ").replacingOccurrences(of: "\n", with: " ")
            } else {
                return String(describing: value)
            }
        } else {
            return ""
        }
    }
}