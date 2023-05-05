
import PureLayout
import UIKit
import Kingfisher
import MovieAppData

class MovieCategoriesViewController: UIViewController, UITableViewDataSource {
    
    private var categoryTitles = ["What's popular", "Free to watch", "Trending"]
    private var categoryMovies = [MovieUseCase().popularMovies, MovieUseCase().freeToWatchMovies, MovieUseCase().trendingMovies]
    private var categoriesTableView: UITableView!
    var router: AppRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildviews()
    }
    
    init(router: AppRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        self.title = "Movie List"
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
        router.showMovie(movieDetails: movieDetails)
    }
}
