//
//  ContentView.swift
//  PDP_SwiftUI_ArDePatterns
//


import SwiftUI
import Combine

struct ContentView: View {
    
    @State var image:UIImage = UIImage()
    
    @State var singleUser = User()
    var userAPI = UserAPI()
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red: 0.1778685749, green: 0.1810673773, blue: 0.2110645473, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(systemName: "folder.fill")
                        .foregroundColor(.white)
                    Spacer()
                    Image("Octocat")
                        .resizable()
                        .frame(width: 32, height: 32)
                    Spacer()
                    Image(systemName: "bell")
                        .foregroundColor(.white)
                }
                
                HStack(alignment: .center, spacing: 16) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 90, height: 90)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 8) {
                        Text(singleUser.name ?? "Fullname")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                        Text(singleUser.login ?? "Username")
                            .foregroundColor(.gray)
                            .font(.system(size: 19))
                    }
                    Spacer()
                }
                .padding(.vertical, 25)
                
                HStack {
                    Text("📍 Working from home")
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
                
                Text(singleUser.bio ?? "Bio")
                    .foregroundColor(.white)
                    .font(.system(size: 17.0))
                    .padding(.vertical)
                
                Button(action: {
                },
                label: {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .font(.system(size: 17.0))
                        
                })
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.white, lineWidth: 1.0)
                )
                
                HStack {
                    Image(systemName: "link")
                        .foregroundColor(.gray)
                    Text(singleUser.blog ?? "linkedIn.com")
                        .foregroundColor(.white)
                        .font(.system(size: 14.0))
                        .frame(maxWidth: .infinity)
                        .lineLimit(1)
                    
                }
                .padding(.vertical)
                
                HStack {
                    Image(systemName: "person.and.person")
                        .foregroundColor(.gray)
                    Text(String(singleUser.followers ?? 0))
                        .foregroundColor(.white)
                        .font(.system(size: 14.0))
                    Text("follower")
                        .foregroundColor(.white)
                        .font(.system(size: 14.0))
                    Text("•")
                        .foregroundColor(.white)
                        .font(.system(size: 14.0))
                    Text(String(singleUser.following ?? 0))
                        .foregroundColor(.white)
                        .font(.system(size: 14.0))
                    Text("following")
                        .foregroundColor(.white)
                        .font(.system(size: 14.0))
                    Spacer()
                }

                
                
                Spacer()
            }
            .onAppear {
                userAPI.getSingleUser { response in
                    self.singleUser = response
                    if let url = URL(string: singleUser.avatar_url ?? "") {
                        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                            if let data = data {
                                DispatchQueue.main.async {
                                    self.image = UIImage(data: data) ?? image
                                }
                            }
                        }.resume()
                    }
                }
            }
            
            .padding()
        }
        

    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
