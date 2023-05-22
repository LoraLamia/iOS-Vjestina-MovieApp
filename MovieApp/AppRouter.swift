
import Foundation
import UIKit
import MovieAppData

class AppRouter {
    
    private let movieNavigationController: UINavigationController!
    private let favoritesNavigationController: UINavigationController!
    private let movieUseCase: MoviesUseCase!
    
    init() {
        self.movieNavigationController = UINavigationController()
        self.favoritesNavigationController = UINavigationController()
        self.movieUseCase = MoviesUseCase()
    }
    
    func setStartScreen(in window: UIWindow?) {
        let favoritesViewController = FavoritesViewController(viewModel: FavoritesViewModel())
        favoritesNavigationController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(named: "tabFavorites"),
            selectedImage: UIImage(named: "tabFavoritesSelected"))
        favoritesNavigationController.pushViewController(favoritesViewController, animated: true)
        let movieCategoriesViewController = MovieCategoriesViewController(router: self, viewModel: MovieCategoriesViewModel(moviesUseCase: movieUseCase))
        movieNavigationController.tabBarItem = UITabBarItem(
            title: "Movie List",
            image: UIImage(named: "tabMovieCategories"),
            selectedImage: UIImage(named: "tabMovieCategoriesSelected"))
        movieNavigationController.pushViewController(movieCategoriesViewController, animated: true)
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
        tabBarController.tabBar.barTintColor = .white
        tabBarController.viewControllers = [
            movieNavigationController,
            favoritesNavigationController
        ]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func showMovie(movieDetails: MovieDetailsModel) {
        
        let movieDetailsViewController = MovieDetailsViewController(viewModel: MovieDetailsViewModel(movieDetails: movieDetails))
        movieNavigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
}
