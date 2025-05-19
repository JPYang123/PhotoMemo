import SwiftUI
import PhotosUI
import Photos

@MainActor
final class PhotoMemoViewModel: ObservableObject {
    @Published var pickerItem: PhotosPickerItem? {
        didSet { Task { await loadSelectedImage() } }
    }
    @Published var selectedImage: UIImage?
    @Published var note: String = ""
    @Published var fontSize: Double = 16
    @Published var timestamp: Date = Date()
    @Published var compositedImage: UIImage?

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    var timestampString: String {
        get { dateFormatter.string(from: timestamp) }
        set {
            if let date = dateFormatter.date(from: newValue) {
                timestamp = date
            }
        }
    }

    func loadSelectedImage() async {
        guard let item = pickerItem else { return }
        // Reject Live Photos & video
        if item.supportedContentTypes.contains(.livePhoto) ||
            item.supportedContentTypes.contains(.movie) {
            pickerItem = nil
            return
        }
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                selectedImage = uiImage
                updateComposite()
            }
        } catch {
            print("Failed to load image", error)
        }
    }

    func updateComposite() {
        compositedImage = renderCompositeImage()
    }

    func renderCompositeImage() -> UIImage? {
        guard let image = selectedImage else { return nil }
        let view = PreviewView(image: image,
                               timestamp: timestamp,
                               note: note,
                               fontSize: fontSize)
        let renderer = ImageRenderer(content: view)
        renderer.scale = UIScreen.main.scale
        return renderer.uiImage
    }

    func saveToLibrary() {
        guard let uiImage = compositedImage else { return }
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            guard status == .authorized || status == .limited else { return }
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: uiImage)
            }
        }
    }
}
