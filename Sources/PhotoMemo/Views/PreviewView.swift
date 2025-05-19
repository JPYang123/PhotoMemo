import SwiftUI

struct PreviewView: View {
    var image: UIImage
    var timestamp: Date
    var note: String
    var fontSize: Double

    private var timestampString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(timestampString)
                .font(.caption)
                .foregroundColor(.gray)
            Text(note)
                .font(.system(size: fontSize))
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(minHeight: 80)
        .background(Color.white)
        .shadow(radius: 3)
    }
}
