
import UIKit
import PureLayout
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    private var favoriteButton: UIButton!
    private var movieImageView: UIImageView!
    private var id: Int?
    private weak var delegate: Delegate?
    
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
        addActions()
    }
    
    private func createViews() {
        favoriteButton = UIButton()
        movieImageView = UIImageView()
        contentView.addSubview(movieImageView)
        contentView.addSubview(favoriteButton)
    }
    
    private func layoutViews() {
        movieImageView.autoPinEdgesToSuperviewEdges()
        
        favoriteButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        favoriteButton.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        favoriteButton.autoSetDimension(.height, toSize: 32)
    }
    
    private func styleViews() {
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        favoriteButton.setImage(UIImage(named: "favoriteChosen"), for: .selected)
    }
    
    func configure(imageUrl: String, id: Int, delegate: Delegate?) {
        self.delegate = delegate
        self.id = id
        self.movieImageView.kf.setImage(with: URL(string: imageUrl))
        let savedNumbers = UserDefaults.standard.array(forKey: "favorites") as? [Int]
        if let savedNumbers = savedNumbers {
            if savedNumbers.contains(id) {
                favoriteButton.isSelected = true
            } else {
                favoriteButton.isSelected = false
            }
        } else {
            favoriteButton.isSelected = false
        }
    }
    
    override func prepareForReuse() {
        movieImageView.image = nil
    }
    
    private func addActions() {
        favoriteButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        let userDefaults = UserDefaults.standard
        let savedNumbers = userDefaults.array(forKey: "favorites") as? [Int]
        if favoriteButton.isSelected {
            if var savedNumbers = savedNumbers {
                if let id = id {
                    savedNumbers.append(id)
                    userDefaults.set(savedNumbers, forKey: "favorites")
                }
            } else {
                if let id = id {
                    let ids = [id]
                    userDefaults.set(ids, forKey: "favorites")
                }
            }
        } else {
            if var savedNumbers = savedNumbers {
                if let id = id {
                    let index = savedNumbers.firstIndex(of: id)
                    if let index = index {
                        savedNumbers.remove(at: index)
                        userDefaults.set(savedNumbers, forKey: "favorites")
                    }
                }
            }
        }
        delegate?.refreshData()
    }
}

