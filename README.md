# PhotoMemo
Scaffold a new SwiftUI iOS app named “PhotoMemo”. 
Use MVVM, Swift Package Manager, and add a .gitignore for Xcode.

Functional Requirements
1. Photo Selection
One-tap button opens the system photo picker (PhotosPicker).
Accept still images only; reject LivePhotos & video.

2. Note Entry
Multiline TextEditor for user notes (plain text).
Auto-prepend current date/time (editable).
Adjustable font size (Stepper ±).

3. Live Preview
On the same screen, show a real-time composited preview:
┌─────────────┐   (original image, aspect-fit)
│   photo                     │
├─────────────┤
│  timestamp               │   (small gray)
│  user note                 │   (wrap, left-aligned)
└─────────────┘   (white background, min 80 pt height)
Add a subtle drop shadow to mimic a physical print.

4. Export / Share
“Save” writes the composite as PNG/JPEG into the user’s photo library (PHPhotoLibrary).
“Share” opens the system share sheet with the rendered image (ShareLink).

5. Permissions
Use read-only Photos access for picking; Add-Only access for saving (no full-library permission).
