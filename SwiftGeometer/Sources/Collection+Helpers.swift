import Foundation

extension Collection {
    public func mapPairs<T>(wrap: Bool = false, _ transform: (Element, Element) -> T) -> [T] {
        guard count > 1 else { return [] }
        var result: [T] = []
        var index = startIndex

        while true {
            let nextIndex = self.index(after: index)
            if nextIndex == endIndex {
                if wrap {
                    result.append(transform(self[index], self[startIndex]))
                }
                break
            }

            result.append(transform(self[index], self[nextIndex]))
            index = nextIndex
        }
        return result
    }
}
