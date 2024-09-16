# Swift Geometer

Geometry and maths helpers for literate code.

*Literate*: pleasant to write and easy to understand code that signals intentions
well. Optimisation (of speed) is not the intent.

# Vec2

One of the lighter-touch features is a `typealias`:

```swift
typealias Vec2 = CGPoint
```

There's already a `CGVector` provided in Swift, but that's for Double not CGFloat, so it's not conveniently interchangable.

So if you're dealing with `CGPoint` but the semantics are that of a vector, you can use `Vec2` to signal that:

```
let a = CGPoint(x: 2, y: 3)
let b = CGPoint(x: 10, y: 12)

// the result `atoB` here is technically a vector, not a point:
let aToB = b - a

// so this would be more illustrative
let aToB: Vec2 = b - a
```

WIP Sept 2024.

