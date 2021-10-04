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
	private var scrollView: UIScrollView = UIScrollView()

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

	func setupScrollView() {
		scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		scrollView.addSubview(catImageView)
	}

	func setupBreedLabel() {
		breedLabel.text = currentCatPhotoData.breed
//		breedLabel.frame = CGRect(
//			x: Double(view.bounds.width) * 0.15,
//			y: Double(view.bounds.height) * 0.75,
//			width: Double(view.bounds.width) * 0.5,
//			height: 50
//		)
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
		favoriteButton.frame = CGRect(
			x: Double(view.bounds.width) * 0.15,
			y: Double(view.bounds.height) * 0.5,
			width: 70,
			height: 70
		)
		favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
		favoriteButton.contentHorizontalAlignment = .fill
		favoriteButton.contentVerticalAlignment = .fill
		favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 6, bottom: 10, right: 10)

		view.addSubview(favoriteButton)
	}
	func setupConstraints() {
		setBreedLabelConstraints()
		setCatImageViewConstraints()
	}

	func setBreedLabelConstraints() {
		breedLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			breedLabel.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 100),
			breedLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			breedLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 42),
			breedLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
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
}
