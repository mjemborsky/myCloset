// PostCell.swift
// myCloset
// Created by Michael Emborsky on 3/3/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI
// UI for an individual post "cell" - responsible for all formatting of buttons, etc.. of an individual post. This is used by feedView to format all posts.

struct PostCell: View {
    let post: Post
    
    @State var images = [UIImage]()
    // could include "placeholder" eventually using .redacted, for when it is loading
    var body: some View {
        let imageLink =  post.getPostImageLink()
        //        var imageView = UIImageView(getImage(imageLink: imageLink))
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
            //            Image(uiImage: getImage(imageLink: imageLink))
            // Filler for now
            Image("person.crop.circle.fill")
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.width)
            
            //            ImageView()
            //            .view.addSubview(ImageView)
            //            .frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            //            UIImage(getImage(imageLink: imageLink))
            //                .scaledToFill()
            //                .frame(width: UIScreen.main.bounds.width,
            //                       height: UIScreen.main.bounds.width)
            
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
        // calling to get array of images to use
//        .onAppear {
//            retrievePhotos(imageLink: imageLink)
//        }
    }
//
//
//    func retrievePhotos(imageLink: String) {
//        // Get the data from the database
//
//        let storageRef = Storage.storage().reference()
//        let path = "images/04F31D88-D014-4DAD-B186-755BEDD9AD58.jpg"
//        let fileRef = storageRef.child(path)
//        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//            if error == nil && data != nil {
//
//                if let data = data!.jpegData(compressionQuality: 0.9) {
//                    let image = UIImage(data: data!)
//                    DispatchQueue.main.async {
//                        images.append(image)
//                    }
//                }
//            }
//        }
//    }
        
//    func getImage(imageLink: String) async {
//        let storageRef = Storage.storage()
//        let fileRef = storageRef.reference().child("images/04F31D88-D014-4DAD-B186-755BEDD9AD58.jpg")
////        let fileRef = storageRef.child("sample1" + ".png")
//        //let path = "gs://mycloset-ea3a8.appspot.com/images/"+imageLink+".jpg"
//
//        fileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if error == nil && data != nil {
//                if let image = UIImage(data: data!) {
//                    DispatchQueue.main.async {
//                        images.append(image)
//                    }
//                }
//            }
//        }
//    }
}
    
    
    //
    //    func getImages(imageLink: String) async {
    //        let imageLink = URL(string: (imageLink.replacingOccurrences(of: "/images/", with: "")))
    //        let reference =  Storage.storage().reference(forURL: "gs://mycloset-ea3a8.appspot.com")
    //        do {
    //            reference.downloadURL(completion: {(imageLink, error) in
    //                let data = try Data(contentsOf: imageLink!)
    //                let image = UIImage(data: data as Data)
    //                DispatchQueue.main.async {
    //                    images.append(image!)
    //                }
    //            })
    //        } catch {
    //            print("Unexpected error: \(error).")
    //        }
    //    }
    //}
    



//
//func getImage(imageLink: String) -> UIImage {
//    let url = URL(string: ("gs://mycloset-ea3a8.appspot.com/images/365C8DBF-92CF-4AB7-B729-38F09524FE3D.jpg"))
////    let storage = Storage.storage(url: "gs://mycloset-ea3a8.appspot.com/images/").reference()
////    let storageRef = storage.child("365C8DBF-92CF-4AB7-B729-38F09524FE3D.jpg")
//    let newImageView: UIImageView = UIImageView()
//    let placeholder = UIImage(named: "placeholder.jpg")
//    newImageView.sd_setImage(with: url, placeholderImage: placeholder)
//    let image: UIImage = newImageView.image!
//    return image
//}



//
//
//struct ImageView: View {
////    @State var image: UIImageView
//    var body: some View {
//        UIImageView(UIImage: image)
//        .frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
//    }
//    func getImage(imageLink: String) -> UIImageView {
//        let url =  "gs://mycloset-ea3a8.appspot.com/images/365C8DBF-92CF-4AB7-B729-38F09524FE3D.jpg"
//    //    let storage = Storage.storage(url: "gs://mycloset-ea3a8.appspot.com/images/").reference()
//    //    let storageRef = storage.child("365C8DBF-92CF-4AB7-B729-38F09524FE3D.jpg")
//        let newImageView: UIImageView = UIImageView()
//        self.newImageView.image = Image(url)
//        let placeholder = UIImage(named: "placeholder.jpg")
//        [self.view addSubview:self.newImageView]
//        return newImageView
//    }
//}
        
//
//
//
//
//        })) { (data, error) in
//                if let _error = error {
//                        print(_error)
//                        failure(_error)
//                }
//                else {
//                    if let _data  = data {
//                        let myImage:UIImage! = UIImage(data: _data)
//                        success(myImage)
//                    }
//                }
//        }
//    }
//}
//
    
    
//    func getImages(imageLink: String) async {
//        let db = Firestore.firestore()
//        let path = "gs://mycloset-ea3a8.appspot.com/images"
//        let imageLink = imageLink.replacingOccurrences(of: "images/", with: "")
//        let docRef = db.collection(path).document(imageLink)
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                var data = document.data()
//                data.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                    if error == nil {
//                        let image = UIImage(data: data!)
//                        DispatchQueue.main.async {
//                            images.append(image!)
//                        }
//                    }
//                    else {
//                        let error = error
//                        print(error?.localizedDescription as Any)
//                    }
//                }
//            }
//            else {
//                let error = error
//                print(error?.localizedDescription as Any)
//            }
//        }
//    }
    

//
//struct PostCellPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCell(post: SAMPLE_POST)
//    }
//}

