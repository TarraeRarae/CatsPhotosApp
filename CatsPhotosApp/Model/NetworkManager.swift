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

	struct Constant {

		static let keyAPI: String = "a02aa90b-4743-4822-a934-85f4d3d74de5"

	}

	weak var delegate: NetworkCatsManagerDelegate?

	func getImageWithFilter(_ breed: String) {
		let urlString = "https://api.thecatapi.com/v1/images/search?api_key=\(NetworkManager.Constant.keyAPI)&sub_id=\(UserDefaults.standard.string(forKey: "subID")!)&breed_ids=\(breed)&limit=10&page=1"
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
