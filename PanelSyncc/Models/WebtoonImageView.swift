//import SwiftUI
//import Combine
//
//struct WebtoonImageView: View {
//    let urlString: String
//    @State private var image: UIImage? = nil
//    @State private var isLoading = false
//    @State private var hasError = false
//    
//    var body: some View {
//        Group {
//            if let image = image {
//                // THE FIX: An invisible box that perfectly takes the shape of your 346x150 card.
//                Color.clear
//                    // Set the image as the background of the invisible box and anchor it to the top.
//                    .background(
//                        Image(uiImage: image)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill),
//                        alignment: .top
//                    )
//                    // Ensure the view boundary is strictly enforced
//                    .contentShape(Rectangle())
//                    .clipped()
//                
//            } else if isLoading {
//                ZStack {
//                    Color(red: 0.1, green: 0.2, blue: 0.5)
//                    ProgressView()
//                        .tint(.white)
//                }
//            } else if hasError {
//                ZStack {
//                    Color(red: 0.1, green: 0.2, blue: 0.5)
//                    HStack {
//                        Spacer()
//                        Image(systemName: "photo.badge.exclamationmark")
//                            .font(.system(size: 40))
//                            .foregroundColor(.white.opacity(0.3))
//                            .padding(.trailing, 40)
//                    }
//                }
//            } else {
//                Color(red: 0.1, green: 0.2, blue: 0.5)
//                    .onAppear {
//                        loadImage()
//                    }
//            }
//        }
//    }
//    
//    private func loadImage() {
//        guard let url = URL(string: urlString) else {
//            hasError = true
//            return
//        }
//        
//        isLoading = true
//        hasError = false
//        
//        var request = URLRequest(url: url)
//        request.setValue("https://www.webtoons.com", forHTTPHeaderField: "Referer")
//        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1", forHTTPHeaderField: "User-Agent")
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                self.isLoading = false
//                if let data = data, let downloadedImage = UIImage(data: data) {
//                    self.image = downloadedImage
//                } else {
//                    self.hasError = true
//                }
//            }
//        }.resume()
//    }
//}
