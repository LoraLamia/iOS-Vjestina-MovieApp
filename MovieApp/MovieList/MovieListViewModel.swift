import Foundation
import MovieAppData

class MovieListViewModel {
    
    @Published var movies: [Movie] = []
    let movieUseCase: MoviesUseCase!
    
    init(movieUseCase: MoviesUseCase!) {
        self.movieUseCase = movieUseCase
    }

    func fetchMovies() {
        Task {
            var freeToWatchMovies = await movieUseCase.getFreeToWatchMovies(criteria: "MOVIE")
            freeToWatchMovies.append(contentsOf: await movieUseCase.getFreeToWatchMovies(criteria: "TV_SHOW"))
            var popularMovies = await movieUseCase.getPopularMovies(criteria: "FOR_RENT")
            popularMovies.append(contentsOf: await movieUseCase.getPopularMovies(criteria: "IN_THEATERS"))
            popularMovies.append(contentsOf: await movieUseCase.getPopularMovies(criteria: "ON_TV"))
            popularMovies.append(contentsOf: await movieUseCase.getPopularMovies(criteria: "STREAMING"))
            var trendingMovies = await movieUseCase.getTrendingMovies(criteria: "THIS_WEEK")
            trendingMovies.append(contentsOf: await movieUseCase.getTrendingMovies(criteria: "TODAY"))
            self.movies = freeToWatchMovies + popularMovies + trendingMovies
        }
    }
    
    
    
    func getMovieDetails(rowIndex: Int) -> MovieDetailsModel? {
        let id = movies[rowIndex].id
        return MovieUseCase().getDetails(id: id)
    }
    
}
