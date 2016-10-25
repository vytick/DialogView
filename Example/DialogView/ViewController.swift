//
//  ViewController.swift
//  DialogView
//
//  Created by Ondrej Rafaj on 03/26/2016.
//  Copyright (c) 2016 Ondrej Rafaj. All rights reserved.
//

import UIKit
import DialogView


class ViewController: UIViewController {
    
    
    @IBAction func giveMeDialogView(_ sender: UIButton) {
        let alert: DialogView = DialogView()
        alert.setTitle("Dialog Title")
        alert.setMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a augue eget felis dictum ultrices ac a arcu.")
        
        let button: DialogButton = alert.addButton("Ok", type: .done)
        button.addTarget(self, action: "myAlertAction:", for: .touchUpInside)
        alert.showInController(self)
    }
    
    @IBAction func giveMeAdvancedDialogView(_ sender: UIButton) {
        let alert: DialogView = DialogView()
        
        var attr: [String: AnyObject] = [String: AnyObject]();
        attr[NSFontAttributeName] = UIFont.init(name: "HelveticaNeue-Light", size: 16)!
        alert.setTitle("Dialog Title", attributes: attr)
        
        attr[NSFontAttributeName] = UIFont.init(name: "HelveticaNeue-UltraLight", size: 14)!
        alert.setMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a augue eget felis dictum ultrices ac a arcu.", attributes: attr)
        
        var button: DialogButton = alert.addButton("Accept", type: .accept)
        button.addTarget(self, action: #selector(ViewController.myAlertAction(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 14)!
        
        button = alert.addButton("Delete", type: .destruct)
        button.addTarget(self, action: #selector(ViewController.myAlertAction(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 14)!
        
        button = alert.addButton("Done", type: .done)
        button.addTarget(self, action: #selector(ViewController.myAlertAction(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 14)!
        
        button = alert.addButton("Default", type: .default)
        button.addTarget(self, action: #selector(ViewController.myAlertAction(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 14)!
        
        alert.showInController(self)
    }
    
    // MARK: Alert actions
    
    func myAlertAction(_ sender: DialogButton) {
        sender.dialogView.hide(true)
    }
    
    
}

