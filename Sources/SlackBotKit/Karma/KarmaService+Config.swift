
extension KarmaService {
    public typealias CommentsFormatter = (String, Int) -> String

    public struct Config {
        let topUserLimit: Int
        let positiveComments: [CommentsFormatter]
        let negativeComments: [CommentsFormatter]

        public init(topUserLimit: Int, positiveComments: [CommentsFormatter], negativeComments: [CommentsFormatter]) {
            self.topUserLimit = topUserLimit
            self.positiveComments = positiveComments
            self.negativeComments = negativeComments
        }

        public static func `default`() -> Config {
            return Config(
                topUserLimit: 10,
                positiveComments: [
                    { "You rock \($0)! Now at \($1)." },
                    { "Nice job, \($0)! Your karma just bumped to \($1)." },
                    { "Awesome \($0)! You’re now at \($1) \(pluralizedScoreString(from: $1))." }
                ],
                negativeComments: [
                    { "booooo \($0)! Now at \($1)." },
                    { "Tssss \($0). Dropped your karma to \($1)." },
                    { "Sorry, but I have to drop \($0)’s karma down to \($1) \(pluralizedScoreString(from: $1))." },
                ]
            )
        }
    }
}

private extension KarmaService.Config {
    /// Non-localized pluralization.
    ///
    /// - Parameter score: a point score.
    /// - Returns: `"point"` if score is 1; otherwise, `"points"`.
    /// - Note: Should be replaced by proper localized pluralization
    static func pluralizedScoreString(from score: Int) -> String {
        return score == 1 ? "point" : "points"
    }
}
