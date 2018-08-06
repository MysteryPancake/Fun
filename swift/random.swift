import Foundation

// RANDOM:

var previous: Double = 0

func random() -> Double {
  previous = cos(previous) * 1000
  return previous
}

// GRAPH:

var randoms = [Double]()
for _ in 0...100 {
  randoms.append(random())
}
randoms.map{ $0 }
