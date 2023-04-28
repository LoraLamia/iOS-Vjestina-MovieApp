
import UIKit
import PureLayout

class MyCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "crewCellIdentifier"
    
    private var crewMemberNameLabel: UILabel!
    
    private var crewMemberPositionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        crewMemberNameLabel = UILabel()
        crewMemberPositionLabel = UILabel()
        contentView.addSubview(crewMemberNameLabel)
        contentView.addSubview(crewMemberPositionLabel)
        defineLayout();
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func defineLayout() {
        crewMemberNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 3)
        crewMemberNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        crewMemberNameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        crewMemberPositionLabel.autoPinEdge(.top, to: .bottom, of: crewMemberNameLabel, withOffset: 3)
        crewMemberPositionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        crewMemberPositionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        crewMemberPositionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)

    }
    
    public func configure(name: String, position: String) {
        self.crewMemberNameLabel.text = name
        self.crewMemberNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.crewMemberPositionLabel.text = position
        self.crewMemberPositionLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.crewMemberNameLabel.text = nil
        self.crewMemberPositionLabel.text = nil
    }
}
