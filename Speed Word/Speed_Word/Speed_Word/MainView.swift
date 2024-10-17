//
//  SwiftUIView.swift
//  Speed_Word
//
//  Created by LOTI Didier on 17/10/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    @State var login: String = ""
    @State var password: String = ""
    @State var connected: Bool = false
    @State var messageErreur: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bgImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    if !viewModel.isValid {
                        VStack {
                            Text("Speed Word")
                                .padding(.leading, 20)
                                .font(.largeTitle)
                                .foregroundColor(.white) // Change la couleur du texte

                            TextField("Login", text: $login)
                                .frame(width: 246, height: 44)
                                .background(Color("Transparent"))
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            TextField("Password", text: $password)
                                .frame(width: 246, height: 44)
                                .background(Color("Transparent"))
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            Button {
                                viewModel.checkConnection(login: login, password: password)
                                if viewModel.isValid {
                                    connected = true
                                } else {
                                    messageErreur = "C'est pas les bons accès"
                                }
                            } label: {
                                Text("Log In")
                                    .foregroundColor(.white)
                            }
                            
                            if !messageErreur.isEmpty {
                                Text(messageErreur)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                        .padding()
                    } else {
                        VStack {
                            Text("How to play ?")
                                .padding()
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            
                            Text("Copy and validate as many words as \n possible to increase your score! \n Push the button Start Game to begin !")
                                .lineLimit(3)
                                .padding()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            
                            NavigationLink(destination: HomeView()) {
                                
                                Text("Play")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    MainView()
}
