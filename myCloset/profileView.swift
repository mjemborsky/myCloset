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

    
    var body: some View {
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
                    }
                    
                }
                Spacer()
            }
            Spacer()
        }.background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
    }
}
struct profileView: View {
    var body: some View {
        VStack {
            ProfileHeader(post: SAMPLE_POST[0])
                    }
    
    }
    
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}
