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
	let width: Int
	let height: Int

	init?(catsPhotosData: CatsPhotosData) {
		self.url = catsPhotosData.url
		self.name = catsPhotosData.id
		self.breed = catsPhotosData.breeds[0].name
		self.width = catsPhotosData.width
		self.height = catsPhotosData.height
	}
}
