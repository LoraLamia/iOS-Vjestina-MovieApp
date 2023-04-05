
import UIKit
import PureLayout

class MovieListTableViewCell: UITableViewCell {
    
    static let identifier = "MovieListTableViewCell"
    
    private var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    private let movieDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        return descriptionLabel
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerView)
        contentView.backgroundColor = .black.withAlphaComponent(0.05)

        containerView.autoPinEdge(toSuperviewEdge: .top, withInset: 6)
        containerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 6)
        containerView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        containerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        
        containerView.addSubview(movieImageView)
        containerView.addSubview(movieTitleLabel)
        containerView.addSubview(movieDescriptionLabel)
        
        movieImageView.autoPinEdge(toSuperviewEdge: .leading)
        movieImageView.autoPinEdge(toSuperviewEdge: .top)
        movieImageView.autoPinEdge(toSuperviewEdge: .bottom)
        movieImageView.autoSetDimension(.width, toSize: 97)
        
        movieTitleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        movieTitleLabel.autoPinEdge(.leading, to: .trailing, of: movieImageView, withOffset: 16)
        movieTitleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        movieTitleLabel.numberOfLines = 0
        
        movieDescriptionLabel.autoPinEdge(.top, to: .bottom, of: movieTitleLabel, withOffset: 8)
        movieDescriptionLabel.autoPinEdge(.leading, to: .trailing, of: movieImageView, withOffset: 16)
        movieDescriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        movieDescriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12)
        movieDescriptionLabel.numberOfLines = 0
        
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String, description: String) {
        self.movieTitleLabel.text = title
        self.movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.movieDescriptionLabel.text = description
        self.movieDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        self.movieDescriptionLabel.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        
    }

}