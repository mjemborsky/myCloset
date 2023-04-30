//
//  profileView.swift
//  myCloset
//
//  Created by Taylor  on 4/3/23.
//
import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import Firebase


struct ProfileHeader: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var user: UserProfile
    var posts: [Post]
    @State private var postsOrSaved: Bool = true
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
            ScrollView {
                Spacer()
                VStack{
                    Spacer()
                    Spacer()
                    Spacer()
                        .padding(.bottom, 150)
                    Text(user.username).font(.system(size: 20).bold()).foregroundColor(.white)
                        .padding(.bottom, 25)
                    Spacer()
                    Text(user.bio ?? "").font(.caption)
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    HStack{
                        Spacer()
                        if postsOrSaved {
                            Image(systemName: "squareshape.split.3x3")
                                .foregroundColor(.white)
                                .padding(.top, 5)
                                .font(.title2)
                        } else {
                            Button(action: {
                                postsOrSaved.toggle()
                            }, label: {
                                Image(systemName: "squareshape.split.3x3")
                                    .foregroundColor(.white)
                                    .padding(.top, 5)
                                    .font(.title2)
                            })
                        }
                        Spacer()
                        if postsOrSaved {
                            Button(action: {
                                postsOrSaved.toggle()
                            }, label: {
                                Image(systemName: "bookmark.fill")
                                    .foregroundColor(.white)
                            })
                        } else {
                            Image(systemName: "bookmark.fill")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                    .multilineTextAlignment(.center)
                    Spacer()
                    if postsOrSaved {
                        postGrid(posts: posts, currentUser: user)
                    } else {
                        savedGrid(posts: posts, currentUser: user)
                    }
                }
            }
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
    func returnToView() {
        if willMoveToProfile {
            toggleMenu.toggle()
        }
    }
}
    
//
struct postGrid: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var posts: [Post]
    var currentUser: UserProfile
    var body: some View {
        LazyVGrid(columns: columns, spacing:0) {
            ForEach(posts) { Post in
                if Post.postCreator == currentUser.username {
                    Image(uiImage: Post.postImage)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                }
            }
            .padding(.top, 5)
        }
    }
}

struct savedGrid: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var posts: [Post]
    var currentUser: UserProfile
    var body: some View {
        LazyVGrid(columns: columns, spacing:0) {
            ForEach(posts) { Post in
                if Post.postSaves.contains(currentUser.username) {
                    Image(uiImage: Post.postImage)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                }
            }
            .padding(.top, 5)
        }
    }
}

struct profileView: View {
    let gradient = Gradient(colors: [.pink, .white])
    var user: UserProfile
    var posts: [Post]
    var body: some View {
        VStack {
            ProfileHeader(user: user, posts: posts)
        }
        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView(user: UserProfile(username: "joe", bio: "blah"), posts: [Post(id: UUID(), postTime: currentdate, postCreator: "bob", postDescription: "My favorite outfit", postLikes: ["mary", "bob"], postSaves: ["steve", "joe"], postTags: ["cardigan", "comfort"], postImage: UIImage(systemName: "person.circle.crop.fill")!, linkedOutfit: "blah")])
    }
}
