
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

class CollectionTableViewCell: UITableViewCell, UICollectionViewDataSource {
    
    static let identifier = "CollectionTableViewCell"
    private let categoryLabel = UILabel()
    private var collectionView: UICollectionView!
    private var movieList: [MovieModel]!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionViewSetUp()
        
        contentView.addSubview(categoryLabel)
        contentView.addSubview(collectionView)
        
        layoutViews()
        
        categoryLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 800))
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(title: String, movieList: [MovieModel]) {
        categoryLabel.text = title
        self.movieList = movieList
    }
    
    private func layoutViews() {
        categoryLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        categoryLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        categoryLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: categoryLabel, withOffset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoSetDimension(.height, toSize: 179)
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
    }

}

extension CollectionTableViewCell {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        
        KF.url(URL(string: movieList[indexPath.row].imageUrl)).set(to: cell.movieImageView)
        return cell
    }
}
