
import UIKit
import PureLayout

class CrewCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "crewCellIdentifier"
    
    private var crewMemberNameLabel: UILabel!
    
    private var crewMemberPositionLabel: UILabel!
    
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
    }
    
    private func createViews() {
        crewMemberNameLabel = UILabel()
        crewMemberPositionLabel = UILabel()
    }
    
    private func layoutViews() {
        contentView.addSubview(crewMemberNameLabel)
        contentView.addSubview(crewMemberPositionLabel)
        crewMemberNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 3)
        crewMemberNameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        crewMemberNameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        crewMemberPositionLabel.autoPinEdge(.top, to: .bottom, of: crewMemberNameLabel, withOffset: 3)
        crewMemberPositionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        crewMemberPositionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        crewMemberPositionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    }
    
    func configure(name: String, position: String) {
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
