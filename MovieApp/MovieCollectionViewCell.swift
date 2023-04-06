
import UIKit
import PureLayout

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    private let favoriteIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "favorite")
        return imageView
    }()
    
    public var movieImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleSubviews()
    }
        
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(movieImageView)
        
        movieImageView.autoPinEdgesToSuperviewEdges()
        movieImageView.autoSetDimension(.width, toSize: 122)
        movieImageView.addSubview(favoriteIconImageView)
        
        favoriteIconImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        favoriteIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        favoriteIconImageView.autoSetDimension(.height, toSize: 32)
    }
    
    private func styleSubviews() {
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
    }
}
