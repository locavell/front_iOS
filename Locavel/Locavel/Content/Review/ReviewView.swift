//
//  ReviewView.swift
//  Locavel
//
//  Created by 박희민 on 8/22/24.
//
import SwiftUI
import PhotosUI

struct ReviewView: View {
    @StateObject private var viewModel = ReviewViewModel()
    @State private var rating: Int = 0
    @State private var reviewText: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    //@State private var placeId: String? // 실제 placeId 값을 설정하세요
    var placeId: String
    
    var body: some View {
        VStack {
            Text("해당 장소를 리뷰해주세요")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 16)
            
            VStack(alignment: .leading) {
                Text("평점(필수)")
                    .font(.headline)
                    .padding(.top, 24)
                
                HStack {
                    ForEach(1..<6) { index in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(index <= rating ? Color.yellow : Color.gray)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                rating = index
                            }
                    }
                }
                .padding(.vertical)
            }
            
            Button(action: {
                self.showImagePicker = true
            }) {
                ZStack {
                    if let image = selectedImage {
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                            VStack {
                                Spacer()
                                Text("사진 재등록")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.accentColor)
                                    .cornerRadius(8)
                            }
                        }
                    } else {
                        ZStack {
                            Image("placeholder-image")
                                .resizable()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                            VStack {
                                Spacer()
                                Text("사진 등록")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.accentColor)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$selectedImage)
            }
            
            VStack(alignment: .leading) {
                Text("리뷰 작성")
                    .font(.headline)
                    .padding(.vertical)
                
                TextEditor(text: $reviewText)
                    .frame(height: 100)
                    .border(Color.gray, width: 2)
                    .cornerRadius(4)
                    .padding(.bottom, 20)
            }
            
            Button(action: {
                if rating >= 1 {
                        viewModel.addReview(placeId: placeId, comment: reviewText, rating: Double(rating)) { success in
                            if success {
                                // 리뷰가 성공적으로 등록된 경우 추가 동작을 정의할 수 있습니다.
                                print("리뷰 등록 성공")
                            } else {
                                // 실패 시에 추가 동작을 정의할 수 있습니다.
                                print("리뷰 등록 실패")
                            }
                        }
                    } else {
                    viewModel.message = "평점을 1점 이상 선택해주세요."
                }
            }) {
                Text("등록 완료하기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(rating >= 1 ? Color.blue : Color.gray)
                    .cornerRadius(8)
            }
            
            if viewModel.isSuccess {
                Text("리뷰가 정상적으로 등록되었습니다.")
                    .foregroundColor(.green)
            } else if !viewModel.message.isEmpty {
                Text(viewModel.message)
                    .foregroundColor(.red)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}


struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(placeId: "12345")
    }
}
