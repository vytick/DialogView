//
//  ViewController.swift
//  DialogView
//
//  Created by Ondrej Rafaj on 29/02/2016.
//  Copyright © 2016 manGoweb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func giveMeDialogView(sender: UIButton) {
        let alert: DialogView = DialogView()
        alert.setTitle("Dialog Title")
        alert.setMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a augue eget felis dictum ultrices ac a arcu.")
        
        let button: DialogButton = alert.addButton("Ok", type: .Done)
        button.addTarget(self, action: "myAlertAction:", forControlEvents: .TouchUpInside)
        alert.showInController(self)
    }
    
    @IBAction func giveMeAdvancedDialogView(sender: UIButton) {
        let alert: DialogView = DialogView()
        
        var attr: [String: AnyObject] = [String: AnyObject]();
        attr[NSFontAttributeName] = UIFont.init(name: "HelveticaNeue-Light", size: 16)!
        alert.setTitle("Dialog Title", attributes: attr)
        
        attr[NSFontAttributeName] = UIFont.init(name: "HelveticaNeue-UltraLight", size: 14)!
        alert.setMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a augue eget felis dictum ultrices ac a arcu.", attributes: attr)
        
        var button: DialogButton = alert.addButton("Accept", type: .Accept)
        button.addTarget(self, action: "myAlertAction:", forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 14)!
        
        button = alert.addButton("Delete", type: .Destruct)
        button.addTarget(self, action: "myAlertAction:", forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 14)!
        
        button = alert.addButton("Done", type: .Done)
        button.addTarget(self, action: "myAlertAction:", forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 14)!
        
        button = alert.addButton("Default", type: .Default)
        button.addTarget(self, action: "myAlertAction:", forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 14)!
        
        alert.showInController(self)
    }
    
    // MARK: Alert actions
    
    func myAlertAction(sender: DialogButton) {
        sender.dialogView.hide(true)
    }
    
    
}

