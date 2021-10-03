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
		setupBreedLabel()
		setupCatImageView()
	}
	func setupBreedLabel() {
		breedLabel.text = currentCatPhotoData.breed
		breedLabel.frame = CGRect(
			x: Double(view.bounds.width) * 0.15,
			y: Double(view.bounds.height) * 0.75,
			width: Double(view.bounds.width) * 0.5,
			height: 50
		)
		view.addSubview(breedLabel)
	}
	func setupCatImageView() {
		catImageView.frame = CGRect(
			x: Double(view.bounds.width) * 0.1,
			y: Double(view.bounds.height) * 0.15,
			width: Double(view.bounds.width) * 0.8,
			height: Double(view.bounds.width) * 0.8
		)
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
}
