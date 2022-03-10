import ARKit

final class ARViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20.0) 
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var centerDot: UIView = {
        let dot = UIView()
        dot.backgroundColor = .red
        return dot
    }()

    private let arView = ARSCNView()
    private var startVector: SCNVector3?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // view
        self.view.addSubview(arView)
        arView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arView.topAnchor.constraint(equalTo: self.view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            arView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            arView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
        arView.delegate = self

        self.view.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150),
            self.label.heightAnchor.constraint(equalToConstant: 30),
            self.label.widthAnchor.constraint(equalToConstant: 400),
        ])

        self.view.addSubview(self.button)
        self.button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            self.button.heightAnchor.constraint(equalToConstant: 50),
            self.button.widthAnchor.constraint(equalToConstant: 50),
        ])

        self.view.addSubview(self.centerDot)
        self.centerDot.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerDot.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.centerDot.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.centerDot.heightAnchor.constraint(equalToConstant: 4),
            self.centerDot.widthAnchor.constraint(equalToConstant: 4),
        ])

        // setting
        let session = ARSession()
        arView.session = session
        arView.showsStatistics = true
        arView.debugOptions = ARSCNDebugOptions.showFeaturePoints

        // run
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)

    }

    @objc private func tapped(_ sender: UIButton) {
        if let centerPosition = getCenter() {
            // Start地点が指定されているとき
            if let startVector = self.startVector {
                let cmDistance = getCmDistance(startVector: startVector, endVector: centerPosition)
                self.label.text = String(format: "%.2f", cmDistance) + "cm"

                self.startVector = nil
            } else {
                // Start地点が指定されていないとき
                startVector = centerPosition
                self.label.text = "計測中"
            }
        }
    }

    private func getCenter() -> SCNVector3? {
        let center = view.center
        let results = arView.hitTest(center, types: .featurePoint)
        if results.isEmpty == false {
            if let result = results.first {
                return SCNVector3(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
            }
        }
        return nil
    }

    private func getCmDistance(startVector: SCNVector3, endVector: SCNVector3) -> Float {
        let position = SCNVector3Make(
            endVector.x - startVector.x,
            endVector.y - startVector.y,
            endVector.z - startVector.z
        )
        let distance = sqrt(position.x * position.x + position.y * position.y + position.z * position.z)
        return distance * 100
    }
}

extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let startVector = self.startVector,
           let centerPosition = getCenter() {
            let cmDistance = getCmDistance(startVector: startVector, endVector: centerPosition)
            self.label.text = String(format: "%.2f", cmDistance) + "cm"
        }
    }
}
