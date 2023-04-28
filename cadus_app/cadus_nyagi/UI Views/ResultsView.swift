import SwiftUI
import UIKit

struct ResultsView: View {
    @Binding var results: UIImage?

    var body: some View {
        VStack {
            Text("Results")
                .font(.largeTitle)
                .padding()

            // Display your model's results here
            if let image = results {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            } else {
                Text("No image available")
                    .padding()
            }
        }
        .navigationBarTitle("Analysis Results", displayMode: .inline)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(results: .constant(UIImage(named: "SampleImage")))
    }
}

