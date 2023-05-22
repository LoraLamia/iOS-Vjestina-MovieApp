import Foundation

class MovieDetailsViewModel {
    
    @Published var movieDetails: MovieDetails = MovieDetails()
    var id: Int = 0
    private let moviesUseCase: MoviesUseCase!
    
    init(id: Int, moviesUseCase: MoviesUseCase) {
        self.id = id
        self.moviesUseCase = moviesUseCase
    }
    
    func getMovieDetails() {
        Task {
            let movie = await moviesUseCase.getMovieDetails(id: id)
            if let movie = movie {
                self.movieDetails = movie
            }
        }
    }
    
}
