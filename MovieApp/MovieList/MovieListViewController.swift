
import UIKit
import PureLayout
import Kingfisher
import Combine

class MovieListViewController: UIViewController, UITableViewDelegate {
    
    private var movieListTableView: UITableView!
    
    private var router: AppRouter!
    private var viewModel: MovieListViewModel!
    
    private var movies: [Movie] = []
    private var disposeables = Set<AnyCancellable>()
    
    init(router: AppRouter, viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        tableViewSetUp()
        
        viewModel.fetchMovies()
        
        viewModel
            .$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self = self else { return }
                
                self.movies = movies
                self.movieListTableView.reloadData()
            }
            .store(in: &disposeables)
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
        movieListTableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    }
    
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = movieListTableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell {
            cell.configure(movie: movies[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.showMovie(id: movies[indexPath.row].id)
    }
}
