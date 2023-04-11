//
//  profileView.swift
//  myCloset
//
//  Created by Taylor  on 4/3/23.
//
import SwiftUI


struct ProfileHeader: View {
    
    let post: Post
<<<<<<< HEAD

=======
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
>>>>>>> jonahMergeFeed
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
<<<<<<< HEAD
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
                .fullScreenCover(isPresented: $willMoveToCloset) {
                    ClosetView()
                        .environmentObject(ClothingItemManager())
                }
                .onAppear {
                    returnToView()
                }
        }
    }
=======
            ScrollView {
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
                                Text("@\(getUsername(UserProfile:post.postCreator))").font(.system(size: 20).bold()).foregroundColor(.white)
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
                                Spacer()
                            }
                            postGrid()
                            Spacer()
                            Text("Saved Outfits")
                                .foregroundColor(.white)
                                .font(.title2)
                            savedGrid()
                        }
                        Spacer()
                    }
                    Spacer()
                }
                MenuView(isOpen: $toggleMenu, feedSelected: $willMoveToFeed, searchSelected: $willMoveToSearch, closetSelected: $willMoveToCloset, profileSelected: $willMoveToProfile, hideFeed: $isHidden)
                    .fullScreenCover(isPresented: $willMoveToFeed) {
                        FeedView()
                    }
                    .fullScreenCover(isPresented: $willMoveToSearch) {
                        FeedView()
                    }
                    .fullScreenCover(isPresented: $willMoveToCloset) {
                        ClosetView()
                            .environmentObject(ClothingItemManager())
                    }
                    .onAppear {
                        returnToView()
                    }
            }
        }
        
    }
    
>>>>>>> jonahMergeFeed
    func returnToView() {
        if willMoveToProfile {
            toggleMenu.toggle()
        }
<<<<<<< HEAD
=======
    }
}
    
    
struct postGrid: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        LazyVGrid(columns: columns, spacing:0) {
            ForEach(0 ..< 15, id: \.self) {
                index in Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .border(Color.white)
                    .clipped()
                
            }
            .padding(.top, 5)
        }
    }
}
struct savedGrid: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        LazyVGrid(columns: columns, spacing:0) {
            ForEach(0 ..< 15, id: \.self) {
                index in Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .border(Color.white)
                    .clipped()
                
            }
            .padding(.top, 5)
        }
>>>>>>> jonahMergeFeed
    }
}
struct profileView: View {
    let gradient = Gradient(colors: [.pink, .white])
    var body: some View {
        VStack {
            ProfileHeader(post: SAMPLE_POST)
        }
        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                        .edgesIgnoringSafeArea(.all)
    }
    
    
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}
