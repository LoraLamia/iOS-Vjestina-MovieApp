
import UIKit

class MovieTypesCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieTypesCollectionViewCell"
    private var typeLabel: UILabel!
    private var underlineView: UIView!
    
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
        typeLabel = UILabel()
        underlineView = UIView()
    }
    
    private func layoutViews() {
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        
        typeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        typeLabel.autoPinEdge(toSuperviewEdge: .leading)
        typeLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        underlineView.autoPinEdge(toSuperviewEdge: .trailing)
        underlineView.autoPinEdge(toSuperviewEdge: .leading)
        underlineView.autoPinEdge(.top, to: .bottom, of: typeLabel, withOffset: 4)
        underlineView.autoSetDimension(.height, toSize: 2)
        underlineView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 14)
    }
    
    private func styleViews() {
        typeLabel.font = UIFont.systemFont(ofSize: 14)
        typeLabel.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        underlineView.backgroundColor = .black.withAlphaComponent(0)
    }
    
    func configure(type: String, selected: Bool) {
        if selected {
            self.typeLabel.font = UIFont.boldSystemFont(ofSize: 14)
            self.typeLabel.textColor = .black
            self.underlineView.backgroundColor = .black
        } else {
            styleViews()
        }
        self.typeLabel.text = type
    }
}
