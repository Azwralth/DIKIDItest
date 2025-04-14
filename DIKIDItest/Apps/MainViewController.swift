//
//  ViewController.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 06.04.2025.
//

import UIKit
import SwiftUI

final class MainViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Открой SwiftUI экран", for: .normal)
        button.addTarget(self, action: #selector(openSwiftUIView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        
        setupConstraints()
    }

    
    @objc func openSwiftUIView() {
        let view = MainView()
        let hostingController = UIHostingController(rootView: view)
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

