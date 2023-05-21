
import UIKit
import PureLayout
import Kingfisher
import MovieAppData

class MovieListTableViewCell: UITableViewCell {
    
    static let identifier = "MovieListTableViewCell"
    private var movieImageView: UIImageView!
    private var movieTitleLabel: UILabel!
    private var movieDescriptionLabel: UILabel!
    private var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        layoutViews()
        styleSubviews()
    }
    
    private func createViews() {
        movieImageView = UIImageView()
        movieTitleLabel = UILabel()
        movieDescriptionLabel = UILabel()
        containerView = UILabel()
    }
    
    private func layoutViews() {
        contentView.addSubview(containerView)

        containerView.autoPinEdge(toSuperviewEdge: .top, withInset: 6)
        containerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 6)
        containerView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        containerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        
        containerView.addSubview(movieImageView)
        
        movieImageView.autoPinEdge(toSuperviewEdge: .leading)
        movieImageView.autoPinEdge(toSuperviewEdge: .top)
        movieImageView.autoPinEdge(toSuperviewEdge: .bottom)
        movieImageView.autoSetDimension(.width, toSize: 97)
        
        containerView.addSubview(movieTitleLabel)
        
        movieTitleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        movieTitleLabel.autoPinEdge(.leading, to: .trailing, of: movieImageView, withOffset: 16)
        movieTitleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        movieTitleLabel.numberOfLines = 0
        
        containerView.addSubview(movieDescriptionLabel)
        
        movieDescriptionLabel.autoPinEdge(.top, to: .bottom, of: movieTitleLabel, withOffset: 8)
        movieDescriptionLabel.autoPinEdge(.leading, to: .trailing, of: movieImageView, withOffset: 16)
        movieDescriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        movieDescriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12)
        movieDescriptionLabel.numberOfLines = 0
    }
    
    private func styleSubviews() {
        contentView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowRadius = 2
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieModel) {
        self.movieTitleLabel.text = movie.name
        self.movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.movieDescriptionLabel.text = movie.summary
        self.movieDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        self.movieDescriptionLabel.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        self.movieImageView.kf.setImage(with: URL(string: movie.imageUrl))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitleLabel.text = nil
        movieDescriptionLabel.text = nil
        movieImageView.image = nil
    }
}
