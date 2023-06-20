//
//  ViewController.swift
//  HW12-IOS-RomanHlukharou
//
//  Created by Роман Глухарев on 20/06/2023.
//

import UIKit
import Foundation
import SnapKit

class ViewController: UIViewController {

    // MARK: - Outlets
    private lazy var timerLabel: UILabel = {
       let timerLabel = UILabel()
        return timerLabel
    }()
    
    private lazy var startStopButton: UIButton = {
        let startStopButton = UIButton(type: .system)
        
        return startStopButton
    }()
    
    private lazy var circularProgressBarView: CircularProgressBarView = {
       let progressBar = CircularProgressBarView()
        progressBar.createCircularPath()
        progressBar.progressAnimation(duration: circularViewDuration)
        return progressBar
    }()
    
    var circularViewDuration: TimeInterval = 2
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        setUpProgressBarView()
    }

    // MARK: - Layout
    
    func setupView() {
        view.backgroundColor = .systemBlue
    }
    
    func setupHierarchy() {
        view.addSubview(circularProgressBarView)
    }
    
    func setupLayout() {
        
        circularProgressBarView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.left.equalTo(view.snp.centerX)
        }
    }
    
    func setUpProgressBarView() {
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        circularProgressBarView.center = view.center
        circularProgressBarView.progressAnimation(duration: circularViewDuration)
        
    }
    
    // MARK: - Actions

}

