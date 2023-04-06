
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

class MovieListViewController: UIViewController, UITableViewDelegate {
    
    private var movieListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetUpAndLayout()
        view.backgroundColor = .black.withAlphaComponent(0.05)
    }
    
    private func tableViewSetUpAndLayout() {
        movieListTableView = UITableView()
        movieListTableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        
        view.addSubview(movieListTableView)
        
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        movieListTableView.rowHeight = 142
        
        movieListTableView.autoPinEdge(toSuperviewSafeArea: .leading)
        movieListTableView.autoPinEdge(toSuperviewSafeArea: .trailing)
        movieListTableView.autoPinEdge(toSuperviewSafeArea: .top)
        movieListTableView.autoPinEdge(toSuperviewSafeArea: .bottom)
        
        movieListTableView.separatorStyle = .none
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieUseCase().allMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieListTableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        let movies = MovieUseCase().allMovies
        cell.configure(title: movies[indexPath.row].name, description: movies[indexPath.row].summary)
        
        KF.url(URL(string: movies[indexPath.row].imageUrl)).set(to: cell.movieImageView)
        return cell
    }

}
