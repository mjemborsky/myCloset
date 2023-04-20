//
//  SelectedItemsManager.swift
//  myCloset
//
//  Created by Taylor  on 4/17/23.
//

import SwiftUI
import Foundation

class SelectedItemsManager: ObservableObject {
    @Published var selectedItems: [ClothingItem] = []
}
