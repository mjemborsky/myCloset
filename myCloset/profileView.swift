//
//  profileView.swift
//  myCloset
//
//  Created by Taylor  on 4/3/23.
//
import SwiftUI


struct ProfileHeader: View {
    
    let post: Post
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    

    
    var body: some View {
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
        }
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
    }
}
struct profileView: View {
    let gradient = Gradient(colors: [.pink, .white])
    var body: some View {
        VStack {
            ProfileHeader(post: SAMPLE_POST[0])
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
