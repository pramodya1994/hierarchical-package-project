import ballerina/test;
import winery.googleapis.sheets;

string sId = "";

@test:Config {}
function testCreateSpreadsheetAndWriteContent() {
    (string|error)? spreadsheetId = sheets:createSpreadsheetAndWriteContent("Students", students);
    if (spreadsheetId is string) {
        test:assertTrue(spreadsheetId.length() > 0);
        sId = spreadsheetId;
    } else {
        test:assertFail("create spreadsheet and write content failed");
    }
}

@test:Config {dependsOn: [testCreateSpreadsheetAndWriteContent]}
function testReadContent() {
    (string|int|float)[][]|error? content = sheets:readContent(sId);
    if (content is (string|int|float)[][]) {
        test:assertEquals(content.length(), 3);
    } else {
        test:assertFail("read content failed");
    }
}
