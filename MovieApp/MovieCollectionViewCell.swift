
import UIKit
import PureLayout

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    private var favoriteIconImageView: UIImageView!
    public var movieImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        
        contentView.addSubview(movieImageView)
        movieImageView.addSubview(favoriteIconImageView)
        
        layout()
        styleSubviews()
    }
        
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func createViews() {
        favoriteIconImageView = UIImageView()
        movieImageView = UIImageView()
    }
    
    private func layout() {
        movieImageView.autoPinEdgesToSuperviewEdges()
        movieImageView.autoSetDimension(.width, toSize: 122)
        
        favoriteIconImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        favoriteIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        favoriteIconImageView.autoSetDimension(.height, toSize: 32)
    }
    
    private func styleSubviews() {
        favoriteIconImageView.image = UIImage(named: "favorite")
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        movieImageView.image = nil
    }
}
