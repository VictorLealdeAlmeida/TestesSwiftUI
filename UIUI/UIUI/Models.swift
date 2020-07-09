//
//  Models.swift
//  UIUI
//
//  Created by Victor Leal on 07/07/20.
//  Copyright © 2020 Roadmapps. All rights reserved.
//

import SwiftUI

struct MenuItem: Identifiable {
	let id: String
	let name: String
	let image: UIImage
	let restrictions: [String]
	let description: String
}

struct SectionItem: Identifiable {
	let id: String
	let name: String
	let items: [MenuItem]
}

class Order: ObservableObject {
	@Published var items = [MenuItem]()
	
	func add(item: MenuItem){
		items.append(item)
	}
	
	func remove(item: MenuItem){
		for (i, itemL) in items.enumerated(){
			if itemL.id == item.id{
				items.remove(at: i)
			}
		}
	}
	
	var total: Int{
		var value = 0
		for _ in items{
			value = value + 3
		}
		return value
	}
}
