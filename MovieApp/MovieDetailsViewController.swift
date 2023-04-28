
import PureLayout
import UIKit
import MovieAppData

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
    private var detailsLabel: MovieDetailsModel = {
        guard let details = MovieUseCase().getDetails(id: 111161) else {
            fatalError("Could not get movie Info!")
        }
        return details
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        createAndLayoutViews()
        styleViews()
    }
    
    private func createAndLayoutViews() {
        
        let movieImage = UIImage(named: "movieDetails")
        movieImageView = UIImageView(image: movieImage)
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        
        view.addSubview(movieImageView)
        
        movieImageView.autoPinEdge(toSuperviewEdge: .leading)
        movieImageView.autoPinEdge(toSuperviewEdge: .trailing)
        movieImageView.autoPinEdge(toSuperviewEdge: .top)
        movieImageView.autoSetDimension(.height, toSize: 327)
        
        ratingLabel = UILabel()
        ratingLabel.text = String(detailsLabel.rating)
        
        userScoreLabel = UILabel()
        userScoreLabel.text = "User score"
        
        let H1StackView = UIStackView(arrangedSubviews: [ratingLabel, userScoreLabel])
        
        movieImageView.addSubview(H1StackView)
        
        H1StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        H1StackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 90)
        H1StackView.spacing = 8

        titleLabel = UILabel()
        titleLabel.text = detailsLabel.name
        
        releaseYearLabel = UILabel()
        releaseYearLabel.text = "(" + "\(detailsLabel.year)" + ")"
        
        let H2StackView = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel])
        
        movieImageView.addSubview(H2StackView)
        
        H2StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        H2StackView.autoPinEdge(.top, to: .bottom, of: H1StackView, withOffset: 16)
        H2StackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        categoriesLabel = UILabel()
        let stringCategories = detailsLabel.categories.map {
            categorie in "\(categorie)"
        }.joined(separator: ",")
        categoriesLabel.text = stringCategories
        
        durationLabel = UILabel()
        let hours = detailsLabel.duration / 60
        let minutes = detailsLabel.duration - hours*60
        durationLabel.text = String(hours) + "h " + String(minutes) + "m"
        
        dateLabel = UILabel()
        let newDateFormat = convertDateFormat(sourceDateString: detailsLabel.releaseDate, sourceDateFormat: "yyyy-MM-dd", destinationFormat: "dd/MM/yyyy")
        dateLabel.text = newDateFormat + " (US)"
        
        movieImageView.addSubview(dateLabel)
        
        dateLabel.autoPinEdge(.top, to: .bottom, of: H2StackView, withOffset: 16)
        dateLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        
        let H3StackView = UIStackView(arrangedSubviews: [categoriesLabel, durationLabel])
        
        movieImageView.addSubview(H3StackView)
        
        H3StackView.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 0)
        H3StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        H3StackView.spacing = 8
        
        let starIconImage = UIImage(named: "starIcon")
        starIconImageView = UIImageView(image: starIconImage)
        starIconImageView.contentMode = .scaleAspectFill
        
        movieImageView.addSubview(starIconImageView)
        
        starIconImageView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        starIconImageView.autoPinEdge(.top, to: .bottom, of: H3StackView, withOffset: 16)
        starIconImageView.autoSetDimension(.height, toSize: 32)
        
        overViewLabel = UILabel()
        overViewLabel.text = "Overview"
        
        view.addSubview(overViewLabel)
        
        overViewLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        overViewLabel.autoPinEdge(.top, to: .bottom, of: movieImageView, withOffset: 22)
        
        descriptionLabel = UILabel()
        descriptionLabel.text = detailsLabel.summary
        
        view.addSubview(descriptionLabel)
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: overViewLabel, withOffset: 16)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize(width: (width / 3) - 32, height: 50)
        collectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: view.bounds.height),
            collectionViewLayout: flowLayout)
        
        view.addSubview(collectionView)
        
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        collectionView.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 27)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func styleViews() {
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
        detailsLabel.crewMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyCollectionViewCell.cellIdentifier,
            for: indexPath) as! MyCollectionViewCell
        
        let crewMember = detailsLabel.crewMembers[indexPath.row]
        cell.configure(name: crewMember.name, position: crewMember.role)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / 3) - 32, height: 50)
    }

}


