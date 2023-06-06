
import UIKit
import PureLayout

class LabelTableViewCell: UITableViewCell {
    
    static let identifier = "LabelTableViewCell"
    private var categoryLabel: UILabel!

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
        styleViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        categoryLabel.text = title
    }
    
    private func createViews() {
        categoryLabel = UILabel()
    }
    
    private func layoutViews() {
        contentView.addSubview(categoryLabel)
        categoryLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        categoryLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        categoryLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        categoryLabel.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func styleViews() {
        categoryLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 800))
        self.selectionStyle = .none
    }
}

