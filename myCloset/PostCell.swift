// PostCell.swift
// myCloset
// Created by Michael Emborsky on 3/3/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

// UI for an individual post "cell" - responsible for all formatting of buttons, etc.. of an individual post. This is used by feedView to format all posts.

struct PostCell: View {
    let post: Post
    @State var images = [UIImage]()
    // could include "placeholder" eventually using .redacted, for when it is loading
    var body: some View {
        // VStack for all post info
        VStack {
            // HStack for profile image, profile username
            HStack (spacing: 10) {
                // this is the user profile pic on each post
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                // this is the username of post creator
                Text(post.postCreator)
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal, 8)
            
            // insert image
            Image(uiImage: images[0])
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width)
            
            // another HStack for like and save option
            HStack (spacing: 16) {
                // should be replaced with a heart or like button
                Image(systemName: "heart")
                Text(String((post.postLikes).count) + " Likes")
                    .font(.headline)
                
                Spacer()
                
                // should be replaced with a save button
                Image(systemName: "bookmark")
            }
            .font(.title2)
            .padding(6)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(post.postCreator)
                        .font(.headline)
                    + Text(" " + post.postDescription)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Text(getDateinString(Date:post.postTime))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            Spacer()
            Spacer()
        
        }
        .onAppear {
            getImages()
        }
    }
        
    func getImages() {
        let db = Firestore.firestore()
        let path = "gs://mycloset-ea3a8.appspot.com/images/"
            db.collection("images/").getDocuments { snapshot, error in
                if error == nil && snapshot != nil {
                    let storeRef = Storage.storage().reference()
                    let fileRef = storeRef.child(path)
                    // need another for post creator picture
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        if error == nil {
                            let image = UIImage(data: data!)
                            DispatchQueue.main.async {
                                images.append(image!)
                            }
                        }
                        else {
                            let error = error
                            print(error?.localizedDescription as Any)
                        }
                    }
                }
                else {
                    let error = error
                    print(error?.localizedDescription as Any)
                }
            }
        }
}


struct PostCellPreview_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: SAMPLE_POST)
    }
}

