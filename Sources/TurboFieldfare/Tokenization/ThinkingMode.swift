/// Whether Gemma 4 should generate a thought channel before its final answer.
public enum ThinkingMode: String, Codable, Equatable, Sendable {
    case off
    case on
}
