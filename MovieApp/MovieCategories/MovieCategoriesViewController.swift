import PureLayout
import UIKit
import Kingfisher
import Combine

class MovieCategoriesViewController: UIViewController, UITableViewDataSource {
    
    private var categoriesTableView: UITableView!
    
    private var router: AppRouter!
    private var viewModel: MovieCategoriesViewModel!
    private var disposeables = Set<AnyCancellable>()
    private var categoryMovies: [[Movie]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        buildviews()
        
        viewModel.getCategoryMovies()
        
        viewModel
            .$categoryMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self = self else { return }
                
                self.categoryMovies = movies
                self.categoriesTableView.reloadData()
            }
            .store(in: &disposeables)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.categoriesTableView.reloadData()
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
            cell.configure(title: viewModel.categoryTitles[indexPath.row], movieList: categoryMovies[indexPath.row])
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension MovieCategoriesViewController: MovieCollectionCellDelegate {
    
    func didSelectMovie(id: Int) {
        router.showMovie(id: id)
    }
}
