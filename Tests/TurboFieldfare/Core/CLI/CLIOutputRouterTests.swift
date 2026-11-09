import Testing
import TurboFieldfare
@testable import TurboFieldfareCLICore

@Suite struct CLIOutputRouterTests {
    @Test func offModeEmitsOnlyAnswerContent() {
        var router = CLIOutputRouter(thinkingMode: .off)
        #expect(router.output(for: .reasoning("hidden")) == "")
        #expect(router.output(for: .content("answer")) == "answer")
    }

    @Test func onModeLabelsReasoningAndAnswerSeparately() {
        var router = CLIOutputRouter(thinkingMode: .on)
        #expect(router.output(for: .reasoning("work")) == "\n[Reasoning]\nwork")
        #expect(router.output(for: .content("answer")) == "\n\n[Answer]\nanswer")
        #expect(router.output(for: .content(" continued")) == " continued")
    }

    @Test func onModeWithoutReasoningKeepsPlainAnswer() {
        var router = CLIOutputRouter(thinkingMode: .on)
        #expect(router.output(for: .content("answer")) == "answer")
    }

    @Test func truncatedReasoningDoesNotInventAnAnswerSection() {
        var router = CLIOutputRouter(thinkingMode: .on)
        let partial = router.output(for: .reasoning("unfinished"))
        #expect(partial == "\n[Reasoning]\nunfinished")
        #expect(!partial.contains("[Answer]"))
    }
}
