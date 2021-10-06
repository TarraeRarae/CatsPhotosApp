//
//  UploadViewController.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 26.09.2021.
//

import UIKit

class UploadViewController: UIViewController {

	private var tableView: UITableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.title = "Upload"
		setupTableView()
	}

	func setupTableView() {
		tableView = UITableView(frame: view.bounds, style: .plain)
		tableView.register(UINib(nibName: CatsTableViewCell.Constant.nibName, bundle: nil), forCellReuseIdentifier: CatsTableViewCell.Constant.cellID)
		tableView.separatorStyle = .none
		tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)
	}
}

extension UploadViewController: UITableViewDataSource {

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

extension UploadViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CatsTableViewCell.Constant.rowHeight
	}

}
