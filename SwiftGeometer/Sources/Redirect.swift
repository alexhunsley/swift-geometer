//
//  Redirect.swift
//  SwiftGeometer
//

import Foundation

/// Redirects to allow access to the usual sin etc. global functions from `_math`
/// from funcs with the same name in Angle (avoid name conflict)
internal func _sin(_ radians: CGFloat) -> CGFloat { sin(radians) }
internal func _cos(_ radians: CGFloat) -> CGFloat { cos(radians) }
internal func _tan(_ radians: CGFloat) -> CGFloat { tan(radians) }
internal func _sinh(_ radians: CGFloat) -> CGFloat { sinh(radians) }
internal func _cosh(_ radians: CGFloat) -> CGFloat { cosh(radians) }
internal func _tanh(_ radians: CGFloat) -> CGFloat { tanh(radians) }
internal func _asin(_ a: CGFloat) -> CGFloat { asin(a) }
internal func _acos(_ a: CGFloat) -> CGFloat { acos(a) }
internal func _atan(_ a: CGFloat) -> CGFloat { atan(a) }
internal func _atan2(_ y: CGFloat, _ x: CGFloat) -> CGFloat { atan2(y, x) }
internal func _asinh(_ a: CGFloat) -> CGFloat { asinh(a) }
internal func _acosh(_ a: CGFloat) -> CGFloat { acosh(a) }
internal func _atanh(_ a: CGFloat) -> CGFloat { atanh(a) }
