//
//  ClipboardTransformer.swift
//  MacTextDeformatter
//
//  Created by Neil Bartlett on 2025-05-04.
//  Copyright © 2025 Neil Bartlett. All rights reserved.
//


import AppKit

enum ClipboardTransformer {
    static func convertCSVToTSV() {
        guard let csv = NSPasteboard.general.string(forType: .string) else {
            NSSound.beep()
            return
        }

        let lines = csv.components(separatedBy: .newlines)
        var tsvLines: [String] = []

        for line in lines where !line.trimmingCharacters(in: .whitespaces).isEmpty {
            let fields = parseCSVLine(line)
            tsvLines.append(fields.joined(separator: "\t"))
        }

        let tsv = tsvLines.joined(separator: "\n")
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(tsv, forType: .string)
    }

    private static func parseCSVLine(_ line: String) -> [String] {
        var fields: [String] = []
        var field = ""
        var insideQuotes = false
        let chars = Array(line)
        var i = 0

        while i < chars.count {
            let char = chars[i]

            if char == "\"" {
                if insideQuotes {
                    // Peek ahead for escaped quote
                    if i + 1 < chars.count, chars[i + 1] == "\"" {
                        field.append("\"")
                        i += 1
                    } else {
                        insideQuotes = false
                    }
                } else {
                    insideQuotes = true
                }
            } else if char == "," && !insideQuotes {
                fields.append(field)
                field = ""
            } else {
                field.append(char)
            }

            i += 1
        }

        fields.append(field)
        return fields
    }
}
