//
//  TableCell.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 26.09.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
	@IBOutlet private var cellImageView: UIImageView?

	override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = .white
	}
	override func prepareForReuse() {
		super.prepareForReuse()
		self.cellImageView = nil
	}
	func setImage(_ image: UIImage?) {
			cellImageView?.image = image
	}
}

struct TableCellData {
	static var arrayOfCatsData: [CatsPhotos] = []
}
