
import PureLayout
import UIKit
import Kingfisher
import MovieAppData

class MovieCategoriesViewController: UIViewController, UITableViewDataSource {
    
    private var categoryTitles = ["What's popular", "Free to watch", "Trending"]
    private var categoryMovies = [MovieUseCase().popularMovies, MovieUseCase().freeToWatchMovies, MovieUseCase().trendingMovies]
    private var categoriesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildviews()
    }
    
    private func buildviews() {
        createViews()
        layoutViews()
        styleViews()
    }
    
    private func createViews() {
        categoriesTableView = UITableView()
        categoriesTableView.dataSource = self
        categoriesTableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
    }
    
    private func layoutViews() {
        view.addSubview(categoriesTableView)
        categoriesTableView.autoPinEdgesToSuperviewEdges()
    }
    
    private func styleViews() {
        categoriesTableView.separatorStyle = .none
    }
}

extension MovieCategoriesViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = categoriesTableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell {
            cell.configure(title: categoryTitles[indexPath.row], movieList: categoryMovies[indexPath.row])
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}

extension MovieCategoriesViewController: MovieCollectionCellDelegate {
    
    func didSelectMovie(movieDetails: MovieDetailsModel) {
        let movieDetailsViewController = MovieDetailsViewController(urlString: movieDetails.imageUrl)
        movieDetailsViewController.detailsLabel = movieDetails
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}
