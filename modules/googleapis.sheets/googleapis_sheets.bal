import ballerina/io;
import winery.googleapis.docs;

string[] sheets = ["first sheet"];

public function hello() {
    io:println("Hello World!");
}

public function addSheet(string name) {
    sheets[sheets.length()] = name;
}

public function getSheet(int idx) returns string {
    return sheets[idx];
}

public function addDoctoSheets(int idx) {
    string doc = docs:getDoc(idx);
    addSheet(doc);
}