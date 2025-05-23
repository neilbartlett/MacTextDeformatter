import AppKit

enum JSONToTSVConverter {
    static func convertClipboard(transpose: Bool) {
        guard let jsonText = NSPasteboard.general.string(forType: .string) else {
            NSSound.beep()
            return
        }

        do {
            let parsed = try JSON.parse(string: jsonText)

            let tsv: String
            if let dict = parsed as? [JSON.ObjectElement] {
                tsv = transpose ? convertObjectTransposed(dict) : convertObject(dict)
            } else if let array = parsed as? [JSON.ArrayElement],
                      let allDicts = array.compactMap({ $0.value as? [JSON.ObjectElement] }) as? [[JSON.ObjectElement]] {
                tsv = transpose ? convertArrayTransposed(allDicts) : convertArray(allDicts)
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

    private static func convertObject(_ dict: [JSON.ObjectElement]) -> String {
        let keys = dict.map { $0.key }
        let values = dict.map { stringify($0.value) }

        return keys.joined(separator: "\t") + "\n" + values.joined(separator: "\t")
    }

    private static func convertObjectTransposed(_ dict: [JSON.ObjectElement]) -> String {
        return dict.map { "\($0.key)\t\(stringify($0.value))" }.joined(separator: "\n")
    }

    private static func convertArray(_ rows: [[JSON.ObjectElement]]) -> String {
        guard let firstRow = rows.first else { return "" }
        let keys = firstRow.map { $0.key }

        let lines = [keys.joined(separator: "\t")] + rows.map { row in
            keys.map { key in
                row.first(where: { $0.key == key }).map { stringify($0.value) } ?? ""
            }.joined(separator: "\t")
        }

        return lines.joined(separator: "\n")
    }

    private static func convertArrayTransposed(_ rows: [[JSON.ObjectElement]]) -> String {
        guard let firstRow = rows.first else { return "" }
        let keys = firstRow.map { $0.key }

        var result = ["Key" + (0..<rows.count).map { "\tRow\($0 + 1)" }.joined()]
        for key in keys {
            let row = [key] + rows.map { row in
                row.first(where: { $0.key == key }).map { stringify($0.value) } ?? ""
            }
            result.append(row.joined(separator: "\t"))
        }

        return result.joined(separator: "\n")
    }

    private static func stringify(_ value: Value) -> String {
        if let s = value as? String {
            return s.replacingOccurrences(of: "\t", with: " ")
                    .replacingOccurrences(of: "\n", with: " ")
        }
        return (value as? JSONStringRepresentable)?.stringRepresentation()
                .replacingOccurrences(of: "\"", with: "")
                .replacingOccurrences(of: "\t", with: " ")
                .replacingOccurrences(of: "\n", with: " ")
                ?? ""
    }
}
