import Foundation
import MovieAppData

class MovieCategoriesViewModel {
    
    private let moviesUseCase: MoviesUseCase!
    @Published var categoryMovies: [[Movie]] = []
    
    init(moviesUseCase: MoviesUseCase) {
        self.moviesUseCase = moviesUseCase
    }
    
    let categoryTitles = ["What's popular", "Free to watch", "Trending"]
    
//    func getMovieDetails(id: Int) -> MovieDetailsModel? {
//        return MovieUseCase().getDetails(id: id)
//    }
    
    func getCategoryMovies() {
        Task {
            var popularMovies = await moviesUseCase.getPopularMovies(criteria: "FOR_RENT")
            print(popularMovies[0].id)
            popularMovies.append(contentsOf: await moviesUseCase.getPopularMovies(criteria: "IN_THEATERS"))
            popularMovies.append(contentsOf: await moviesUseCase.getPopularMovies(criteria: "ON_TV"))
            popularMovies.append(contentsOf: await moviesUseCase.getPopularMovies(criteria: "STREAMING"))
            var freeToWatchMovies = await moviesUseCase.getFreeToWatchMovies(criteria: "MOVIE")
            freeToWatchMovies.append(contentsOf: await moviesUseCase.getFreeToWatchMovies(criteria: "TV_SHOW"))
            var trendingMovies = await moviesUseCase.getTrendingMovies(criteria: "THIS_WEEK")
            trendingMovies.append(contentsOf: await moviesUseCase.getTrendingMovies(criteria: "TODAY"))
            self.categoryMovies = [popularMovies, freeToWatchMovies, trendingMovies]
        }
    }
    
}
