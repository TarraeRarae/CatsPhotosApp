//
//  ViewController.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 25.09.2021.
//

import UIKit

class SearchViewController: UIViewController {
	private let tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.title = "Random cats"
	}
}
