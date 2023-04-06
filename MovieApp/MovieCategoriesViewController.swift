
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
        
        categoriesTableView = UITableView()
        view.addSubview(categoriesTableView)
        categoriesTableView.dataSource = self
        categoriesTableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        categoriesTableView.autoPinEdgesToSuperviewEdges()
        categoriesTableView.separatorStyle = .none

    }
}

extension MovieCategoriesViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        
        cell.configure(title: categoryTitles[indexPath.row], movieList: categoryMovies[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//             300
//    }
    
}
