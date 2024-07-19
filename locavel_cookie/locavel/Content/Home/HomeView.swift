import Foundation
import SwiftUI
import UIKit
import NMapsMap
import Combine


struct HomeView: View {
  var body: some View {
      ZStack {
          MapView()
      }
  }
}


struct MapView: UIViewRepresentable {
  @ObservedObject var viewModel = MapSceneViewModel()
  func makeUIView(context: Context) -> NMFNaverMapView {
    let view = NMFNaverMapView()
    view.showZoomControls = false
    view.mapView.positionMode = .direction
    view.mapView.zoomLevel = 17
    return view
  }

  func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}

class MapSceneViewModel: ObservableObject {

}

#Preview {
    HomeView()
}
