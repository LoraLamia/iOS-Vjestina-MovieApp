
import Foundation
import UIKit
import MovieAppData

class AppRouter {
    
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setStartScreen(in window: UIWindow?) {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(named: "tabFavorites"),
            selectedImage: UIImage(named: "tabFavoritesSelected"))
        let movieCategoriesViewController = MovieListViewController(router: self)
        navigationController.tabBarItem = UITabBarItem(
            title: "Movie List",
            image: UIImage(named: "tabMovieCategories"),
            selectedImage: UIImage(named: "tabMovieCategoriesSelected"))
        navigationController.pushViewController(movieCategoriesViewController, animated: true)
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
        tabBarController.tabBar.barTintColor = .white
        tabBarController.viewControllers = [
            navigationController,
            favoritesViewController
        ]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func showMovie(movieDetails: MovieDetailsModel) {
        let movieDetailsViewController = MovieDetailsViewController(movieDetailsModel: movieDetails)
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
}
