//
//  ContentView.swift
//  Animated Sticky Header
//
//  Created by Almat Kairatov on 08.08.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { proxy in
            let safeArea = proxy.safeAreaInsets
            let size = proxy.size
            MyTryView(safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
//        GeometryReader { proxy in
//            let safeArea = proxy.safeAreaInsets
//            let size = proxy.size
//            HomeView(safeArea: safeArea, size: size)
//                .ignoresSafeArea(.container, edges: .top)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
