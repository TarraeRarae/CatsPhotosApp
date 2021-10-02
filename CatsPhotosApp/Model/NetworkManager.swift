//
//  File.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 02.10.2021.
//

import Foundation

protocol NetworkCatsManagerDelegate: class {
	func updateInterface(_: NetworkManager, with catsPhotosArray: [CatsPhotos])
}

class NetworkManager {
	weak var delegate: NetworkCatsManagerDelegate?

	func getImageWithFilter(_ breed: String) {
		let urlString = "https://api.thecatapi.com/v1/images/search?breed_ids=\(breed)&limit=10&page=1&api_key=\(Constants.keyAPI)"
		guard let url = URL(string: urlString) else { return }
		let session = URLSession(configuration: .default)
		let task = session.dataTask(with: url) { (data, _, _) in
			if let data = data {
				if let catsPhotosArray = self.parseJSON(with: data) {
					self.delegate?.updateInterface(self, with: catsPhotosArray)
				}
			}
		}
		task.resume()
	}

	func parseJSON(with data: Data) -> [CatsPhotos]? {
		let decoder: JSONDecoder = JSONDecoder()
		do {
			let catsPhotosData = try decoder.decode([CatsPhotosData].self, from: data)
			var catsPhotosArray: [CatsPhotos] = []
			for item in catsPhotosData {
				guard let catsPhotos = CatsPhotos(catsPhotosData: item) else { continue }
				catsPhotosArray.append(catsPhotos)
			}
			return catsPhotosArray
		} catch let error as NSError {
			print(String(describing: error))
		}
		return nil
	}
}
