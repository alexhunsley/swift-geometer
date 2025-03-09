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

    @Test("bool negation operator (fixed with wrapper)", arguments: [
        Pair(true, true),     // control case (no negation used)
        Pair(!true, false),   // negate once
        Pair(!(!true), true), // negate twice
    ])
    func testBoolNegation(boolPair: Pair<Bool, Bool>) {
        #expect(boolPair.a == boolPair.b)
    }

    // this works
    @Test("test addition (works)", arguments: [
        (1, 1, 2),
        (0, 2, 2)
    ])
    func testAddition(value1: Int, value2: Int, value3: Int) {
        #expect(value1 + value2 == value3)
    }
}
