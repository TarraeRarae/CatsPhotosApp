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
	private var scrollView: UIScrollView = UIScrollView(frame: UIScreen.main.bounds)
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

		scrollView.alwaysBounceVertical = true
		scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.addSubview(scrollView)

		favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
		favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .selected)
		favoriteButton.contentHorizontalAlignment = .fill
		favoriteButton.contentVerticalAlignment = .fill
		favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		scrollView.addSubview(favoriteButton)

		breedLabel.text = "Breed:\n- \(currentCatPhotoData.breed)"
		breedLabel.numberOfLines = 10
		breedLabel.textAlignment = .left
		breedLabel.font = UIFont(name: "Times New Roman", size: 30)
		scrollView.addSubview(breedLabel)

		multiplier = CGFloat(currentCatPhotoData.height) / CGFloat(currentCatPhotoData.width)

		setupCatImageView()
		setupConstraints()

		scrollView.layoutIfNeeded()
	}

	override func viewWillAppear(_ animated: Bool) {
		scrollView.contentSize = CGSize(width: scrollView.frame.width, height: breedLabel.frame.maxY)
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
		scrollView.addSubview(catImageView)
	}

	func setupConstraints() {
		setCatImageViewConstraints()
		setFavoriteButtonConstraints()
		setBreedLabelConstraints()
	}

	func setCatImageViewConstraints() {
		catImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			catImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			catImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			catImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
			catImageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: multiplier)
		])
	}

	func setFavoriteButtonConstraints() {
		favoriteButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			favoriteButton.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 20),
			favoriteButton.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 42),
			favoriteButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.15)
		])
		var screenSizeMultiplier: CGFloat = 0
		if round(Double(UIScreen.main.bounds.height) / Double(UIScreen.main.bounds.width), toNearest: 0.01) == round(16.0 / 9.0, toNearest: 0.01) {
			screenSizeMultiplier = 0.06
		} else {
			screenSizeMultiplier = 0.05
		}
		favoriteButton.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: screenSizeMultiplier).isActive = true
	}

	func setBreedLabelConstraints() {
		breedLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			breedLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 10),
			breedLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 42),
			breedLabel.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.3),
			breedLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8)
		])
	}

}

extension CatsPhotoViewController {
	func round(_ value: Double, toNearest: Double) -> Double {
		return UIKit.round(value / toNearest) * toNearest
	}
}
