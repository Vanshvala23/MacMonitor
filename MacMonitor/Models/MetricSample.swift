import Foundation
struct MetricSample:Identifiable{
    let id=UUID()
    let timestamps:Date
    let value:Double
}
