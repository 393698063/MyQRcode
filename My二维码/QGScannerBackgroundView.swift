//
//  QGScannerBackgroundView.swift
//  My二维码
//
//  Created by jorgon on 12/04/17.
//  Copyright © 2017年 jorgon. All rights reserved.
//

import UIKit

class QGScannerBackgroundView: UIView {

    let barcodeView = UIView.init(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.2,
                                                y: UIScreen.main.bounds.size.height * 0.35,
                                                width: UIScreen.main.bounds.size.width * 0.6,
                                                height: UIScreen.main.bounds.width * 0.6));
    //扫描线
    let scanLine = UIImageView()
    
    var scaning : String!
    
    var timer = Timer();
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        barcodeView.layer.borderWidth = 1.0
        barcodeView.layer.borderColor = UIColor.white.cgColor
        self.addSubview(barcodeView);
        
        //设置扫描线
        scanLine.frame = CGRect(x: 0, y: 0, width: barcodeView.frame.size.width, height: 2);
        scanLine.image = self.imagesNamedFromCustomBundle(imgName: "QRCodeScanLine@2x")
        
        //设置扫描图层
        barcodeView.addSubview(scanLine);
        
       self.createBackGroundView()
        
        self.addObserver(self, forKeyPath: "scaning", options: .new, context: nil);
        
        timer = Timer.scheduledTimer(timeInterval: 2,
                                     target: self,
                                     selector: #selector(moveScannerLayer(_:)),
                                     userInfo: nil, repeats: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func imagesNamedFromCustomBundle(imgName: String) -> UIImage {
        let bundlePath = Bundle.main.path(forResource: "Source.bundle", ofType: nil)
        let bundle = Bundle.init(path: bundlePath!)
        let img_path = bundle?.path(forResource: imgName, ofType: "png")
        return UIImage.init(contentsOfFile: img_path!)!
    }
    
    private func createBackGroundView (){
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width,
                                           height: barcodeView.frame.origin.y))
        let bottomView = UIView(frame: CGRect(x: 0,
                                              y: UIScreen.main.bounds.size.width * 0.6 + UIScreen.main.bounds.size.height * 0.35,
                                              width: UIScreen.main.bounds.size.width,
                                              height: UIScreen.main.bounds.size.height * 0.65 - UIScreen.main.bounds.size.width * 0.6))
        let leftView = UIView(frame: CGRect(x: 0,
                                            y: UIScreen.main.bounds.size.height * 0.35,
                                            width: UIScreen.main.bounds.size.width * 0.2,
                                            height: UIScreen.main.bounds.size.width * 0.6))
        let rightView = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.8,
                                             y: UIScreen.main.bounds.size.height * 0.35,
                                             width: UIScreen.main.bounds.size.width * 0.2,
                                             height: UIScreen.main.bounds.size.width * 0.6))
        
        topView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        leftView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        rightView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        let label = UILabel(frame: CGRect(x: 0, y: 10,
                                          width: UIScreen.main.bounds.size.width,
                                          height: 21))
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14);
        label.text = "将二维码／条形码放入扫描框内，即可自动扫描";
        
        bottomView.addSubview(label)
        
        self.addSubview(topView)
        self.addSubview(bottomView)
        self.addSubview(leftView)
        self.addSubview(rightView)
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if scaning == "start" {
            timer.fire()
        }
        else{
            timer.invalidate()
        }
    }
    
    //让扫描线滚动
    func moveScannerLayer(_ timer:Timer){
        scanLine.frame = CGRect(x: 0, y: 0, width: self.barcodeView.frame.size.width, height: 12);
        UIView.animate(withDuration: 2) {
            self.scanLine.frame = CGRect(x: self.scanLine.frame.origin.x,
                                         y: self.scanLine.frame.origin.y + self.barcodeView.frame.size.height - 10,
                                         width: self.scanLine.frame.size.width,
                                         height: self.scanLine.frame.size.height);
            
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

























































