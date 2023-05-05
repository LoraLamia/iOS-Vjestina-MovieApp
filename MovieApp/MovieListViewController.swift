
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

class MovieListViewController: UIViewController, UITableViewDelegate {
    
    private var movieListTableView: UITableView!
    var router: AppRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        tableViewSetUp()
    }
    
    init(router: AppRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tableViewSetUp() {
        movieListTableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
    }
    
    private func buildViews() {
        createViews()
        layoutViews()
        styleViews()
    }
    
    private func createViews() {
        movieListTableView = UITableView()
    }
    
    private func layoutViews() {
        view.addSubview(movieListTableView)
        movieListTableView.autoPinEdge(toSuperviewSafeArea: .leading)
        movieListTableView.autoPinEdge(toSuperviewSafeArea: .trailing)
        movieListTableView.autoPinEdge(toSuperviewSafeArea: .top)
        movieListTableView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }
    
    private func styleViews() {
        self.title = "Movie List"
        movieListTableView.separatorStyle = .none
        movieListTableView.rowHeight = 142
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MovieUseCase().allMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = movieListTableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell {
            let movies = MovieUseCase().allMovies
            cell.configure(title: movies[indexPath.row].name, description: movies[indexPath.row].summary)
            
            KF.url(URL(string: movies[indexPath.row].imageUrl)).set(to: cell.movieImageView)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movies = MovieUseCase().allMovies
        guard let movieDetailsModel = MovieUseCase().getDetails(id: movies[indexPath.row].id) else { return }
        router.showMovie(movieDetails: movieDetailsModel)
    }
}
