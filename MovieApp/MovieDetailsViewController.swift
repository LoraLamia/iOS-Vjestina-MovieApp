
import PureLayout
import UIKit
import MovieAppData
import Kingfisher

class MovieDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var movieImageView: UIImageView!
    private var starIconImageView: UIImageView!
    private var ratingLabel: UILabel!
    private var userScoreLabel: UILabel!
    private var titleLabel: UILabel!
    private var releaseYearLabel: UILabel!
    private var dateLabel: UILabel!
    private var categoriesLabel: UILabel!
    private var durationLabel: UILabel!
    private var overViewLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var collectionView: UICollectionView!
    private var H1StackView: UIStackView!
    private var H3StackView: UIStackView!
    let movieDetailsModel: MovieDetailsModel!
    
    init(movieDetailsModel: MovieDetailsModel) {
        self.movieDetailsModel = movieDetailsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        layoutViews()
        styleViews()
    }
    
    private func createViews() {
        movieImageView = UIImageView()
        let url = URL(string: movieDetailsModel.imageUrl)
        movieImageView.kf.setImage(with: url)
        H1StackView = UIStackView()
        ratingLabel = UILabel()
        titleLabel = UILabel()
        releaseYearLabel = UILabel()
        categoriesLabel = UILabel()
        durationLabel = UILabel()
        dateLabel = UILabel()
        overViewLabel = UILabel()
        descriptionLabel = UILabel()
        H3StackView = UIStackView()
        let starIconImage = UIImage(named: "starIcon")
        starIconImageView = UIImageView(image: starIconImage)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        let width = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize(width: (width / 3) - 32, height: 50)
    }
    
    private func layoutViews() {
        
        view.addSubview(movieImageView)
        
        movieImageView.autoPinEdge(toSuperviewEdge: .leading)
        movieImageView.autoPinEdge(toSuperviewEdge: .trailing)
        movieImageView.autoPinEdge(toSuperviewSafeArea: .top)
        movieImageView.autoSetDimension(.height, toSize: 327)
        
        userScoreLabel = UILabel()
        
        H1StackView.addArrangedSubview(ratingLabel)
        H1StackView.addArrangedSubview(userScoreLabel)
        movieImageView.addSubview(H1StackView)
        
        H1StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        H1StackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 90)
        
        let H2StackView = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel])
        
        movieImageView.addSubview(H2StackView)
        
        H2StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        H2StackView.autoPinEdge(.top, to: .bottom, of: H1StackView, withOffset: 16)
        H2StackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        movieImageView.addSubview(dateLabel)
        
        dateLabel.autoPinEdge(.top, to: .bottom, of: H2StackView, withOffset: 16)
        dateLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)

        H3StackView.addArrangedSubview(categoriesLabel)
        H3StackView.addArrangedSubview(durationLabel)
        
        movieImageView.addSubview(H3StackView)
        
        H3StackView.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 0)
        H3StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        
        movieImageView.addSubview(starIconImageView)
        
        starIconImageView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        starIconImageView.autoPinEdge(.top, to: .bottom, of: H3StackView, withOffset: 16)
        starIconImageView.autoSetDimension(.height, toSize: 32)
        
        view.addSubview(overViewLabel)
        
        overViewLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        overViewLabel.autoPinEdge(.top, to: .bottom, of: movieImageView, withOffset: 22)
        
        view.addSubview(descriptionLabel)
        
        descriptionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: overViewLabel, withOffset: 16)
        
        view.addSubview(collectionView)
        
        collectionView.register(CrewCollectionViewCell.self, forCellWithReuseIdentifier: CrewCollectionViewCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        collectionView.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 27)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func styleViews() {
        self.title = "Movie Details"
//        self.navigationController?.navigationBar.backgroundColor = .white
        ratingLabel.text = String(movieDetailsModel.rating)
        userScoreLabel.text = "User score"
        
        H1StackView.spacing = 8

        titleLabel.text = movieDetailsModel.name
        
        releaseYearLabel.text = "(" + "\(movieDetailsModel.year)" + ")"
        
        let stringCategories = movieDetailsModel.categories.map {
            categorie in "\(categorie)"
        }.joined(separator: ",")
        categoriesLabel.text = stringCategories
        
        let hours = movieDetailsModel.duration / 60
        let minutes = movieDetailsModel.duration - hours*60
        durationLabel.text = "\(hours)" + "h " + "\(minutes)" + "m"
        
        let newDateFormat = convertDateFormat(sourceDateString: movieDetailsModel.releaseDate, sourceDateFormat: "yyyy-MM-dd", destinationFormat: "dd/MM/yyyy")
        dateLabel.text = newDateFormat + " (US)"
        
        overViewLabel.text = "Overview"
        
        descriptionLabel.text = movieDetailsModel.summary
        
        descriptionLabel.numberOfLines = 0
        
        H3StackView.spacing = 8
        
        starIconImageView.contentMode = .scaleAspectFill
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        
        view.backgroundColor = .white
        
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        ratingLabel.textColor = .white

        userScoreLabel.textColor = .white
        userScoreLabel.font = UIFont.systemFont(ofSize: 14)

        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        releaseYearLabel.textColor = .white
        releaseYearLabel.font = UIFont.systemFont(ofSize: 24)

        categoriesLabel.textColor = .white

        durationLabel.font = UIFont.boldSystemFont(ofSize: 14)
        durationLabel.textColor = .white
        
        dateLabel.textColor = .white

        overViewLabel.font = UIFont.boldSystemFont(ofSize: 20)
        overViewLabel.textColor = .black
    }
    
    private func convertDateFormat(sourceDateString : String, sourceDateFormat : String, destinationFormat : String) -> String{

        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = sourceDateFormat;

        if let date = dateFormatter.date(from: sourceDateString){
            dateFormatter.dateFormat = destinationFormat;
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}

extension MovieDetailsViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieDetailsModel.crewMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CrewCollectionViewCell.cellIdentifier,
            for: indexPath) as? CrewCollectionViewCell {
            let crewMember = movieDetailsModel.crewMembers[indexPath.row]
            cell.configure(name: crewMember.name, position: crewMember.role)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}


