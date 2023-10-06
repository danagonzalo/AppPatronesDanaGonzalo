import Foundation

struct Transformation: Decodable, TableViewRepresentable {
    static let transformationsIdentifier = "Transformations"
    let id: String
    var name: String
    let description: String
    let photo: String
    let hero: TransformationHero?
}

struct TransformationHero: Decodable {
    let id: String
}


