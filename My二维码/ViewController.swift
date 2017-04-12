//
//  ViewController.swift
//  My二维码
//
//  Created by jorgon on 12/04/17.
//  Copyright © 2017年 jorgon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iTextField: UITextField!
    
    private var imageView :UIImageView?
    
    private let scanner = QGCodeScannerViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.cyan
        
        //点击空白处收回键盘 注册点击事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tap)
        
        scanner.readQGcodeFinishClosure = { string in
            WQAlertManager.sharedInstance.showAlert(targetVC: self, title: nil, message: string, style: .alert, confirmTitle: "确认", cancelTitle: nil)
            
        }
        
        
    }
    
    func handleTap(sender : UITapGestureRecognizer){
        if sender.state == .ended {
            iTextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false

    }
    //二维码扫描
    @IBAction func scanAction(_ sender: UIButton) {
        
        self.present(scanner, animated: true, completion: nil)
        
    }
    @IBAction func createAction(_ sender: Any) {
        
        
    }
    @IBAction func erWeima(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





































































































