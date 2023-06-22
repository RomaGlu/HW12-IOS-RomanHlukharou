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

    // MARK: - Properties
    
    private var myTimer = Timer()
    private var isWorkTime: Bool = false
    private var isStarted: Bool = false
    private var isRestTime: Bool = false
    private var workTime = 4
    private var timerDisplayed = 4
    private var restTime = 3
    private var imagePlay = UIImage(systemName: "play")
    private var imagePause = UIImage(systemName: "pause")
    private var imageStop = UIImage(systemName: "stop")
    
    // MARK: - Outlets
    
    private lazy var timerLabel: UILabel = {
       let timerLabel = UILabel()
        timerLabel.textColor = .systemRed
        timerLabel.font = UIFont.boldSystemFont(ofSize: 70)
        timerLabel.text = String(timerDisplayed)
        timerLabel.textAlignment = .center
        return timerLabel
    }()
    
    private lazy var startStopButton: UIButton = {
        let startStopButton = UIButton(type: .system)
        startStopButton.setTitleColor(.systemRed, for: .normal)
        startStopButton.addTarget(self, action: #selector(startStopButtonPressed), for: .touchUpInside)
        startStopButton.setImage(imagePlay, for: .normal)
        return startStopButton
    }()
    
    private lazy var circularProgressBarView: CircularProgressBarView = {
       let progressBar = CircularProgressBarView()
        progressBar.createCircularPath()
        return progressBar
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Layout
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupHierarchy() {
        view.addSubview(circularProgressBarView)
        view.addSubview(timerLabel)
        view.addSubview(startStopButton)
    }
    
    func setupLayout() {
        
        circularProgressBarView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.left.equalTo(view).offset(200)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(270)
            make.bottom.equalTo(view.snp.bottom).inset(430)
            make.left.equalTo(view.snp.left).offset(150)
            make.right.equalTo(view.snp.right).inset(150)
        }
     
        startStopButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(550)
            make.bottom.equalTo(view.snp.bottom).inset(210)
            make.left.equalTo(view.snp.left).offset(150)
            make.right.equalTo(view.snp.right).inset(150)
        }
        
    }
    
    func setUpProgressBarView() {
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        circularProgressBarView.center = view.center
    }
    
    // MARK: - Actions

    @objc private func startStopButtonPressed() {
        
        if isWorkTime {
            myTimer.invalidate()
        } else if isStarted == true {
            myTimer.invalidate()
            isStarted = false
            if let presentation = circularProgressBarView.progressLayer.presentation() {
                circularProgressBarView.progressLayer.strokeEnd = presentation.strokeEnd
            }
            circularProgressBarView.progressLayer.removeAnimation(forKey: "progressAnimation")
            startStopButton.setImage(imagePause, for: .normal)
        } else {
            isStarted = true
            circularProgressBarView.progressAnimation(duration: TimeInterval(workTime))
            startStopButton.setImage(imagePlay, for: .normal)
            myTimer = Timer.scheduledTimer(timeInterval: 1,
                                               target: self,
                                               selector: #selector(makeStart),
                                               userInfo: nil, repeats: true)
        }
        
        timerLabel.text = String(timerDisplayed)
    }
    
    @objc private func makeStart() {
        timerDisplayed -= 1
        timerLabel.text = "\(timerDisplayed)"
        
        if timerDisplayed == 0 && timerLabel.textColor == .systemRed {
            timerLabel.textColor = .green
            timerDisplayed = restTime
            circularProgressBarView.progressAnimation(duration: TimeInterval(timerDisplayed))
            timerLabel.text = "\(timerDisplayed)"
            circularProgressBarView.progressLayer.strokeColor = UIColor(ciColor: .green).cgColor
            startStopButton.setTitleColor(.green, for: .normal)
            isRestTime = true
        } else if isRestTime == true && timerLabel.textColor == .green && timerDisplayed == 0 {
            isWorkTime = false
            circularProgressBarView.progressLayer.strokeColor = UIColor(ciColor: .red).cgColor
            timerLabel.textColor = .systemRed
            isRestTime = false
            isStarted = false
            startStopButton.setImage(imageStop, for: .normal)
            myTimer.invalidate()
        }
    }
}
