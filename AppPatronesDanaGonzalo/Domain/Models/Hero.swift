import Foundation

struct Hero: Decodable, TableViewRepresentable {
    
    static let heroesIdentifier = "Heroes"
    
    let id: String
    var name: String
    let description: String
    let photo: String
    let favorite: Bool
}
