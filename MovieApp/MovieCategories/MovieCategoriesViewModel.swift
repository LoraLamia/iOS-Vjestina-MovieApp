import Foundation
import MovieAppData

class MovieCategoriesViewModel {
    
    private let moviesUseCase: MoviesUseCase!
    
    lazy var categoryMovies: [[MovieModel]] = {
        return [MovieUseCase().popularMovies, MovieUseCase().freeToWatchMovies, MovieUseCase().trendingMovies]
    }()
    
    init(moviesUseCase: MoviesUseCase) {
        self.moviesUseCase = moviesUseCase
    }
    
    let categoryTitles = ["What's popular", "Free to watch", "Trending"]
    
    func getMovieDetails(id: Int) -> MovieDetailsModel? {
        return MovieUseCase().getDetails(id: id)
    }
    
}
