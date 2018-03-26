//
//  CatService.swift
//  Assignment3
//
//  Created by Charles Augustine on 7/9/15.
//
//


import Foundation


class CatService {
	// MARK: Service
	func catCategories() -> Array<(title: String, subtitle: String)> {
		return [("Burmese", "Contains \(burmeseCats.count) images"), ("Savannah", "Contains \(savannahCats.count) images"), ("Ragdoll", "Contains \(ragdollCats.count) images"), ("Himalayan", "Contains \(himalayanCats.count) images"), ("Scottish Fold", "Contains \(scottishFoldCats.count) images")]
	}

	func imageNamesForCategory(category: String) -> Array<String>? {
		let result: Array<String>?
		switch category {
		case "Burmese":
			result = burmeseCats
		case "Savannah":
			result = savannahCats
		case "Ragdoll":
			result = ragdollCats
		case "Himalayan":
			result = himalayanCats
		case "Scottish Fold":
			result = scottishFoldCats
		default:
			result = nil
		}

		return result
	}

	// MARK: Initialization
	private init() {
		burmeseCats = ["burmese1", "burmese2", "burmese3"]
		savannahCats = ["savannah1", "savannah2", "savannah3", "savannah4", "savannah5"]
		ragdollCats = ["ragdoll1", "ragdoll2", "ragdoll3", "ragdoll4"]
		himalayanCats = ["himalayan1"]
		scottishFoldCats = ["scottishFold1", "scottishFold2"]
	}

	// MARK: Properties (Private)
	private let burmeseCats: Array<String>
	private let savannahCats: Array<String>
	private let ragdollCats: Array<String>
	private let himalayanCats: Array<String>
	private let scottishFoldCats: Array<String>

	// MARK: Properties (Static)
	static let sharedCatService = CatService()
}