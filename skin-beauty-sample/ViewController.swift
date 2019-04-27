//
//  ViewController.swift
//  skin-beauty-sample
//
//  Created by Huiping Guo on 2019/04/17.
//  Copyright © 2019 Huiping Guo. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {

    private var videoCamera: GPUImageVideoCamera?
    private var videoPreview: GPUImageView?
    private var beautifyFilter: GPUImageBeautifyFilter?
    private var currentFilter: GPUImageFilterGroup?
    
    private var isBeautyFaceOn = true {
        didSet {
            switchSkinBeauty()
        }
    }
    
    @IBOutlet var containView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        configureVidoeCamera()
        configureFilter()
        configureVideoPreView()
        
        // 美肌追加
        videoCamera?.addTarget(currentFilter)
        // perview表示
        currentFilter?.addTarget(videoPreview)
        
        // 開始
        videoCamera?.startCapture()
    }
    
    private func configureVidoeCamera() {
        let videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: .front)
        
        videoCamera?.horizontallyMirrorFrontFacingCamera = true
        videoCamera?.frameRate = 30
        videoCamera?.outputImageOrientation = .portrait
        
        self.videoCamera = videoCamera
    }
    
    private func configureFilter() {
        self.currentFilter = createCurrentFilter()
    }
    
    private func configureVideoPreView() {
        let videoPreview = GPUImageView(frame: self.view.frame)
        videoPreview.fillMode = kGPUImageFillModePreserveAspectRatio
        
        containView.addSubview(videoPreview)

        self.videoPreview = videoPreview
    }
    
    private func switchSkinBeauty() {
        currentFilter?.removeAllTargets()
        videoCamera?.removeAllTargets()
        
        beautifyFilter = nil
        
        currentFilter = createCurrentFilter()
        
        videoCamera?.addTarget(currentFilter)
        currentFilter?.addTarget(videoPreview)
    }
    
    private func createCurrentFilter() -> GPUImageFilterGroup {
        if isBeautyFaceOn {
            let beautifyFilter = GPUImageBeautifyFilter()
            
            self.beautifyFilter = beautifyFilter
            return beautifyFilter
        }
        
        let group = GPUImageFilterGroup()
        let emptyFilter = GPUImageEmptyFilter()
        group.addFilter(emptyFilter)
        group.initialFilters = [emptyFilter]
        group.terminalFilter = emptyFilter
        return group
    }
    
}

// ui event
extension ViewController {
    @IBAction func skinbeautySwitched(switcher: UISwitch) {
        self.isBeautyFaceOn = switcher.isOn
    }
    
    @IBAction func levelValueChanged(slider: UISlider) {
        beautifyFilter?.level = CGFloat(slider.value)
    }
    
    @IBAction func bilateralLevelValueChanged(slider: UISlider) {
        beautifyFilter?.bilateralLevel = CGFloat(slider.value)
    }
    
    @IBAction func saturationLevelValueChanged(slider: UISlider) {
        beautifyFilter?.saturationLevel = CGFloat(slider.value)
    }
    
    @IBAction func brightnessLevelValueChanged(slider: UISlider) {
        beautifyFilter?.brightnessLevel = CGFloat(slider.value)
    }
}

