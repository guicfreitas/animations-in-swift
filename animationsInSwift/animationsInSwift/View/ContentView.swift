//
//  ContentView.swift
//  animationsInSwift
//
//  Created by João Guilherme on 22/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentData = ContentViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action: {}) {
                        Image(systemName: "rectangle.3.offgrid.fill")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    Text("Adidas")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {}){
                        Image(systemName: "bag")
                            .foregroundColor(.white)
                            .font(.title2)
                        
                    }.padding(10)
                        .background(Color(red: 0.04, green: 0.47, blue: 0.87, opacity: 1.00))
                        .clipShape(Circle())
                    
                }
                ScrollView(){
                    VStack(alignment: .leading){
                        Text("Adidas NMD R1 PK, Tricolor")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("Adidas")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Image("tenis")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .padding(.horizontal,30)
                        Text("Price")
                            .foregroundColor(.gray)
                        Text("$100")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }.padding(10)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(15)
                        .overlay(
                            Capsule()
                                .fill(Color(red: 0.04, green: 0.47, blue: 0.87, opacity: 1.00))
                                .frame(width: 4, height: 45)
                                .padding(.top,10)
                            ,alignment: .topLeading
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                contentData.showCart.toggle()
                            }
                        }
                }
                
                
            }.padding(.horizontal,10)
                .blur(radius: contentData.showCart ? 50 : 0)
            
            AddToCart()
                .environmentObject(contentData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AddToCart: View{
    
    //@EnviromentObject var contentData
    var body: some View{
        VStack{
            
        }
    }
}
