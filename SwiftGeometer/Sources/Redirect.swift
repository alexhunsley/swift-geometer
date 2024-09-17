//
//  Redirect.swift
//  SwiftGeometer
//

import Foundation

/// Redirects to allow access to the usual sin etc. global functions from `_math`
/// from funcs with the same name in Angle (avoid name resolution conflict)
@Sendable internal func _sin(_ radians: CGFloat) -> CGFloat { sin(radians) }
@Sendable internal func _cos(_ radians: CGFloat) -> CGFloat { cos(radians) }
@Sendable internal func _tan(_ radians: CGFloat) -> CGFloat { tan(radians) }
@Sendable internal func _sinh(_ radians: CGFloat) -> CGFloat { sinh(radians) }
@Sendable internal func _cosh(_ radians: CGFloat) -> CGFloat { cosh(radians) }
@Sendable internal func _tanh(_ radians: CGFloat) -> CGFloat { tanh(radians) }
@Sendable internal func _asin(_ a: CGFloat) -> CGFloat { asin(a) }
@Sendable internal func _acos(_ a: CGFloat) -> CGFloat { acos(a) }
@Sendable internal func _atan(_ a: CGFloat) -> CGFloat { atan(a) }
@Sendable internal func _atan2(_ y: CGFloat, _ x: CGFloat) -> CGFloat { atan2(y, x) }
@Sendable internal func _asinh(_ a: CGFloat) -> CGFloat { asinh(a) }
@Sendable internal func _acosh(_ a: CGFloat) -> CGFloat { acosh(a) }
@Sendable internal func _atanh(_ a: CGFloat) -> CGFloat { atanh(a) }
