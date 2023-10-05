import Foundation

typealias Heroes = [Hero]


struct Hero: Decodable {
    static let heroesIdentifier = "Heroes"
    let id: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool

}
