//
//  CatsPhotosData.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 02.10.2021.
//

import Foundation

struct CatsPhotosData: Codable {
	let breeds: [Breed]
	let id: String
	let url: URL
	let width, height: Int
}

struct Breed: Codable {
	let id, name: String
}
