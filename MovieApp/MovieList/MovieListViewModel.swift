import Foundation
import MovieAppData

class MovieListViewModel {
    
    @Published var movies: [Movie] = []
    let moviesUseCase: MoviesUseCase!
    
    init(movieUseCase: MoviesUseCase!) {
        self.moviesUseCase = movieUseCase
    }

    func fetchMovies() {
        Task {
            var freeToWatchMovies = await moviesUseCase.getFreeToWatchMovies(criteria: "MOVIE")
            freeToWatchMovies.append(contentsOf: await moviesUseCase.getFreeToWatchMovies(criteria: "TV_SHOW"))
            var popularMovies = await moviesUseCase.getPopularMovies(criteria: "FOR_RENT")
            popularMovies.append(contentsOf: await moviesUseCase.getPopularMovies(criteria: "IN_THEATERS"))
            popularMovies.append(contentsOf: await moviesUseCase.getPopularMovies(criteria: "ON_TV"))
            popularMovies.append(contentsOf: await moviesUseCase.getPopularMovies(criteria: "STREAMING"))
            var trendingMovies = await moviesUseCase.getTrendingMovies(criteria: "THIS_WEEK")
            trendingMovies.append(contentsOf: await moviesUseCase.getTrendingMovies(criteria: "TODAY"))
            self.movies = freeToWatchMovies + popularMovies + trendingMovies
        }
    }
    
    
    
    func getMovieDetails(rowIndex: Int) -> MovieDetailsModel? {
        let id = movies[rowIndex].id
        return MovieUseCase().getDetails(id: id)
    }
    
}
