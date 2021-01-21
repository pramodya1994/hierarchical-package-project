import ballerina/io;

string[] docs = ["first doc"];

public function hello() {
    io:println("Hello World!");
}

public function addDoc(string name) {
    docs[docs.length()] = name;
}

public function getDoc(int idx) returns string {
    return docs[idx];
}
