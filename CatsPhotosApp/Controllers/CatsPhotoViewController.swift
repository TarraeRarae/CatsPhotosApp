//
//  CatsPhotoViewController.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 03.10.2021.
//

import UIKit

class CatsPhotoViewController: UIViewController {

	private var currentCatPhotoData: CatsPhotos
	private var breedLabel: UILabel = UILabel()
	private var catImageView: UIImageView = UIImageView()
	private var favoriteButton: UIButton = UIButton()
	private var scroll: UIScrollView = UIScrollView(frame: UIScreen.main.bounds)
	private var multiplier: CGFloat = CGFloat()

	init(_ currentCatPhotoData: CatsPhotos) {
		self.currentCatPhotoData = currentCatPhotoData
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.title = currentCatPhotoData.name
		multiplier = CGFloat(currentCatPhotoData.height) / CGFloat(currentCatPhotoData.width)
		
		scroll.alwaysBounceVertical = false
		scroll.isScrollEnabled = true
		view.addSubview(scroll)

		setupCatImageView()
		setupBreedLabel()
		setupFavoriteButton()
		setupConstraints()
	}

	override func viewWillLayoutSubviews() {
		scroll.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
	}

	func setupBreedLabel() {
		breedLabel.text = "Breed:\n- \(currentCatPhotoData.breed)"
		breedLabel.numberOfLines = 2
		breedLabel.textAlignment = .left
		breedLabel.font = UIFont(name: "Times New Roman", size: 30)
		scroll.addSubview(breedLabel)
	}

	func setupCatImageView() {
		let task = URLSession.shared.dataTask(with: currentCatPhotoData.url) { (data, _, error) in
			guard error == nil,
						let dataActual = data,
						let image = UIImage(data: dataActual)
			else {
					return
			}
			DispatchQueue.main.async {
				self.catImageView.image = image
			}
		}
		task.resume()
		catImageView.contentMode = .scaleAspectFit
		scroll.addSubview(catImageView)
	}

	func setupFavoriteButton() {
		favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
		favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .selected)
		favoriteButton.contentHorizontalAlignment = .fill
		favoriteButton.contentVerticalAlignment = .fill
		favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		scroll.addSubview(favoriteButton)
	}

	func setupConstraints() {
		setCatImageViewConstraints()
		setFavoriteButtonConstraints()
		setBreedLabelConstraints()
	}

	func setBreedLabelConstraints() {
		breedLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			breedLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 10),
			breedLabel.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 42),
			breedLabel.heightAnchor.constraint(equalTo: scroll.heightAnchor, multiplier: 0.3),
			breedLabel.widthAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: 0.8)
		])
	}

	func setCatImageViewConstraints() {
		catImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			catImageView.topAnchor.constraint(equalTo: scroll.topAnchor),
			catImageView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
			catImageView.widthAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: 1),
			catImageView.heightAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: multiplier)
		])
	}

	func setFavoriteButtonConstraints() {
		favoriteButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			favoriteButton.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 20),
			favoriteButton.leadingAnchor.constraint(equalTo: scroll.safeAreaLayoutGuide.leadingAnchor, constant: 42),
			favoriteButton.heightAnchor.constraint(equalTo: scroll.heightAnchor, multiplier: 0.05),
			favoriteButton.widthAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: 0.15)
		])
	}

}

extension CatsPhotoViewController: UIScrollViewDelegate {

	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return catImageView
	}

}
