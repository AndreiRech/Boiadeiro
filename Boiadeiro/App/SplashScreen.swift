//
//  SplashScreen.swift
//  Boiadeiro
//
//  Created by Andrei Rech on 08/08/25.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color(.secondarySystemBackground)
                .ignoresSafeArea(edges: .all)
            
            Image(.cow)
                .resizable()
                .frame(width: 227, height: 300)
                .animation(.bouncy, value: 2)
                
        }
    }
}
