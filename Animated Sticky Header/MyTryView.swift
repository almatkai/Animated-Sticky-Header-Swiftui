//
//  MyTryView.swift
//  Animated Sticky Header
//
//  Created by Almat Kairatov on 09.08.2023.
//

import SwiftUI

struct MyTryView: View {
    var safeArea: EdgeInsets
    var size: CGSize
    @Namespace var topID
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack {
                GeometryReader { proxy in
                    let scroll = proxy.frame(in: .named("SCROLL")).minY
                    VStack(alignment: .center){
                        Image("Image")
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: size.width, height: size.height * 0.5 + scroll)
                            .overlay {
                                Rectangle()
                                    .fill(.linearGradient(colors: [
                                        Color("white").opacity(0),
                                        Color("white").opacity(0.2),
                                        Color("white").opacity(0.3),
                                        Color("white").opacity(0.5),
                                        Color("white").opacity(0.85),
                                        Color("white").opacity(1)
                                    ], startPoint: .top, endPoint: .bottom))
                            }
                            .offset(y: scroll > 0 ? -scroll : 0)
                    }
                }
                HeaderView()
                    .zIndex(2)
                ListView()
                    .zIndex(1)
                    .padding(.top, size.height * 0.45)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let scroll = proxy.frame(in: .named("SCROLL")).minY
            let scrollRate = min(max(0, (-scroll - (size.height * 0.1)) / ((size.height * 0.3) - (size.height * 0.1))), 1)
            VStack {
                HStack(){
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                    Spacer()
                    Text("Following")
                        .font(.caption)
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1.5)
                        )
                }
                .padding(.top, safeArea.top)
                .padding(.horizontal, 16)
                .frame(maxWidth: size.width)
                .padding(.bottom, 6)
                .background {
                    Rectangle()
                        .foregroundColor(Color("white"))
                        .overlay {
                            VStack {
                                Spacer()
                                Rectangle()
                                    .frame(width: size.width, height: 0.5)
                                    .foregroundColor(.gray)
                            }
                        }
                }
                .offset(y: -scroll)
            }
            .opacity(scrollRate)
            VStack {
                Text("City Sound".uppercased())
                    .font(.system(size: (2 - scrollRate) * 20))
                    .offset(y: max( -scroll, safeArea.top + size.height * 0.2))
                    .onAppear {
                        print("DEBUG: \(safeArea.top)")
                    }
                Spacer()
            }.frame(width: size.width, height: size.height)
                .padding(.top, safeArea.top)
        }
    }
    
    @ViewBuilder
    func ListView() -> some View {
        VStack{
            ForEach(albums.indices, id: \.self) { index in
                HStack {
                    Text("\(index + 1)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                    VStack(alignment: .leading, spacing: 6) {
                        Text(albums[index].albumName)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Text("425")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }.padding()
            }
        }
        .padding(15)
    }
}

struct MyTryView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
