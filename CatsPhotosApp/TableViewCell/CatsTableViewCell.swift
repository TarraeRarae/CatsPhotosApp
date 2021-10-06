//
//  TableCell.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 26.09.2021.
//

import UIKit

class CatsTableViewCell: UITableViewCell {

	struct Constant {

		static let rowHeight: CGFloat = 250.0
		static let cellID: String = "CatsTableViewCellID"
		static let nibName: String = "CatsTableViewCell"

	}

	@IBOutlet private var cellImageView: UIImageView?

	override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = .white
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		self.cellImageView?.image = nil
	}

	func setImage(_ image: UIImage?) {
		cellImageView?.image = image
	}
}

struct TableCellData {

	static var arrayOfCatsData: [CatsPhotos] = []

}
