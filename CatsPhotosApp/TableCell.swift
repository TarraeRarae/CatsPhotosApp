//
//  TableCell.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 26.09.2021.
//

import UIKit

class TableCell: UITableViewCell {
	@IBOutlet private var cellImage: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = .white
	}
	override func prepareForReuse() {
			super.prepareForReuse()
			cellImage.image = nil
	}

	func setImage(_ image: UIImage?) {
		cellImage.image = image
	}
}
