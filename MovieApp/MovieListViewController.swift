
import UIKit
import PureLayout
import MovieAppData

class MovieListViewController: UIViewController, UITableViewDelegate {
    
    private var movieListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieUseCase().allMovies.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieListTableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        let movies = MovieUseCase().allMovies
        cell.configure(title: movies[indexPath.section].name, description: movies[indexPath.section].summary)
        return cell
    }

}
