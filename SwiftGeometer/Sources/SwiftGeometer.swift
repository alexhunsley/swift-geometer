import SwiftUI

public struct SwiftGeometer {
    public static func hello() -> String {
        "Hello from SwiftGeometer"
    }
}


// TODO
// [ ] put the test harness app into a project inside this project

// will trigger swift 6 concurrency warning if strict is enabled
//class DataManager {
//    var data: [String] = []
//
//    // Non-isolated function that accesses shared mutable state
//    func addData(_ value: String) {
//        data.append(value)  // This will trigger a warning under strict concurrency
//    }
//
//    // "Instance method of non-Sendable type 'DataManager' cannot be marked as '@Sendable'; this is an error in the Swift 6 language mode"
//    @Sendable
//    func processDataConcurrently() {
//        addData("Test")  // This will trigger a warning due to concurrency violation
//    }
//}
