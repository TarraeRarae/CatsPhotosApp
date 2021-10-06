//
//  SecondViewController.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 25.09.2021.
//

import UIKit

class FavoriteViewController: UIViewController {

	private var tableView: UITableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.title = "Favorites"
		setupTableView()
	}

	func setupTableView() {
		tableView = UITableView(frame: view.bounds, style: .plain)
		tableView.register(UINib(nibName: CatsTableViewCell.Constant.nibName, bundle: nil), forCellReuseIdentifier: CatsTableViewCell.Constant.cellID)
		tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		tableView.separatorStyle = .none
		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)
	}
}

extension FavoriteViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
						withIdentifier: CatsTableViewCell.Constant.cellID,
					for: indexPath) as? CatsTableViewCell else {
			fatalError("Unable to dequeue reusable cell")
		}
		return cell
	}

}

extension FavoriteViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CatsTableViewCell.Constant.rowHeight
	}

}
