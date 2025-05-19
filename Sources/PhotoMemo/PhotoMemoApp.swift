import SwiftUI

@main
struct PhotoMemoApp: App {
    @StateObject private var viewModel = PhotoMemoViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
