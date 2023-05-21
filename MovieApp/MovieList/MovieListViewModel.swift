import MovieAppData
import Foundation

class MovieListViewModel {
    lazy var movies: [MovieModel] = {
        return MovieUseCase().allMovies
    }()
    
    func getMovieDetails(rowIndex: Int) -> MovieDetailsModel? {
        let id = movies[rowIndex].id
        return MovieUseCase().getDetails(id: id)
    }
    
}
