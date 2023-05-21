import Foundation

class MoviesUseCase {
    
    func getFreeToWatchMovies(criteria: String) async -> [Movie] {
        guard
            let request = createRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/free-to-watch?criteria=\(criteria)")
        else { return [] }
        
        async let (data, _) = try await URLSession.shared.data(for: request)
        let movies = try? await JSONDecoder().decode([Movie].self, from: data)

        return movies ?? []
    }
    
    func getPopularMovies(criteria: String) async -> [Movie] {
        guard
            let request = createRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/popular?criteria=\(criteria)")
        else { return [] }
        
        async let (data, _) = try await URLSession.shared.data(for: request)
        let movies = try? await JSONDecoder().decode([Movie].self, from: data)

        return movies ?? []
    }
    
    func getTrendingMovies(criteria: String) async -> [Movie] {
        guard
            let request = createRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/trending?criteria=\(criteria)")
        else { return [] }
        
        async let (data, _) = try await URLSession.shared.data(for: request)
        let movies = try? await JSONDecoder().decode([Movie].self, from: data)

        return movies ?? []
    }
    
    func getMovieDetails(id: Int) -> [MovieDetails] {
        return []
    }
    
    private func createRequest(for urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
