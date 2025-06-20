import UIKit

final class LoaderView: UIView {
    
    static let shared = LoaderView()

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private override init(frame: CGRect = UIScreen.main.bounds) {
        super.init(frame: frame)
        setupLoaderUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLoaderUI() {
        backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        // Setup spinner
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            if self.superview == nil {
                self.frame = window.bounds
                window.addSubview(self)
                self.activityIndicator.startAnimating()
            }
        }
    }

    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.removeFromSuperview()
        }
    }
}
