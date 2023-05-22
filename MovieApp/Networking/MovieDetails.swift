import Foundation

class MovieDetails: Codable {
    let id: Int
    let duration: Int
    let imageUrl: String
    let name: String
    let rating: Double
    let releaseDate: String
    let summary: String
    let year: Int
    
    let categories: [String]
    let crewMembers: [CrewMember]
    
    init() {
        id = 0
        duration = 0
        imageUrl = ""
        name = ""
        rating = 0
        releaseDate = ""
        summary = ""
        year = 0
        categories = []
        crewMembers = []
    }
}

class CrewMember: Codable {
    let name: String
    let role: String
}
