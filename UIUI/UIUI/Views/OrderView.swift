//
//  OrderView.swift
//  UIUI
//
//  Created by Victor Leal on 08/07/20.
//  Copyright © 2020 Roadmapps. All rights reserved.
//

import SwiftUI

struct OrderView : View {
	@EnvironmentObject var order: Order
	
	var body: some View {
		NavigationView {
			List {
				Section {
					ForEach(order.items) { item in
						HStack {
							Text(item.name)
							Spacer()
							Text("$3.00")
						}
					}.onDelete(perform: deleteItems)
				}
				
				Section {
					NavigationLink(destination: CheckOut()) {
						Text("Place Order")
						
					}.disabled(order.items.isEmpty)
				}
			}
			.navigationBarTitle("Order")
			.listStyle(GroupedListStyle())
		}
	}
	
	func deleteItems(at offsets: IndexSet) {
		order.items.remove(atOffsets: offsets)
	}
}

struct CheckOut : View {
	
	@EnvironmentObject var order: Order
	
	static let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
	@State private var paymentType = 0
	
	@State private var addLoyaltyDetails = false
	@State private var loyaltyNumber = ""
	
	static let tipAmounts = [10, 15, 20, 25, 0]
	@State private var tipAmount = 1
	
	@State private var showingPaymentAlert = false
	
	var totalPrice: Double {
		let total = Double(order.total)
		let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
		return total + tipValue
	}
	
	var body: some View {
		List {
			Section {
				Picker("How do you want to pay?", selection: $paymentType) {
					ForEach(0 ..< Self.paymentTypes.count) {
						Text(Self.paymentTypes[$0])
					}
				}
			}
			Section {
				Toggle(isOn: $addLoyaltyDetails.animation()) {
					Text("Add iDine loyalty card")
				}
				if addLoyaltyDetails {
					TextField("Enter your iDine ID", text: $loyaltyNumber)
				}
			}
			Section(header: Text("Add a tip?")) {
				Picker("Percentage:", selection: $tipAmount) {
					ForEach(0 ..< Self.tipAmounts.count) {
						Text("\(Self.tipAmounts[$0])%")
					}
				}.pickerStyle(SegmentedPickerStyle())
			}
			Section(header:
				Text("TOTAL: $\(totalPrice, specifier: "%.2f")")
				.font(.largeTitle)
			) {
				Button("Confirm order") {
					self.showingPaymentAlert.toggle()
				}
			}
			
		}
		.navigationBarTitle(Text("Payment"), displayMode: .inline)
		.alert(isPresented: $showingPaymentAlert) {
			Alert(title: Text("Order confirmed"), message: Text("Your total was $\(totalPrice, specifier: "%.2f") – thank you!"), dismissButton: .default(Text("OK")))
		}
	}
	

}
