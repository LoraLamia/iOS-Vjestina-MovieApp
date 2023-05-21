import Foundation
import MovieAppData

class MovieCategoriesViewModel {
    
    lazy var categoryMovies: [[MovieModel]] = {
        return [MovieUseCase().popularMovies, MovieUseCase().freeToWatchMovies, MovieUseCase().trendingMovies]
    }()
    
    let categoryTitles = ["What's popular", "Free to watch", "Trending"]
    
    func getMovieDetails(id: Int) -> MovieDetailsModel? {
        return MovieUseCase().getDetails(id: id)
    }
    
}
