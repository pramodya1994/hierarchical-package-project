import winery.model;
import ballerinax/googleapis.sheets;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

sheets:SpreadsheetConfiguration config = {oauth2Config: {
        clientId: clientId,
        clientSecret: clientSecret,
        refreshUrl: sheets:REFRESH_URL,
        refreshToken: refreshToken
    }};

sheets:Client gsheetsClient = checkpanic new (config);
  
public function createSpreadsheetAndWriteContent(string spreadsheetName, model:Student[] students) 
returns string|error? {
    sheets:Spreadsheet spreadsheet = check gsheetsClient->createSpreadsheet(spreadsheetName);
    string spreadsheetId = spreadsheet.spreadsheetId;

    // get sheet
    sheets:Sheet[] sheets = check spreadsheet.getSheets();
    sheets:Sheet sheet = sheets[0];

    // write headings
    _ = check sheet->setCell("A1", "Name");
    _ = check sheet->setCell("B1", "Age");
    _ = check sheet->setCell("C1", "City");

    // write to sheet
    int cellIdx = 2;
    foreach model:Student student in students {
        _ = check sheet->setCell("A" + cellIdx.toString(), student.name);
        _ = check sheet->setCell("B" + cellIdx.toString(), student.age);
        _ = check sheet->setCell("C" + cellIdx.toString(), student.city);
        cellIdx = cellIdx + 1;
    }

    return spreadsheetId;
}

public function readContent(string spreadsheetId) returns (string|int|float)[][]|error? {
    sheets:Spreadsheet spreadsheet = check gsheetsClient->openSpreadsheetById(spreadsheetId);

    sheets:Sheet[] sheets = check spreadsheet.getSheets();
    sheets:Sheet sheet = sheets[0];

    (string|int|float)[] columnA = check sheet->getColumn("A");
    (string|int|float)[] columnB = check sheet->getColumn("B");
    (string|int|float)[] columnC = check sheet->getColumn("C");

    (string|int|float)[][] columns = [columnA, columnB, columnC];
    return columns;
}
