//
//  HomeView.swift
//  Animated Sticky Header
//
//  Created by Almat Kairatov on 08.08.2023.
//

import SwiftUI

struct HomeView: View {
    var safeArea: EdgeInsets
    var size: CGSize
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack {
                ArtWork()
                VStack{
                    Text("Popular")
                        .fontWeight(.heavy)
                    AlbumView()
                }.padding(.top, 10)
                    .zIndex(1)
                HeaderView()
                    .padding(.top, 100)
                    .zIndex(2)
                    .background(Color.black)
            }
        }
        .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func ArtWork() -> some View {
        let height = size.height * 0.45
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            
            Image("Image")
                .resizable()
                .scaledToFill()
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .clipped()
                .overlay {
                    ZStack(alignment: .bottom){
                        Rectangle()
                            .fill(
                                .linearGradient(colors: [.black.opacity(0 - progress),
                                                         .black.opacity(0.1 - progress),
                                                         .black.opacity(0.2 - progress),
                                                         .black.opacity(0.3 - progress),
                                                         .black.opacity(0.4 - progress),
                                                         .black.opacity(0.5 - progress),
                                                         .black.opacity(0.6 - progress),
                                                         .black.opacity(0.7 - progress),
                                                         .black.opacity(0.8 - progress),
                                                         .black.opacity(0.9 - progress),
                                                         .black.opacity(1 - progress),
                                                         .black.opacity(1),
                                                         
                                ], startPoint: .top, endPoint: .bottom)
                            )
                        VStack(spacing: 0){
                            Text("Forest\nSounds")
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            Text("509 Monthly Listeners".uppercased())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .padding(.top, 15)
                        }
                        .opacity(1 + (progress > 0 ? -progress : progress))
                        .padding(.bottom, 55)
                        .offset(y: minY < 0 ? minY : 0)
                    }
                }
            // MARK: - Here might be bug (8:33)
                .offset(y: -minY)
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    func AlbumView() -> some View {
        VStack{
            ForEach(albums.indices, id: \.self) { index in
                HStack {
                    Text("\(index + 1)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                    VStack(alignment: .leading, spacing: 6){
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
        }.padding(15)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            var titleProgress = minY / height
            
            HStack(spacing: 15){
                Button(action: {
                    
                }){
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.title3)
                }
                Spacer(minLength: 0)
                
                Button(action: {
                    
                }){
                    Text("Following")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .border(.white, width: 1.5)
                }.opacity(1 + progress)
                
                Button(action: {
                    
                }){
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
             .overlay(content: {
                Text("Forrest sound")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .offset(y: titleProgress > 3.86 ? 45 : 0)
                    .clipped()
                    .animation(.easeInOut(duration: 0.25), value: titleProgress > 3.86)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 15)
            .background {
                Color.black
                    .opacity(-progress > 1 ? 1 : 0)
            }
            .offset(y: -minY)
            .onAppear {
                print("DEBUG: \(titleProgress)")
            }
            .onChange(of: minY, perform: { i in
                titleProgress = minY / height
                print("DEBUG MINY: \(i)")
                print("DEBUG height: \(height)")
                print("DEBUG titleProgress: \(titleProgress)")
            })
        }
        .frame(height: 35)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
