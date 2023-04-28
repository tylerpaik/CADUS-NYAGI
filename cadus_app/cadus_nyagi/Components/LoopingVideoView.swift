
import SwiftUI
import AVKit

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    private func commonInit() {
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct LoopingVideoView: UIViewRepresentable {
    let videoName: String

    func makeUIView(context: Context) -> PlayerUIView {
        let playerUIView = PlayerUIView()

        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
            debugPrint("Video not found")
            return playerUIView
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        player.actionAtItemEnd = .none

        playerUIView.player = player
        player.play()

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: .zero)
            player.play()
        }

        return playerUIView
    }

    func updateUIView(_ uiView: PlayerUIView, context: Context) {}
}

struct LoopingVideoView_Previews: PreviewProvider {
    static var previews: some View {
        LoopingVideoView(videoName: "lolde")
    }
}
