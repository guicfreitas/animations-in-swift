//
//  ContentViewModel.swift
//  animationsInSwift
//
//  Created by João Guilherme on 22/09/21.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var showCart = false
    @Published var selectedSize = ""
    
    //propriedades de animacao
    @Published var startAnimation = false
    @Published var shoeAnimation = false
}

