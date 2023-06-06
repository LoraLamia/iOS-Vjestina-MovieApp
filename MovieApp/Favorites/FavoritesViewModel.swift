
import Foundation

class FavoritesViewModel {
    @Published var movies: [MovieDetails] = []
    let moviesUseCase: MoviesUseCase!
    
    init(movieUseCase: MoviesUseCase!) {
        self.moviesUseCase = movieUseCase
    }

    func getMovieDetails(id: Int) {
        Task {
            let movie = await moviesUseCase.getMovieDetails(id: id)
            if let movie = movie {
                self.movies.append(movie)
            }
        }
    }
    
    func getFavoriteMovies(ids: [Int]) {
        movies = []
        ids.forEach({ id in
            getMovieDetails(id: id)
        })
    }
}
