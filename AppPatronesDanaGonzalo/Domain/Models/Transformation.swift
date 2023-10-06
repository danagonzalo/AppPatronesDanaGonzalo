import Foundation

struct Transformation: Decodable, TableViewRepresentable {
        
    let id: String
    var name: String
    let description: String
    let photo: String
}

struct TransformationHero: Decodable {
    let id: String
}


