//
//  MainViewController.swift
//  Sherpa
//
//  Created by 신동규 on 2018. 6. 7..
//  Copyright © 2018년 신동규. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Speech

class MainViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var micBtn: UIButton!
    @IBOutlet weak var cancelmicBtn: UIButton!
    @IBOutlet weak var micStringLB: UILabel!
    @IBOutlet weak var recommendLabel: UILabel!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20),
                                                                  type: NVActivityIndicatorType(rawValue: 23)!)
    let micimg = UIImageView()
    var detectionTimer = Timer()
    
    var tablex: CGFloat = 0
    var tabley: CGFloat = 0
    var isListening: Bool = false
    
    var model = [[ModelTransformable]]() {
        didSet {
            tableview.reloadData()
        }
    }
    
    var category = [Category?]()
    var questions = [String?]() {
        didSet {
            tableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self
        updateUI()
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopListening()
    }
    
    func updateUI() {
        view.addSubview(activityIndicatorView)
        view.addSubview(micimg)
        
        micimg.isHidden = true
        micStringLB.isHidden = true
        cancelmicBtn.isHidden = true
        
        recommendLabel.layer.borderColor = #colorLiteral(red: 0.02708645537, green: 0.8015219569, blue: 0.723786056, alpha: 1)
    }
    
    func addGesture() {
        let tvGesture = UIPanGestureRecognizer(target: self, action: #selector(stopListening))
        tvGesture.delegate = self
        tableview.addGestureRecognizer(tvGesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == DetailMountainViewController.identifier {
            let destination = segue.destination as! DetailMountainViewController
            destination.mountain = sender as? Mountain
        }
    }
    
    // 마이크 레코딩
    func startListening() {
        guard !isListening else {
            return
        }
        
        isListening = true
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            return
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let `self` = self else {
                return
            }
            
            if self.audioEngine.isRunning{
                if result != nil {
                self.micStringLB.text = result?.bestTranscription.formattedString
                self.micStringLB.sizeToFit()
            }
           
            let timer = self.detectionTimer
            if !timer.isValid {
                self.detectionTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] timer in
                    guard let `self` = self else {
                        return
                    }
                    if self.micStringLB.text != "듣고있어요 :)" && self.micStringLB.text != "" {
                        let speechNetwork = SpeechNM()
                        self.questions.append(self.micStringLB.text)
                        speechNetwork.sendSpeech(string: self.micStringLB.text ?? "") { category, model, error in
                            guard error == nil else {
                                self.category.append(.none)
                                self.model.append([])
                                return
                            }
                            guard let model = model, let category = category else {
                                self.category.append(.none)
                                self.model.append([])
                                return
                            }
                            self.category.append(category)
                            self.model.append(model)
                        }
                    }
                    timer.invalidate()
                    self.stopListening()
                    }
                }
            }
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("error: ", error.localizedDescription)
        }
        
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, time in
            self?.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
            micStringLB.text = "듣고있어요 :)"
        } catch {
            print("error: ", error.localizedDescription)
        }
    }
  
    
    @objc func stopListening() {
        guard isListening else {
            return
        }

        micimg.isHidden = true
        cancelmicBtn.isHidden = true
        micBtn.isHidden = false
        activityIndicatorView.stopAnimating()
        micStringLB.isHidden = true
        
        //애니메이션 적용 해서 네비바와 탭바 생성 후 테이블뷰 내림
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.tableview.frame.origin.y = 0
        }, completion: nil)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        setTabBarHidden(false)
        
        //오디오 관련 멈춤
        audioEngine.reset()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        
        recognitionRequest = nil
        recognitionTask?.cancel()
        recognitionTask = nil
        recognitionRequest?.endAudio()
    
        isListening = false
    }
    
    @IBAction func cancelmicAction(_ sender: Any) {
        stopListening()
        tableview.scrollToBottom()
    }
    
    @IBAction func micAction(_ sender: Any) {
        if !audioEngine.isRunning {
        startListening()
        cancelmicBtn.isHidden = false
        micBtn.isHidden = true
        
        let xsize = tableview.frame.size.width
        let ysize = tableview.frame.size.height
        tablex = xsize
        tabley = ysize
            
        activityIndicatorView.color = UIColor(red:0.04, green:0.27, blue:0.24, alpha:1.0)
        activityIndicatorView.frame.size.width = 170
        activityIndicatorView.frame.size.height = 170
        activityIndicatorView.frame.origin.y = ysize - 200
        activityIndicatorView.frame.origin.x = (xsize / 2) - (170 / 2)
        activityIndicatorView.startAnimating()
        
        micimg.image = #imageLiteral(resourceName: "micButton")
        micimg.frame.size.width = 97.6
        micimg.frame.size.height = 97.6
        micimg.center = activityIndicatorView.center
        micimg.isHidden = false
            
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
                        self?.tableview.frame.origin.y = -(ysize * 0.39)
        }, completion: nil)
        tableview.scrollToBottom()
     
        navigationController?.setNavigationBarHidden(true, animated: true)
        setTabBarHidden(true)
        
        micStringLB.isHidden = false
        micStringLB.frame.origin.y = ysize - (ysize * 0.35)
        micStringLB.frame.origin.x = 10
        micStringLB.sizeToFit()
        }
    }
}

