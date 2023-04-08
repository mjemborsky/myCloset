//
//  profileView.swift
//  myCloset
//
//  Created by Taylor  on 4/3/23.
//

import SwiftUI


struct ProfileHeader: View {
    let gradient = Gradient(colors: [.pink, .white])
    let post: Post

    // Variable for if sidemenu is showing or not
    @State private var toggleMenu: Bool = false
    // Variables for which view will be switched to next (from sidemenu)
    @State private var willMoveToFeed: Bool = false
    @State private var willMoveToSearch: Bool = false
    @State private var willMoveToCloset: Bool = false
    @State private var willMoveToProfile: Bool = false
    // Variable to hide feedview
    @State private var isHidden: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    VStack{
                        Image(systemName: "photo.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .clipped()
                            .foregroundColor(Color.white)
                            .padding(.top, 55)
                        VStack {
                            Text("username").font(.system(size: 20).bold()).foregroundColor(.white)
                            HStack {
                                VStack {
                                    Text("321") //Need to add the user profile following count
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text("Following")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                                VStack {
                                    Text("500") //Need to add the user profile followers count
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text("Followers")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }
                            HStack{
                                Spacer()
                                Image(systemName: "squareshape.split.3x3")
                                    .foregroundColor(.white)
                                    .padding(.top, 5)
                                    .font(.title2)
                                Spacer()
                                Image(systemName: "square.and.arrow.down")
                                    .foregroundColor(.white)
                                    .padding(.top, 5)
                                    .font(.title2)
                                Spacer()
                            }
                        }
                        
                    }
                    Spacer()
                }
                Spacer()
            }.background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                .edgesIgnoringSafeArea(.all)
        
            MenuView(isOpen: $toggleMenu, feedSelected: $willMoveToFeed, searchSelected: $willMoveToSearch, closetSelected: $willMoveToCloset, profileSelected: $willMoveToProfile, hideFeed: $isHidden)
                .fullScreenCover(isPresented: $willMoveToFeed) {
                    FeedView()
                }
                .fullScreenCover(isPresented: $willMoveToSearch) {
                    SearchView()
                }
                .sheet(isPresented: $willMoveToCloset) {
                    ClosetView()
                        .environmentObject(ClothingItemManager())
                }
                // need to replace this with just toggling menu
                .fullScreenCover(isPresented: $willMoveToProfile) {
                    profileView()
                }
                // need conditional for profile view selection (toggle menu)
        }
    }
}
struct profileView: View {
    var body: some View {
        VStack {
            ProfileHeader(post: SAMPLE_POST)
        }
        
    
    }
    
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}
