import PureLayout
import UIKit
import Kingfisher
import MovieAppData

class MovieCategoriesViewController: UIViewController, UITableViewDataSource {
    
    private var categoriesTableView: UITableView!
    
    private var router: AppRouter!
    private var viewModel: MovieCategoriesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildviews()
    }
    
    init(router: AppRouter, viewModel: MovieCategoriesViewModel) {
        self.viewModel = viewModel
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
        viewModel.categoryMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = categoriesTableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell {
            cell.configure(title: viewModel.categoryTitles[indexPath.row], movieList: viewModel.categoryMovies[indexPath.row])
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension MovieCategoriesViewController: MovieCollectionCellDelegate {
    
    func didSelectMovie(id: Int) {
        let movieDetails = viewModel.getMovieDetails(id: id)

        if let movieDetails = movieDetails {
            router.showMovie(movieDetails: movieDetails)
        }
    }
}
