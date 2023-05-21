import Foundation

class MovieDetails: Codable {
    let id: Int
    let duration: Int
    let imageUrl: String
    let name: String
    let rating: Int
    let releaseDate: String
    let summary: String
    let year: Int
    
    let categories: [String]
    let crewMembers: [CrewMember]
}

class CrewMember: Codable {
    let name: String
    let role: String
}
