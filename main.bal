import ballerina/io;
import winery.googleapis.docs;
import winery.googleapis.sheets;

public function main() {
    io:println("Hello World!");

    docs:addDoc("my doc");
    io:println(docs:getDoc(1));

    sheets:addSheet("my sheet");
    io:println(sheets:getSheet(1));
    sheets:addDoctoSheets(1);
    io:println(sheets:getSheet(2));
}
