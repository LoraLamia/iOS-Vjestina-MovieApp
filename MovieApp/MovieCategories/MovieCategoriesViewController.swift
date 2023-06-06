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
//    private var streamingMovies: [Movie] = []

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
        categoriesTableView.register(LabelTableViewCell.self, forCellReuseIdentifier: LabelTableViewCell.identifier)
        categoriesTableView.register(MovieTypesCollectionViewTableViewCell.self, forCellReuseIdentifier: MovieTypesCollectionViewTableViewCell.identifier)
        categoriesTableView.register(MoviesCollectionViewTableViewCell.self, forCellReuseIdentifier: MoviesCollectionViewTableViewCell.identifier)
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
        viewModel.categoryMovies.count*3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index: Int
        if((indexPath.row + 1) % 3 == 0) {
            if(indexPath.row == 2) {
                index = 0
            } else if(indexPath.row == 5) {
                index = 1
            } else {
                index = 2
            }
            if let cell = categoriesTableView.dequeueReusableCell(withIdentifier: MoviesCollectionViewTableViewCell.identifier, for: indexPath) as? MoviesCollectionViewTableViewCell {
                cell.configure(movieList: categoryMovies[index])
                cell.delegate = self
                return cell
            }
        }
        if((indexPath.row) % 3 == 0) {
            if let cell = categoriesTableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as? LabelTableViewCell {
                cell.configure(title: viewModel.categoryTitles[indexPath.row/3])
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if(indexPath.row == 1) {
                index = 0
            } else if(indexPath.row == 4) {
                index = 1
            } else {
                index = 2
            }
            if let cell = categoriesTableView.dequeueReusableCell(withIdentifier: MovieTypesCollectionViewTableViewCell.identifier, for: indexPath) as? MovieTypesCollectionViewTableViewCell {
                cell.configure(movieTypes: viewModel.movieTypes[index])
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}

extension MovieCategoriesViewController: MovieCollectionCellDelegate {
    
    func didSelectMovie(id: Int) {
        router.showMovie(id: id)
    }
}
