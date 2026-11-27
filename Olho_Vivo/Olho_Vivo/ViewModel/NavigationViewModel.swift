//
//  NavigationViewModel.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

import Foundation
import SwiftUI

@Observable
class NavigationViewModel {
    var searchText = ""
    var isSearchSubmitted = false
    
    var isSearchSheetPresented = true
    var searchDetent: PresentationDetent = .height(100)
    
    var isSelectionSheetPresented = false
    var selectionDetent: PresentationDetent = .height(100)
    var shouldDismissSelection = false
    
    var showSelectLineAlert = false
    var showStopsOnMap = false

    func presentSelectionState() {
        showStopsOnMap = true
        isSearchSheetPresented = false
        isSelectionSheetPresented = true
    }

    func resetToSearchState() {
        isSelectionSheetPresented = false
        shouldDismissSelection = false
        searchDetent = .height(100)
        isSearchSheetPresented = true
        searchText = ""
        showStopsOnMap = false
    }
}
