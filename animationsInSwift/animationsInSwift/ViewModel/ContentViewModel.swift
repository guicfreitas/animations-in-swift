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
    
    @Published var showBag = false
    @Published var saveCart = false
    
    @Published var addItemtoCart = false
    
    @Published var endAnimation = false
    
    @Published var cartItems = 0
    
    //realizando animacao
    func perfomAnimation(){
        withAnimation(.easeOut(duration: 0.8)){
            shoeAnimation.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut){
                self.showBag.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75){
            
            withAnimation(.easeInOut(duration: 0.5)){
                self.saveCart.toggle()
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1){
            
            self.addItemtoCart.toggle()
            
        }
        
        //fim das animacoes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25){
            
            withAnimation(.easeInOut(duration: 0.5)){
                self.endAnimation.toggle()
            }
            
        }
    }
    
    func resetAll(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ [self] in
            withAnimation{
                showCart.toggle()
            }
            
            startAnimation = false
            endAnimation = false
            selectedSize = ""
            addItemtoCart = false
            showBag = false
            shoeAnimation = false
            saveCart = false
            cartItems += 1
        }
    }
}

