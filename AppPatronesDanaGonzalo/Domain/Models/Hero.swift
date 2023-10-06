import Foundation

struct Hero: Decodable, TableViewRepresentable {
        
    let id: String
    var name: String
    let description: String
    let photo: String
    let favorite: Bool
}
