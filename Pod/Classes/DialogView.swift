//
//  DialogView.swift
//
//  Created by Ondrej Rafaj on 25/02/2016.
//  Copyright © 2016 manGoweb.cz. All rights reserved.
//

import UIKit
import SnapKit


public enum DialogButtonType {
    case Default
    case Destruct
    case Accept
    case Done
}


public class DialogView : UIView {
    
    
    // MARK Configuration
    
    public var tapOnCurtainClosesDialog: Bool = true
    public var innerDialogPadding: CGFloat = 20
    public var dialodViewWidth: CGFloat = 240
    
    public var buttonHeight: CGFloat = 40
    public var buttonPadding: CGFloat = 12
    
    public var canvasView: UIView = UIView()
    public var curtainView: DialogCurtainView = DialogCurtainView()
    
    public var animationDuration: NSTimeInterval = 0.2
    
    public var object: AnyObject? // Can be used for example to store NSIndexPath, CoreData object, etc ...
    
    
    // MARK: Private variables
    
    private var title: String?
    private var titleAttributes: [String: AnyObject]?
    private var titleLabel: UILabel?
    
    private var message: String?
    private var messageAttributes: [String: AnyObject]?
    private var messageLabel: UILabel?
    
    private var buttons: [DialogButton] = [DialogButton]()
    private var activeController: UIViewController? = nil
    
    
    // MARK: Presenting view
    
    public func showInController(controller: UIViewController, animated: Bool = true) {
        activeController = controller
        
        // Add to the controller hidden
        self.hide()
        activeController?.view.addSubview(self)
        
        // Setup self autolayout
        self.snp_makeConstraints { (make) -> Void in
             make.edges.equalTo(self.superview!)
        }
        
        var lastElement: UIView?
        
        // Add labels
        self.createLabels(&lastElement)
        
        // Add buttons
        self.createButtons(&lastElement)
        
        // Set canvas size
        self.canvasView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.snp_center)
            make.width.equalTo(self.dialodViewWidth)
            if (lastElement != nil) {
                make.bottom.equalTo((lastElement?.snp_bottom)!).offset(self.innerDialogPadding)
            }
            else {
                make.height.equalTo(240)
            }
        }
        
        // Display views
        self.showViews()
    }
    
    private func createLabels(inout lastElement: UIView?) {
        // Title label
        if titleLabel != nil {
            titleLabel = self.label(title!, attributes: titleAttributes, bold: true)
            self.canvasView.addSubview(titleLabel!)
            
            self.titleLabel?.preferredMaxLayoutWidth = (self.dialodViewWidth - (2 * self.innerDialogPadding))
            self.titleLabel!.snp_makeConstraints{ (make) -> Void in
                make.left.top.equalTo(self.innerDialogPadding)
                make.right.equalTo(self.innerDialogPadding * -1)
            }
            
            lastElement = self.titleLabel
        }
        
        // Message label
        if self.messageLabel != nil {
            self.canvasView.addSubview(self.messageLabel!)
            
            self.messageLabel?.preferredMaxLayoutWidth = (self.dialodViewWidth - (2 * self.innerDialogPadding))
            self.messageLabel!.snp_makeConstraints{ (make) -> Void in
                make.top.equalTo(((self.titleLabel != nil) ? (titleLabel?.snp_bottom)! : self.canvasView.snp_top)).offset(innerDialogPadding)
                make.left.equalTo(self.innerDialogPadding)
                make.right.equalTo(self.innerDialogPadding * -1)
            }
            
            lastElement = self.messageLabel
        }
    }
    
    private func createButtons(inout lastElement: UIView?) {
        if buttons.count > 0 {
            var lastButton: DialogButton?
            for b: DialogButton in self.buttons {
                self.canvasView.addSubview(b)
                b.snp_makeConstraints(closure: { (make) -> Void in
                    if lastButton == nil {
                        if self.messageLabel != nil {
                            make.top.equalTo((self.messageLabel?.snp_bottom)!).offset(self.innerDialogPadding)
                        }
                        else {
                            if self.titleLabel != nil {
                                make.top.equalTo((self.titleLabel?.snp_bottom)!).offset(self.innerDialogPadding)
                            }
                            else {
                                make.top.equalTo(self.innerDialogPadding)
                            }
                        }
                    }
                    else {
                        make.top.equalTo((lastButton?.snp_bottom)!).offset(self.buttonPadding)
                    }
                    make.left.equalTo(self.innerDialogPadding)
                    make.right.equalTo(self.innerDialogPadding * -1)
                    make.height.equalTo(self.buttonHeight)
                })
                lastButton = b
                
                lastElement = b
            }
        }
    }
    
    private func showViews() {
        curtainView.hidden = false
        canvasView.hidden = false
        
        UIView.animateWithDuration(self.animationDuration, delay: 0.0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.curtainView.alpha = 1
            self.canvasView.alpha = 1
            }) { (completed: Bool) -> Void in
                
        }
    }
    
    public func hide(animated: Bool) {
        if animated == true {
            UIView.animateWithDuration(self.animationDuration, delay: 0.0, options: .BeginFromCurrentState, animations: { () -> Void in
                self.curtainView.alpha = 0;
                self.canvasView.alpha = 0;
                }, completion: { (completed: Bool) -> Void in
                    self.curtainView.hidden = true
                    self.canvasView.hidden = true
                    self.removeFromSuperview()
                }
            )
        }
        else {
            self.hide()
        }
    }
    
    public func hide() {
        curtainView.alpha = 0;
        canvasView.alpha = 0;
        curtainView.hidden = true
        canvasView.hidden = true
        self.removeFromSuperview()
    }
    
    // MARK: Configuring view
    
    public func setTitle(titleString: String, attributes: [String: AnyObject] = [String: AnyObject]()) -> UILabel {
        self.title = titleString
        self.titleAttributes = attributes
        
        self.titleLabel = self.label(self.title!, attributes: self.titleAttributes, bold: true)
        return self.titleLabel!
    }
    
    public func setMessage(messageString: String, attributes: [String: AnyObject] = [String: AnyObject]()) -> UILabel {
        self.message = messageString
        self.messageAttributes = attributes
        
        self.messageLabel = self.label(self.message!, attributes: self.messageAttributes, bold: false)
        return self.messageLabel!
    }
    
    public func addButton(button: DialogButton) {
        buttons.append(button)
        canvasView.addSubview(button)
    }
    
    public func addButton(title: String, textColor: UIColor = UIColor.whiteColor(), backgroundColor: UIColor = UIColor.grayColor(), highlightedBackgroundColor: UIColor = UIColor.lightGrayColor(), cornerRadius: CGFloat = 4) -> DialogButton {
        let button: DialogButton = DialogButton()
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(textColor, forState: .Normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
        
        button.defaultBackgroundColor = backgroundColor
        button.highlightedBackgroundColor = backgroundColor
        button.dialogView = self
        
        self.addButton(button)
        
        return button
    }
    
    public func addButton(title: String, type: DialogButtonType) -> DialogButton {
        var textColor: UIColor?
        var backgroundColor: UIColor?
        var highlightedBackgroundColor: UIColor?
        
        switch (type) {
        case .Accept:
            textColor = UIColor.whiteColor()
            backgroundColor = UIColor.init(colorLiteralRed: (16 / 255), green: (182 / 255), blue: (113 / 255), alpha: 1)
            highlightedBackgroundColor = UIColor.lightGrayColor()
            break
        case .Destruct:
            textColor = UIColor.whiteColor()
            backgroundColor = UIColor.init(colorLiteralRed: (195 / 255), green: (36 / 255), blue: (39 / 255), alpha: 1)
            highlightedBackgroundColor = UIColor.darkGrayColor()
            break
        case .Done:
            textColor = UIColor.whiteColor()
            backgroundColor = UIColor.grayColor()
            highlightedBackgroundColor = UIColor.darkGrayColor()
            break
        default:
            textColor = UIColor.whiteColor()
            backgroundColor = UIColor.lightGrayColor()
            highlightedBackgroundColor = UIColor.lightGrayColor()
            break
        }
        
        return self.addButton(title, textColor: textColor!, backgroundColor: backgroundColor!, highlightedBackgroundColor: highlightedBackgroundColor!)
    }
    
    // MARK: Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // MARK: Curtain
        self.curtainView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: Creating elements
    
    private func label(text: String, var attributes: [String: AnyObject]?, bold: Bool = false) -> UILabel {
        let label: UILabel = UILabel()
        
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        label.numberOfLines = 0
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        if attributes == nil {
            attributes = [String: AnyObject]()
        }
        if attributes![NSFontAttributeName] == nil {
            attributes![NSFontAttributeName] = (bold ? UIFont.boldSystemFontOfSize(18) : UIFont.systemFontOfSize(14))
        }
        if attributes![NSForegroundColorAttributeName] == nil {
            attributes![NSForegroundColorAttributeName] = UIColor.darkGrayColor()
        }
        if attributes![NSBackgroundColorAttributeName] == nil {
            attributes![NSBackgroundColorAttributeName] = UIColor.clearColor()
        }
        attributedString.addAttributes(attributes!, range: NSRange.init(location: 0, length: text.characters.count))
        
        label.attributedText = attributedString
        
        return label
    }
    
    private func addCurtainView() {
        self.addSubview(self.curtainView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTapCurtain:")
        self.curtainView.addGestureRecognizer(tap)
    }
    
    private func addCanvasView() {
        self.canvasView.layer.cornerRadius = 4
        self.canvasView.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(self.canvasView)
    }
    
    private func addSubviews() {
        self.addCurtainView()
        self.addCanvasView()
    }
    
    // MARK: Actions
    
    func didTapCurtain(sender: UITapGestureRecognizer) {
        if (self.tapOnCurtainClosesDialog) {
            self.hide(true)
        }
    }

    // MARK: Initialization
    
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews()
        self.layoutSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
}


public class DialogCurtainView : UIView {
    
    // MARK: Initialization
    
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
}


public class DialogButton : UIButton {
    
    internal var defaultBackgroundColor: UIColor!
    internal var highlightedBackgroundColor: UIColor!
    
    public var dialogView: DialogView!
    
}
