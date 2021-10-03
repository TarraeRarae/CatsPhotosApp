//
//  ViewController.swift
//  CatsPhotosApp
//
//  Created by TarraeRarae on 25.09.2021.
//

import UIKit

class SearchViewController: UIViewController {

	private var tableView: UITableView = UITableView()
	private var network: NetworkManager = NetworkManager()
	private var tasks: [URLSessionDataTask] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationItem.title = "Random cats"
		network.delegate = self
		network.getImageWithFilter("beng")
		setupTableView()
	}

	func setupTableView() {
		tableView = UITableView(frame: view.bounds, style: .plain)
		tableView.register(UINib(nibName: Constants.nibName, bundle: nil), forCellReuseIdentifier: Constants.cellID)
		tableView.separatorStyle = .none
		tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)
	}

	deinit {
			tasks.forEach({
					$0.cancel()
			})
	}

}

extension SearchViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return TableCellData.arrayOfCatsData.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
						withIdentifier: Constants.cellID,
						for: indexPath) as? TableViewCell else {
			fatalError("Unable to dequeue reusable cell")
		}
		let task = URLSession.shared.dataTask(with: TableCellData.arrayOfCatsData[indexPath.row].url) { (data, _, error) in
			guard error == nil,
						let dataActual = data,
						let image = UIImage(data: dataActual)
			else {
				return
			}
			DispatchQueue.main.async {
				cell.setImage(image)
			}
		}
		tasks.append(task)
		task.resume()
		return cell
	}

}

extension SearchViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return Constants.rowHeight
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let catPhotoVC = CatsPhotoViewController(TableCellData.arrayOfCatsData[indexPath.row])
		show(catPhotoVC, sender: nil)
	}

}

extension SearchViewController: NetworkCatsManagerDelegate {

	func updateInterface(_: NetworkManager, with catsPhotosArray: [CatsPhotos]) {
		TableCellData.arrayOfCatsData = catsPhotosArray
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

}
