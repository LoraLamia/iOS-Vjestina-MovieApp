import Foundation

class MovieCategoriesViewModel {
    
    private let moviesUseCase: MoviesUseCase!
    @Published var categoryMovies: [[Movie]] = []
    @Published var theaterMovies: [Movie] = []
    @Published var forRentMovies: [Movie] = []
    @Published var onTVMovies: [Movie] = []
    @Published var streamingMovies: [Movie] = []
    @Published var otherMovies: [Movie] = []
    @Published var tvShows: [Movie] = []
    @Published var thisWeekMovies: [Movie] = []
    @Published var todayMovies: [Movie] = []
    
    
    init(moviesUseCase: MoviesUseCase) {
        self.moviesUseCase = moviesUseCase
    }
    
    let categoryTitles = ["What's popular", "Free to watch", "Trending"]
    let movieTypes = [["Streaming", "On TV", "For Rent", "In theaters"], ["Movies", "TV"], ["Today", "This Week"]]
    
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
    
    func getTheaterMovies() {
        Task {
            self.theaterMovies = await moviesUseCase.getPopularMovies(criteria: "IN_THEATERS")
        }
    }
    
    func getForRentMovies() {
        Task {
            self.forRentMovies = await moviesUseCase.getPopularMovies(criteria: "FOR_RENT")
        }
    }
    
    func getOnTVMovies() {
        Task {
            self.onTVMovies = await moviesUseCase.getPopularMovies(criteria: "ON_TV")
        }
    }
    
    func getStreamingMovies() {
        Task {
            self.streamingMovies = await moviesUseCase.getPopularMovies(criteria: "STREAMING")
        }
    }
    
    func getOtherMovies() {
        Task {
            self.otherMovies = await moviesUseCase.getFreeToWatchMovies(criteria: "MOVIE")
        }
    }
    
    func getTVShows() {
        Task {
            self.tvShows = await moviesUseCase.getFreeToWatchMovies(criteria: "TV_SHOW")
        }
    }
    
    func getThisWeekMovies() {
        Task {
            self.thisWeekMovies = await moviesUseCase.getTrendingMovies(criteria: "THIS_WEEK")
        }
    }
    
    func getTodayMovies() {
        Task {
            self.todayMovies = await moviesUseCase.getTrendingMovies(criteria: "TODAY")
        }
    }
    
}
