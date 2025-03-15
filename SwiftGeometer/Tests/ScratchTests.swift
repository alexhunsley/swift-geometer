import Testing

struct ScratchTests {

//    // this falls over.
//    // "Thread 2: Fatal error: Internal inconsistency: No test reporter for test case argumentIDs: Optional([..."
//    @Test("test addition (broken!)", arguments: [
//        (1 + 1, 2),
//        (0 + 2, 2)
//    ])
//    func testAddition(value1: Int, value2: Int) {
//        #expect(value1 == value2)
//    }
//
//    //libswiftCore.dylib`_swift_runtime_on_report:
//    // Thread 5: Fatal error: Internal inconsistency: No test reporter for test case argumentiDs:
//    // Optional ([Testing.Test.Case.Argument.ID(bytes: [102, 97, 108, 115, 101]),
//    //   Testing.Test.Case.Argument.ID(bytes: [102, 97, 108, 115, 101])])
//    //   in test SwiftGeometerTests.ScratchTests/testBoolNegation(Ihs:rhs:)/ScratchTests.swift:15:6

//    @Test("bool negation operator (falls over)", arguments: [
//        (true, true),     // control case (no negation used)
//        (!true, false),   // negate once
//        (!(!true), true), // negate twice
//    ])
//    func testBoolNegation(lhs: Bool, rhs: Bool) {
//        #expect(lhs == rhs)
//    }

//    // pretty horrible hack (crashes currently)
//    static func prepArgs<T>(_ arg: [T]) -> [(T, Void)] {
//        arg.map { ($0, ()) }
//    }
//
//    // pretty horrible
//    @Test("bool negation operator (nasty hack)", arguments: prepArgs([
//        (true, true),
//        (!true, false),
//        (!(!true), true)
//    ]))
//    func testBoolNegationFixedWithHack(_ pair:((Bool, Bool), _: Void)) {
//        let values = pair.0
//        print("vals: \(values)")
//        #expect(values.0 == values.1)
//    }

    // zip! it's only one item in the array cos of zip!
//    @Test("test addition (works)", arguments: zip([
//        (1, 1, 2),
//        (1, 1, 2),
//        (0, 2, 2)
//    ], [()]))
////    func testAddition(tuple: (Int, Int, Int), shim: [()]) {
////    func testAddition(tuple: (Int, Int, Int), _: Void) {
//    func testAddition(values: (Int, Int, Int), _: Void) {
//        #expect(values.0 + values.1 == values.2)
//    }
}
