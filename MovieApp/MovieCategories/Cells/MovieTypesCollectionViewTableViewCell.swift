
import UIKit

class MovieTypesCollectionViewTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    static let identifier = "MovieTypesCollectionViewTableViewCell"
    private var movieTypesCollectionView: UICollectionView!
    private var movieTypes: [String]!
    var selectedIndex: IndexPath? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionViewSetUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func collectionViewSetUp() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 75, height: 48)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        movieTypesCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        contentView.addSubview(movieTypesCollectionView)
        movieTypesCollectionView.register(MovieTypesCollectionViewCell.self, forCellWithReuseIdentifier: MovieTypesCollectionViewCell.identifier)
        movieTypesCollectionView.dataSource = self
        movieTypesCollectionView.delegate = self
        movieTypesCollectionView.autoPinEdge(toSuperviewEdge: .top)
        movieTypesCollectionView.autoPinEdge(toSuperviewEdge: .bottom)
        movieTypesCollectionView.autoPinEdge(toSuperviewEdge: .leading)
        movieTypesCollectionView.autoPinEdge(toSuperviewEdge: .trailing)
        movieTypesCollectionView.autoSetDimension(.height, toSize: 48)
    }
    
    func configure(movieTypes: [String]) {
        self.movieTypes = movieTypes
    }

}

extension MovieTypesCollectionViewTableViewCell {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTypesCollectionViewCell.identifier, for: indexPath) as? MovieTypesCollectionViewCell {
            if(indexPath == self.selectedIndex) {
                cell.configure(type: movieTypes[indexPath.row], selected: true)
            } else {
                cell.configure(type: movieTypes[indexPath.row], selected: false)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        self.movieTypesCollectionView.reloadData()
    }
}

