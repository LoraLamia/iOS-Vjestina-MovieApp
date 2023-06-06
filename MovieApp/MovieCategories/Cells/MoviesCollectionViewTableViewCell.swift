import UIKit
import PureLayout
import MovieAppData
import Kingfisher

protocol MovieCollectionCellDelegate: AnyObject {
    func didSelectMovie(id: Int)
}

class MoviesCollectionViewTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    static let identifier = "MoviesCollectionViewTableViewCell"
    private var collectionView: UICollectionView!
    weak var delegate: MovieCollectionCellDelegate?
    private var movieList: [Movie]!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionViewSetUp()
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        layoutViews()
        styleViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movieList: [Movie]) {
        self.movieList = movieList
        collectionView.reloadData()
    }
    
    private func createViews() {
    }
    
    private func layoutViews() {
        contentView.addSubview(collectionView)
        collectionView.autoPinEdge(toSuperviewEdge: .top)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoSetDimension(.height, toSize: 179)
    }
    
    private func styleViews() {
        self.selectionStyle = .none
    }
    
    private func collectionViewSetUp() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 122, height: 179)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension MoviesCollectionViewTableViewCell {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell {
            cell.configure(imageUrl: movieList[indexPath.row].imageUrl, id: movieList[indexPath.row].id, delegate: nil)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectMovie(id: movieList[indexPath.row].id)
    }
}
