import winery.model;
import ballerina/log;
import winery.googleapis.sheets;
import ballerina/io;

model:Student student1 = {
    name: "Jon",
    age: 16,
    city: "London"
};

model:Student student2 = {
    name: "Doe",
    age: 15,
    city: "Brussels"
};

// object array need to write to the spreadsheet
model:Student[] students = [student1, student2];

public function main() returns error? {
    (string|error)? spreadsheetId = sheets:createSpreadsheetAndWriteContent("Students", students);
    if (spreadsheetId is string) {
        (string|int|float)[][]|error? content = check sheets:readContent(spreadsheetId);
        if (content is (string|int|float)[][]) {
            foreach var column in content {
                foreach var cell in column {
                    io:print(cell);
                    io:print("\t");
                }
                io:print("\n");
            }
        } else {
            log:printError("reading content failed");
        }
    } else {
        log:printError("creating spreadsheet failed");
    }
}
