//
//  File.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 02.10.2021.
//

import Foundation

struct NetworkManager {
	func getImageWithFilter(_ breed: String) {
		let urlString = "https://api.thecatapi.com/v1/images/search?breed_ids=\(breed)&api_key=\(Constants.keyAPI)"
		guard let url = URL(string: urlString) else { return }
		let session = URLSession(configuration: .default)
		let task = session.dataTask(with: url) { (data, response, error) in
			if let data = data {
				
			}
		}
		task.resume()
	}
}
