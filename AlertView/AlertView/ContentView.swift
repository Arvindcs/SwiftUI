//
//  ContentView.swift
//  alert
//
//  Created by Aloha on 31/03/21.
//

import SwiftUI

class UserState: ObservableObject {
    @Published var sessionExpired: Bool = false
}

struct ContentView: View {

    @EnvironmentObject var userState: UserState
    @State private var isShowSecondView = false
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            NavigationLink(destination: SecondView(),  isActive: $isShowSecondView) {
                ZStack(alignment: .center) {
                    Button("Show Second") {
                        isShowSecondView.toggle()
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Hello"), message: Text("If you Like my work then me do follow me instagram @codewitharvind"), dismissButton: .default(Text("Got it!")))
                }
                .onChange(of:  userState.sessionExpired, perform: { value in
                    print("onChange")
                    if userState.sessionExpired {
                        showingAlert = true
                    }
                })
            }
        }
    }
}

struct SecondView: View {

    @EnvironmentObject var userState: UserState

    var body: some View {
        ZStack(alignment: .center) {

            Button("Show Alert Message") { // TODO:- Here I changed flag then alert will present
                userState.sessionExpired.toggle()
            }
        }
    }
}


