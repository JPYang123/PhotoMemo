import SwiftUI
import PhotosUI

struct ContentView: View {
    @ObservedObject var viewModel: PhotoMemoViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    PhotosPicker(selection: $viewModel.pickerItem, matching: .images) {
                        Label("Select Photo", systemImage: "photo")
                    }
                    TextField("Timestamp", text: $viewModel.timestampString)
                        .textFieldStyle(.roundedBorder)
                    TextEditor(text: $viewModel.note)
                        .font(.system(size: viewModel.fontSize))
                        .frame(minHeight: 80)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray.opacity(0.3)))
                    Stepper("Font Size", value: $viewModel.fontSize, in: 10...40)
                    if let image = viewModel.selectedImage {
                        PreviewView(image: image,
                                    timestamp: viewModel.timestamp,
                                    note: viewModel.note,
                                    fontSize: viewModel.fontSize)
                    }
                    HStack {
                        Button("Save") { viewModel.saveToLibrary() }
                            .disabled(viewModel.compositedImage == nil)
                        if let image = viewModel.compositedImage {
                            ShareLink(item: image) {
                                Text("Share")
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("PhotoMemo")
        }
    }
}
