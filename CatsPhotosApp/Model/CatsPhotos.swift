//
//  CatsPhotos.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 02.10.2021.
//

import Foundation

struct CatsPhotos {
	let url: URL
	let name: String
	let breed: String
	let height, width: Int

	init?(catsPhotosData: CatsPhotosData) {
		self.url = catsPhotosData.url
		self.breed = catsPhotosData.breeds[0].name
		self.name = catsPhotosData.id
		self.width = catsPhotosData.width
		self.height = catsPhotosData.height
	}
}
