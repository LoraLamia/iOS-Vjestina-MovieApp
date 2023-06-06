import Combine
import UIKit

protocol Delegate: AnyObject {
    
    func refreshData()
}

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var collectionView: UICollectionView!
    
    private var viewModel: FavoritesViewModel!
    private var disposeables = Set<AnyCancellable>()
    private var movies: [MovieDetails] = []
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        layoutViews()
        styleViews()
    }
    
    private func createViews() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        let width = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize(width: (width / 3) - 18, height: 167)
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    private func layoutViews() {
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        collectionView.autoPinEdge(toSuperviewEdge: .top)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        self.title = "Favorites"
    }
    
    private func fetchMovies() {
        let ids = UserDefaults.standard.array(forKey: "favorites") as? [Int]
        if let ids = ids {
            viewModel.getFavoriteMovies(ids: ids)
        }
        
        viewModel
            .$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self = self else { return }
                
                var sortedMovies: [MovieDetails] = []
                ids?.forEach { id in
                    let movie = movies.first(where: { movie in movie.id == id })
                    
                    if let movie = movie {
                        sortedMovies.append(movie)
                    }
                }
                
                self.movies = sortedMovies
                self.collectionView.reloadData()
            }
            .store(in: &disposeables)
    }

}

extension FavoritesViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                         for: indexPath) as? MovieCollectionViewCell {
            cell.configure(imageUrl: movies[indexPath.row].imageUrl, id: movies[indexPath.row].id, delegate: self)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension FavoritesViewController: Delegate {
    func refreshData() {
        fetchMovies()
    }
}
