import PureLayout
import UIKit
import Kingfisher
import Combine

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
    private var viewModel: MovieDetailsViewModel!
    private var disposeables = Set<AnyCancellable>()
    private var movieDetails: MovieDetails = MovieDetails()
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        buildViews()
//        prepareAnimation()
        
        viewModel.getMovieDetails()
        
        viewModel
            .$movieDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movie in
                guard let self = self else { return }
                self.movieDetails = movie
                self.buildViews()
                self.prepareAnimation()
            }
            .store(in: &disposeables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performAnimation()
    }
    
    private func prepareAnimation() {
        titleLabel.transform = titleLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        ratingLabel.transform = ratingLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        userScoreLabel.transform = userScoreLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        releaseYearLabel.transform = releaseYearLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        dateLabel.transform = dateLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        categoriesLabel.transform = categoriesLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        durationLabel.transform = durationLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        descriptionLabel.transform = descriptionLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        collectionView.alpha = 0
    }
    
    private func performAnimation() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            animations: {
                self.titleLabel.transform = .identity
                self.ratingLabel.transform = .identity
                self.userScoreLabel.transform = .identity
                self.releaseYearLabel.transform = .identity
                self.dateLabel.transform = .identity
                self.categoriesLabel.transform = .identity
                self.durationLabel.transform = .identity
                self.descriptionLabel.transform = .identity
            }, completion: { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.3,
                    animations: {
                        self.collectionView.alpha = 1
                    })
            })
    }
    
    private func buildViews() {
        createViews()
        layoutViews()
        styleViews()
    }
    
    private func createViews() {
        movieImageView = UIImageView()
        let url = URL(string: viewModel.movieDetails.imageUrl)
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
        movieImageView.autoSetDimension(.height, toSize: 278)
        
        userScoreLabel = UILabel()
        
        H1StackView.addArrangedSubview(ratingLabel)
        H1StackView.addArrangedSubview(userScoreLabel)
        movieImageView.addSubview(H1StackView)
        
        H1StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        H1StackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 90)
        
        let H2StackView = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel])
        H2StackView.spacing = 8
        
        movieImageView.addSubview(H2StackView)
        
        H2StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        H2StackView.autoPinEdge(.top, to: .bottom, of: H1StackView, withOffset: 16)
        H2StackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20, relation: .greaterThanOrEqual)
        
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
        ratingLabel.text = String(viewModel.movieDetails.rating)
        userScoreLabel.text = "User score"
        
        H1StackView.spacing = 8

        titleLabel.text = viewModel.movieDetails.name
        
        releaseYearLabel.text = "(" + "\(viewModel.movieDetails.year)" + ")"
        
        let stringCategories = viewModel.movieDetails.categories.map {
            categorie in "\(categorie)"
        }.joined(separator: ",")
        categoriesLabel.text = stringCategories
        
        let hours = viewModel.movieDetails.duration / 60
        let minutes = viewModel.movieDetails.duration - hours*60
        durationLabel.text = "\(hours)" + "h " + "\(minutes)" + "m"
        
        let newDateFormat = convertDateFormat(sourceDateString: viewModel.movieDetails.releaseDate, sourceDateFormat: "yyyy-MM-dd", destinationFormat: "dd/MM/yyyy")
        dateLabel.text = newDateFormat + " (US)"
        
        overViewLabel.text = "Overview"
        
        descriptionLabel.text = viewModel.movieDetails.summary
        
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
        viewModel.movieDetails.crewMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CrewCollectionViewCell.cellIdentifier,
            for: indexPath) as? CrewCollectionViewCell {
            let crewMember = viewModel.movieDetails.crewMembers[indexPath.row]
            cell.configure(name: crewMember.name, position: crewMember.role)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}


