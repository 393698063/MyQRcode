//
//  QGCodeScannerViewController.swift
//  My二维码
//
//  Created by jorgon on 12/04/17.
//  Copyright © 2017年 jorgon. All rights reserved.
//

import UIKit
import AVFoundation

class QGCodeScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    var readQGcodeFinishClosure:((_ resultStr:String?) -> ())?
    
    private let cameraView = QGScannerBackgroundView(frame: UIScreen.main.bounds)
    
    private let captureSession = AVCaptureSession()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black
        
        self.view.addSubview(cameraView)
        
        //初始化捕捉设备 （AVCaptureDevice）,类型AVMediaTypeVideo
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        let input :AVCaptureInput
        
        let output = AVCaptureMetadataOutput()
        
        
        // Do-Catch 处理错误
        do{
            //创建输入流
            input = try AVCaptureDeviceInput(device: captureDevice)
            
            //把输入流添加到会话
            captureSession.addInput(input)
            
            //把输出流添加到会话
            captureSession.addOutput(output)
        }catch{
            print("异常")
        }
        
        //创建串行队列
        let dispatchQueue = DispatchQueue(label: "queue",attributes:[])
        
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        
        
        //设置输出媒体的数据类型
        output.metadataObjectTypes = NSArray(array: [AVMetadataObjectTypeQRCode,
                                                     AVMetadataObjectTypeEAN13Code,
                                                     AVMetadataObjectTypeEAN8Code,
                                                     AVMetadataObjectTypeCode128Code]) as [AnyObject]
        
        //创建预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        //设置预览图层的填充方式
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        //设置预览图层的frame
        videoPreviewLayer?.frame = cameraView.bounds
        
        //将预览图层添加到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
        
        //设置扫描范围
        output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        
        // 取消按钮
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(cancelBtn)
        cancelBtn.frame = CGRect.init(x: 30, y: 30, width: 50, height: 30)
        
        
    }
    func cancelBtnClick() {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        }else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.scannerStart()
    }
    
    func scannerStart() {
        captureSession.startRunning()
        cameraView.scaning = "start"
    }
    
    func scannerStop() {
        captureSession.stopRunning()
        cameraView.scaning = "stop"
    }
    
    //扫描代理方法
    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputMetadataObjects metadataObjects: [Any]!,
                       from connection: AVCaptureConnection!) {
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData : AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            
            DispatchQueue.main.async(execute: {
                self.cancelBtnClick()
                self.readQGcodeFinishClosure?(metaData.stringValue)
            })
            captureSession.stopRunning()
        }
    }
    //从相册中选择图片
    func selectPhotoFromPhotoLibrary(_ sender : AnyObject){
        let picture = UIImagePickerController()
        picture.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picture.delegate = self
        self.present(picture, animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



















































































