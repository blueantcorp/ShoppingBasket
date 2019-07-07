//	MIT License
//
//	Copyright © 2019 Emile, Blue Ant Corp
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.
//
//	ID: 33781857-C3CC-4BC1-8DE6-C7E896E6A4C3
//
//	Pkg: ShoppingBasket
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class BasketController: UITableViewController {
	
	// Model
	private var model = BasketViewModel.shared
	
	// Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tableView.reloadData()
	}
}

// MARK: - UI
extension  BasketController {
	private func setupView() {
		title = "Basket"
		tableView = UITableView(frame: CGRect.zero, style: .grouped)
		tableView.register(GenericCell.self, forCellReuseIdentifier: GenericCell.identifier)
		tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
		tableView.separatorStyle = .none
		tableView.contentInsetAdjustmentBehavior = .automatic
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 70
	}
}

// MARK: - UITableViewDataSource
extension BasketController {
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return BasketViewModel.Section.all.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let section = BasketViewModel.Section(rawValue: section) else {
			return 0
		}
		return section.rows
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let section = BasketViewModel.Section.all[indexPath.section]
		
		if let row = section.caseForRow(row: indexPath.row) {
		   let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath)
			cell.accessoryType = row.accessoryType
			cell.selectionStyle = row.selectionStyle
			cell.textLabel?.text = row.title
			cell.detailTextLabel?.text = row.detail
			cell.detailTextLabel?.textColor = row.detailColor
			
			if let cell = cell as? ProductCell {
				cell.configure(model.basket[indexPath.row])
			}
			
			return cell
		}
		return UITableViewCell(style: .value1, reuseIdentifier: nil)
	}
}
