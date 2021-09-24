//
//  ContentView.swift
//  animationsInSwift
//
//  Created by João Guilherme on 22/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentData = ContentViewModel()
    
    //Movendo imagem para o top
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment:.bottom){
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
                        .overlay(
                            Text("\(contentData.cartItems)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 15, y: -10)
                                .opacity(contentData.cartItems != 0 ? 1 : 0)
                        )
                    
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
                        Text("$100.00")
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
            
            AddToCart(animation: animation)
                .offset(y: contentData.showCart ? contentData.startAnimation ? 500 : 0 : 500)
                .environmentObject(contentData)
            
            //ANIMACOES
            
            if contentData.startAnimation{
                VStack{
                    Spacer()
                    
                    ZStack{
                        
                        Color.white
                            .frame(width: contentData.shoeAnimation ? 100 : getRect().width * 1.3, height: contentData.shoeAnimation ? 100 : getRect().width * 1.3)
                            .clipShape(Circle())
                            .opacity(contentData.shoeAnimation ? 1 : 0)
                        
                        Image("tenis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "SHOE", in: animation)
                            .frame(width: 80, height: 80)
                    }
                    .offset(y: contentData.saveCart ? 70 : -120)
                    //Efeito de escala
                    .scaleEffect(contentData.saveCart ? 0.6 : 1)
                    .onAppear(perform: contentData.perfomAnimation)
                    
                    if !contentData.saveCart{
                        Spacer()
                    }
                    
                    
                    
                    Image(systemName: "bag\(contentData.addItemtoCart ? ".fill" : "")")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(contentData.addItemtoCart ? .green : Color(red: 0.04, green: 0.47, blue: 0.87, opacity: 1.00))
                        .clipShape(Circle())
                        .offset(y:contentData.showBag ? -50 : 300)
                }
                .frame(width: getRect().width)
                .offset(y: contentData.endAnimation ? 500 : 0)
            }
        }
        .ignoresSafeArea(.all,edges: .bottom)
        .background(Color.black.opacity(0.04).ignoresSafeArea())
        .onChange(of: contentData.endAnimation) { value in
            if contentData.endAnimation{
                contentData.resetAll()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AddToCart: View {
    @EnvironmentObject var contentData: ContentViewModel
    var animation: Namespace.ID
    
    var body: some View{
        VStack{
            HStack(spacing: 15){
                
                if !contentData.startAnimation{
                    Image("tenis")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .matchedGeometryEffect(id: "SHOE", in: animation)
                }
                
                VStack(alignment: .trailing, spacing: 10){
                    Text("Adidas NMD R1 PK, Tricolor")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                    
                    Text("$100.00")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }.padding()
            Divider()
            
            Text("SELECT SIZE")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.vertical)
            
            let columns = Array(repeating: GridItem(.flexible(),spacing: 8),count: 4)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                ForEach(sizes, id: \.self){size in
                    Button(action: {
                        withAnimation{
                            contentData.selectedSize = size
                        }
                    }){
                        Text(size)
                            .fontWeight(.semibold)
                            .foregroundColor(contentData.selectedSize == size ? .white : .black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(contentData.selectedSize == size ? Color(red: 0.04, green: 0.47, blue: 0.87, opacity: 1.00) : Color.black.opacity(0.06))
                            .cornerRadius(10)
                    }
                    
                    
                }
            }.padding(.top)
            
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.7)){
                    contentData.startAnimation.toggle()
                }
            }) {
                Text("Add to cart")
                    .fontWeight(.bold)
                    .foregroundColor(contentData.selectedSize == "" ? .black : .white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(contentData.selectedSize == "" ? Color.black.opacity(0.06)  :  Color(red: 0.04, green: 0.47, blue: 0.87, opacity: 1.00) )
                    .cornerRadius(18)
            }.disabled(contentData.selectedSize == "")
            .padding(.top)
            
        }
        .padding()
        .background(Color.white.clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 35)))
    }
}

let sizes = ["BR38","BR39","BR40","BR41","BR42"]

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
