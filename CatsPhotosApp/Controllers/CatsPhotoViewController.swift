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
		setupCatImageView()
		setupBreedLabel()
		setupFavoriteButton()
		setupConstraints()
	}

	func setupBreedLabel() {
		breedLabel.text = currentCatPhotoData.breed
		breedLabel.textAlignment = .left
		breedLabel.font = UIFont(name: "Times New Roman", size: 30)
		view.addSubview(breedLabel)
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
		view.addSubview(catImageView)
	}

	func setupFavoriteButton() {
		favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
		favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .selected)
		favoriteButton.contentHorizontalAlignment = .fill
		favoriteButton.contentVerticalAlignment = .fill
		favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		view.addSubview(favoriteButton)
	}
//	func makeImageFavorite() {
//
//	}
	func setupConstraints() {
		setBreedLabelConstraints()
		setCatImageViewConstraints()
		setFavoriteButtonConstraints()
	}

	func setBreedLabelConstraints() {
		breedLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			breedLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 10),
			breedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 42),
			breedLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
			breedLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
		])
	}

	func setCatImageViewConstraints() {
		catImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			catImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			catImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 42),
			catImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
			catImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
		])
	}

	func setFavoriteButtonConstraints() {
		favoriteButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			favoriteButton.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 20),
			favoriteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 42),
			favoriteButton.heightAnchor.constraint(equalTo: catImageView.heightAnchor, multiplier: 0.1),
			favoriteButton.widthAnchor.constraint(equalTo: catImageView.widthAnchor, multiplier: 0.15)
		])
	}
}
