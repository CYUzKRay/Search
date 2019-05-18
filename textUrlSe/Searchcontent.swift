
import Foundation

struct Searchcontent: Codable{
    let type:String
    let features: [Features]
}
struct Features: Codable {
    let type:String
    let properties: Properties
    let geometry: Geometry
}

struct Properties: Codable {
    let name:String
    let count:Int
    let shareimage:String?
}

struct Geometry: Codable {
    let type:String?
    let coordinates:[Double]
}

