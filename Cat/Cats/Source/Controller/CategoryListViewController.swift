//
//  CategoryListViewController.swift
//  Assignment3
//
//  Created by Charles Augustine on 7/9/15.
//
//


import UIKit


class CategoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
	// MARK: UITableViewDataSource
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) 
		cell.textLabel!.text = categories[indexPath.row].title
		cell.detailTextLabel!.text = categories[indexPath.row].subtitle

		return cell
	}

	// MARK: UISearchBarDelegate
	func searchBarCancelButtonClicked(searchBar: UISearchBar) {
		self.view.endEditing(true)
	}

	// MARK: Private
	private func registerForNotifications() {
		unregisterForNotifications()

		let notificationCenter = NSNotificationCenter.defaultCenter()
		observerTokens.append(notificationCenter.addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification) -> Void in
			self.categoryTable.adjustInsetsForWillShowKeyboardNotification(notification)
		}))
		observerTokens.append(notificationCenter.addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification) -> Void in
			self.categoryTable.adjustInsetsForWillHideKeyboardNotification(notification)
		}))
	}

	private func unregisterForNotifications() {
		for token in observerTokens {
			NSNotificationCenter.defaultCenter().removeObserver(token)
		}
		observerTokens.removeAll(keepCapacity: false)
	}

	// MARK: View Management
	override func viewWillAppear(animated: Bool) {
		if let selectedIndexPath = categoryTable.indexPathForSelectedRow {
			categoryTable.deselectRowAtIndexPath(selectedIndexPath, animated: false)
		}


	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		switch segue.identifier {
		case .Some("CatImagesSegue"):
			if let selectedRow = categoryTable.indexPathForSelectedRow?.row, let imageNames = CatService.sharedCatService.imageNamesForCategory(categories[selectedRow].title) {
				let catImagesViewController = segue.destinationViewController as! CatImagesViewController
				catImagesViewController.imageNames = imageNames
			}
		default:
			super.prepareForSegue(segue, sender: sender)
		}
	}

	// MARK: View Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()

		registerForNotifications()
	}

	// MARK: Deinit
	deinit {
		unregisterForNotifications()
	}

	// MARK: Properties (Private)
	private var observerTokens = Array<AnyObject>()
	private var categories = CatService.sharedCatService.catCategories()

	// MARK: Properties (IBOutlet)
	@IBOutlet private weak var categoryTable: UITableView!
}

