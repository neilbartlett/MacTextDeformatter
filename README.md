# MacTextDeformatter

This is a simple macOS toolbar application to perform various clipboard transformations. Note the clipboard is altered by these transformations.

The currently supported transformations are
- Remove any rich-text formatting from the text in the clipboard. Note this can often be performed simply using the standard macOS Shift+Cmd+V, but the key sequence is not always reliable.
- CSV to TSV. This converts CSV data (which does not paste nicely into cells in Excel or Google Sheets) into TSV which pastes with each field getting a new cell.
- JSON to TSV. This converts the JSON key-value dictionary to a TSV that can be directly pasted into Excel or Google Sheets. The keys of the JSON are placed in columns and the values in the row below. 
- JSON to TSV transposed. This is the same as JSON to TSV except that the keys are placed in rows and the values in the next column.

## License

This project is licensed under the MIT License.
