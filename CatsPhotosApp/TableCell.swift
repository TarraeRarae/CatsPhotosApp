//
//  TableCell.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 26.09.2021.
//

import UIKit

class TableCell: UITableViewCell {
	@IBOutlet private var cellLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = .white
		cellLabel.textAlignment = .center
	}
	override func prepareForReuse() {
		super.prepareForReuse()
		cellLabel.text = ""
	}
	func setText(_ text: String) {
		cellLabel.text = text
	}
}

struct TableCellContent {
	static let arrayOfTexts = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
}
