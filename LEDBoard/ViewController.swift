//
//  ViewController.swift
//  LEDBoard
//
//  Created by 정준영 on 2023/07/24.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var textFieldBackgroundView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textConfigButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var ledLabel: UILabel!
    
    /// LEDLabel ColorSet
    private let ledLabelColorSet: [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemCyan,
        .systemGray,
        .systemMint,
        .systemPink,
        .systemTeal,
        .systemBrown,
        .systemGreen
    ]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        addTapGesture()
    }
    
    // MARK: - Private Methods
    private func configUI() {
        // Background Color
        self.view.backgroundColor = .label
        
        // BackgroundView
        textFieldBackgroundView.backgroundColor = .systemBackground
        textFieldBackgroundView.layer.cornerRadius = 5
        
        // TextField
        textField.delegate = self
        textField.borderStyle = .none
        
        // Setup Button
        [sendButton, textConfigButton].forEach { button in
            button?.configuration?.baseBackgroundColor = .systemBackground
            button?.layer.borderWidth = 2
            button?.layer.borderColor = UIColor.label.cgColor
            button?.titleLabel?.font = .boldSystemFont(ofSize: 14)
            button?.layer.cornerRadius = 15
            button?.clipsToBounds = true
        }
        sendButton.configuration?.baseForegroundColor = .label
        textConfigButton.configuration?.baseForegroundColor = .systemRed
        
        // LEDLabel
        ledLabel.textColor = .systemRed
    }
    
    private func addTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDown(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func keyboardDown(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    // MARK: - Action Methods
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        ledLabel.text = textField.text
        textField.text = ""
        view.endEditing(true)
    }
    
    @IBAction func textConfigButtonTapped(_ sender: UIButton) {
        // 색 변화 트랜지션 효과 적용
        UIView.transition(with: ledLabel, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseInOut]) { [weak self] in
            self?.ledLabel.textColor = self?.ledLabelColorSet.randomElement()
        }
    }
}

// MARK: - TextField Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ledLabel.text = textField.text
        textField.text = ""
        view.endEditing(true)
        return true
    }
}
