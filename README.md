# Swift Geometer

Geometry and maths helpers for literate code.

*Literate*: pleasant to write and easy to understand code that signals intentions
well. Optimisation (of speed) is not the intent here.

# Vec2

One of the lighter-touch features is a `typealias`:

```swift
typealias Vec2 = CGPoint
```

So if you're dealing with `CGPoint` but the semantics are that of a vector, you're encouraged to use `Vec2` to signal that.

(example: a - b, assign to a vec2, not a point)

(add Angle(betweenVector: , andVector:) -- and maybe a cosTheta func for similar?)

WIP Sept 2024.

---

todo - add Vec2 init without x, y labels? But target just Vec2 with a constraint on the chooint extension, is this possible?
(ambiguity about how to make cgpoint isn't great)



