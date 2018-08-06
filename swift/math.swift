import Foundation
import CoreGraphics

func distance(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
  let distX = x2 - x1
  let distY = y2 - y1
  return sqrt((distX * distX) + (distY * distY))
}

func gradient(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
  return (y2 - y1) / (x2 - x1)
}

func gradient(_ rise: Double, _ run: Double) -> Double {
  return rise / run
}

func midpoint(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> (Double, Double) {
  return ((x1 + x2) / 2, (y1 + y2) / 2)
}

func cosec(_ theta: Double) -> Double {
  return 1 / sin(theta)
}
