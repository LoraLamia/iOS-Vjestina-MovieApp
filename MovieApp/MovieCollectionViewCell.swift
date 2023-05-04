
import UIKit
import PureLayout

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    private var favoriteIconImageView: UIImageView!
    var movieImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func buildViews() {
        createViews()
        layoutViews()
        styleViews()
    }
    
    private func createViews() {
        favoriteIconImageView = UIImageView()
        movieImageView = UIImageView()
        contentView.addSubview(movieImageView)
        movieImageView.addSubview(favoriteIconImageView)
    }
    
    private func layoutViews() {
        movieImageView.autoPinEdgesToSuperviewEdges()
        movieImageView.autoSetDimension(.width, toSize: 122)
        
        favoriteIconImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        favoriteIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        favoriteIconImageView.autoSetDimension(.height, toSize: 32)
    }
    
    private func styleViews() {
        favoriteIconImageView.image = UIImage(named: "favorite")
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        movieImageView.image = nil
    }
}
