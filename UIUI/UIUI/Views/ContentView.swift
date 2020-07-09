//
//  ContentView.swift
//  UIUI
//
//  Created by Victor Leal on 03/07/20.
//  Copyright © 2020 Roadmapps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	
	let menu: [MenuItem] = [
		MenuItem(id: "1", name: "Dale 1", image: #imageLiteral(resourceName: "222"), restrictions: ["D", "G", "V"], description: "Um texto massa que é pra tá aqui"),
		MenuItem(id: "2", name: "Dale 2", image: #imageLiteral(resourceName: "333"),  restrictions: ["D", "N", "S"], description: "Um texto massa que é pra tá aqui"),
		MenuItem(id: "3", name: "Dale 3", image: #imageLiteral(resourceName: "222"),  restrictions: ["D", "G", "N", "S", "V"], description: "Um texto massa que é pra tá aqui")
	]
	
	var sectionItem: [SectionItem] = [
		SectionItem(id: "1",
					name: "Coisas da hora",
					items:  [
						MenuItem(id: "1", name: "Dale 1", image: #imageLiteral(resourceName: "222"), restrictions: ["D","S"], description: "Um texto massa que é pra tá aqui"),
						MenuItem(id: "2", name: "Dale 2", image: #imageLiteral(resourceName: "333"),  restrictions: ["D", "G", "N"], description: "Um texto massa que é pra tá aqui"),
						MenuItem(id: "3", name: "Dale 3", image: #imageLiteral(resourceName: "222"),  restrictions: ["D", "G", "N", "S", "V"], description: "Um texto massa que é pra tá aqui")
		]),
		SectionItem(id: "2",
					name: "Coisas legais",
					items:  [
						MenuItem(id: "1", name: "Dale 1", image: #imageLiteral(resourceName: "222"), restrictions: ["D"], description: "Um texto massa que é pra tá aqui"),
						MenuItem(id: "2", name: "Dale 2", image: #imageLiteral(resourceName: "333"),  restrictions: ["D"], description: "Um texto massa que é pra tá aqui"),
						MenuItem(id: "3", name: "Dale 3", image: #imageLiteral(resourceName: "222"),  restrictions: ["D", "G", "N", "S", "V"], description: "Um texto massa que é pra tá aqui")
		])]
		
	var body: some View {
		NavigationView {
			List {
				ForEach(self.sectionItem) {itemS in
					ItemSection(itemS: itemS)
				}
				.navigationBarTitle("Menu")
				.listStyle(GroupedListStyle())
			}
		}
		
	}
	
	
}

struct ItemSection: View {
	var itemS: SectionItem
	
	var body: some View {
		Section(header: Text(itemS.name)){
			ForEach(itemS.items) {item in
				ItemRow(item: item)
			}
		}
	}
}


struct ItemRow: View {
	var item: MenuItem
	static let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
	
	var body: some View {
		NavigationLink(destination: ItemDetail(item: item)) {
			HStack {
				Image(uiImage: item.image)
					.resizable()
					.frame(width: 100, height: 100)
				HStack {
					VStack {
						Text(item.name).foregroundColor(Color.blue).font(.headline)
						Text("ID: " + item.id)
					}
					Spacer()
					ForEach(item.restrictions, id: \.self) { restriction in
						Text(restriction)
							.font(.caption)
							.fontWeight(.black)
							.padding(5)
							.background(Self.colors[restriction, default: .black])
							.clipShape(Circle())
							.foregroundColor(.white)
							.layoutPriority(1)
					}
				}
			}
		}
	}
	
}

struct ItemDetail: View {
	@EnvironmentObject var order: Order
	
	var item: MenuItem
	
	var body: some View {
		VStack {
			ZStack (alignment: .bottomTrailing){
				Image(uiImage: item.image)
					.resizable()
				Text("Foto: Dale Dale")
				.padding(4)
				.background(Color.black)
				.font(.caption)
				.foregroundColor(.yellow)
				.offset(x: -5, y: -5)
			}
			Text(item.description)
			Button("Order This") {
				self.order.add(item: self.item)
			}.font(.headline)
			Spacer()
		}
		.navigationBarTitle(Text(item.name), displayMode: .inline)
	}
}



