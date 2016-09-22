//
//  DialogView.swift
//
//  Created by Ondrej Rafaj on 25/02/2016.
//  Copyright © 2016 manGoweb.cz. All rights reserved.
//

import UIKit
import SnapKit


public enum DialogButtonType {
    case `default`
    case destruct
    case accept
    case done
}

public enum DialogViewButtonAlignment {
    case `default`
    case oneRow
}

open class DialogView : UIView {
    
    
    // MARK Configuration
    
    open var tapOnCurtainClosesDialog: Bool = true
    open var innerDialogPadding: CGFloat = 20
    open var dialogViewWidth: CGFloat = 240
    
    open var buttonHeight: CGFloat = 40
    open var buttonPadding: CGFloat = 12
    
    open var topImageSize: CGSize = CGSize(width: 100, height: 100)
    
    open var canvasView: UIView = UIView()
    open var curtainView: DialogCurtainView = DialogCurtainView()
    
    open var animationDuration: TimeInterval = 0.2
    
    open var object: AnyObject? // Can be used for example to store NSIndexPath, CoreData object, etc ...
    open var isShown = false
    open var buttonAlignment: DialogViewButtonAlignment = .default
    
    // MARK: Private variables
    
    fileprivate var topImageView: UIImageView?
    
    fileprivate var title: String?
    fileprivate var titleAttributes: [String: AnyObject]?
    fileprivate var titleLabel: UILabel?
    
    fileprivate var message: String?
    fileprivate var messageAttributes: [String: AnyObject]?
    fileprivate var messageLabel: UILabel?
    
    fileprivate var buttons: [DialogButton] = [DialogButton]()
    fileprivate var activeController: UIViewController? = nil
    
    
    // MARK: Presenting view
    
    open func showInController(_ controller: UIViewController, animated: Bool = true) {
        activeController = controller
        
        // Add to the controller hidden
        self.hide()
        activeController?.view.addSubview(self)
        isShown = true
        
        // Setup self autolayout
        self.snp_makeConstraints { (make) -> Void in
             make.edges.equalTo(self.superview!)
        }
        
        
        var lastElement: UIView?
        
        self.createTopImage(&lastElement)
        
        // Add labels
        self.createLabels(&lastElement)
        
        // Add buttons
        self.createButtons(&lastElement)
        
        // Set canvas size
        self.canvasView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.snp_center)
            make.width.equalTo(self.dialogViewWidth)
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
    
    fileprivate func createTopImage(_ lastElement: inout UIView?) {
        if let topImgView = topImageView {
            canvasView.addSubview(topImgView)
            topImgView.snp_makeConstraints() {make in
                make.width.equalTo(topImageSize.width)
                make.height.equalTo(topImageSize.height)
                make.top.equalTo(innerDialogPadding)
                make.centerX.equalTo(canvasView)
            }
            lastElement = topImgView
        }
    }
    
    fileprivate func createLabels(_ lastElement: inout UIView?) {
        // Title label
        if titleLabel != nil {
            titleLabel = self.label(title!, textAttributes: titleAttributes, bold: true)
            self.canvasView.addSubview(titleLabel!)
            
            self.titleLabel?.preferredMaxLayoutWidth = (self.dialogViewWidth - (2 * self.innerDialogPadding))
            self.titleLabel!.snp_makeConstraints{ (make) -> Void in
                make.top.equalTo(self.topImageView != nil ? self.topImageView!.snp_bottom : self.canvasView.snp_top).offset(self.innerDialogPadding)
                make.left.equalTo(self.innerDialogPadding)
                make.right.equalTo(self.innerDialogPadding * -1)
            }
            
            lastElement = self.titleLabel
        }
        
        // Message label
        if self.messageLabel != nil {
            self.canvasView.addSubview(self.messageLabel!)
            
            self.messageLabel?.preferredMaxLayoutWidth = (self.dialogViewWidth - (2 * self.innerDialogPadding))
            self.messageLabel!.snp_makeConstraints{ (make) -> Void in
                make.top.equalTo(((self.titleLabel != nil) ? (titleLabel?.snp_bottom)! : self.canvasView.snp_top)).offset(innerDialogPadding)
                make.left.equalTo(self.innerDialogPadding)
                make.right.equalTo(self.innerDialogPadding * -1)
            }
            
            lastElement = self.messageLabel
        }
    }
    
    fileprivate func createButtons(_ lastElement: inout UIView?) {
        if buttons.count > 0 {
            var lastButton: DialogButton?
            for b: DialogButton in self.buttons {
                self.canvasView.addSubview(b)
                
                switch buttonAlignment {
                    
                case .default:
                    b.snp_makeConstraints() { make in
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
                    }
                case .oneRow:
                    b.snp_makeConstraints() { make in
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
                        if lastButton == nil {
                            make.left.equalTo(self.innerDialogPadding)
                        }
                        else {
                            make.left.equalTo((lastButton?.snp_right)!).offset(buttonPadding)
                        }
                        make.width.equalTo(((dialogViewWidth - (2 * innerDialogPadding) - (CGFloat(buttons.count - 1) * buttonPadding)) / CGFloat(buttons.count)))
                        make.height.equalTo(self.buttonHeight)
                    }
                }
            
                lastButton = b
                
                lastElement = b
            }
        }
    }
    
    fileprivate func showViews() {
        curtainView.isHidden = false
        canvasView.isHidden = false
        
        UIView.animate(withDuration: self.animationDuration, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
            self.curtainView.alpha = 1
            self.canvasView.alpha = 1
            }) { (completed: Bool) -> Void in
                
        }
    }
    
    open func hide(_ animated: Bool) {
        isShown = false
        if animated == true {
            UIView.animate(withDuration: self.animationDuration, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
                self.curtainView.alpha = 0;
                self.canvasView.alpha = 0;
                }, completion: { (completed: Bool) -> Void in
                    self.curtainView.isHidden = true
                    self.canvasView.isHidden = true
                    self.removeFromSuperview()
                }
            )
        }
        else {
            self.hide()
        }
    }
    
    open func hide() {
        isShown = false
        curtainView.alpha = 0;
        canvasView.alpha = 0;
        curtainView.isHidden = true
        canvasView.isHidden = true
        self.removeFromSuperview()
    }
    
    // MARK: Configuring view
    
    open func setTopImage(_ image: UIImage) -> UIImageView {
        topImageView = imageView(image: image)
        return topImageView!
    }
    
    open func setTitle(_ titleString: String, attributes: [String: AnyObject] = [String: AnyObject]()) -> UILabel {
        self.title = titleString
        self.titleAttributes = attributes
        
        self.titleLabel = self.label(self.title!, textAttributes: self.titleAttributes, bold: true)
        return self.titleLabel!
    }
    
    open func setMessage(_ messageString: String, attributes: [String: AnyObject] = [String: AnyObject]()) -> UILabel {
        self.message = messageString
        self.messageAttributes = attributes
        
        self.messageLabel = self.label(self.message!, textAttributes: self.messageAttributes, bold: false)
        return self.messageLabel!
    }
    
    open func addButton(_ button: DialogButton) {
        buttons.append(button)
        canvasView.addSubview(button)
    }
    
    open func addButton(_ title: String, textColor: UIColor = UIColor.white, backgroundColor: UIColor = UIColor.gray, highlightedBackgroundColor: UIColor = UIColor.lightGray, cornerRadius: CGFloat = 4) -> DialogButton {
        let button: DialogButton = DialogButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.defaultBackgroundColor = backgroundColor
        button.highlightedBackgroundColor = backgroundColor
        button.dialogView = self
        
        self.addButton(button)
        
        return button
    }
    
    open func addButton(_ title: String, type: DialogButtonType) -> DialogButton {
        var textColor: UIColor?
        var backgroundColor: UIColor?
        var highlightedBackgroundColor: UIColor?
        
        switch (type) {
        case .accept:
            textColor = UIColor.white
            backgroundColor = UIColor.init(colorLiteralRed: (16 / 255), green: (182 / 255), blue: (113 / 255), alpha: 1)
            highlightedBackgroundColor = UIColor.lightGray
            break
        case .destruct:
            textColor = UIColor.white
            backgroundColor = UIColor.init(colorLiteralRed: (195 / 255), green: (36 / 255), blue: (39 / 255), alpha: 1)
            highlightedBackgroundColor = UIColor.darkGray
            break
        case .done:
            textColor = UIColor.white
            backgroundColor = UIColor.gray
            highlightedBackgroundColor = UIColor.darkGray
            break
        default:
            textColor = UIColor.white
            backgroundColor = UIColor.lightGray
            highlightedBackgroundColor = UIColor.lightGray
            break
        }
        
        return self.addButton(title, textColor: textColor!, backgroundColor: backgroundColor!, highlightedBackgroundColor: highlightedBackgroundColor!)
    }
    
    // MARK: Layout
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // MARK: Curtain
        self.curtainView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: Creating elements
    
    fileprivate func imageView(image: UIImage?) -> UIImageView {
        let imgView = UIImageView(image: image)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }
    
    fileprivate func label(_ text: String, textAttributes: [String: AnyObject]?, bold: Bool = false) -> UILabel {
        let label: UILabel = UILabel()
        
        var attributes: [String: AnyObject]? = textAttributes
        
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.numberOfLines = 0
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        if attributes == nil {
            attributes = [String: AnyObject]()
        }
        if attributes![NSFontAttributeName] == nil {
            attributes![NSFontAttributeName] = (bold ? UIFont.boldSystemFont(ofSize: 18) : UIFont.systemFont(ofSize: 14))
        }
        if attributes![NSForegroundColorAttributeName] == nil {
            attributes![NSForegroundColorAttributeName] = UIColor.darkGray
        }
        if attributes![NSBackgroundColorAttributeName] == nil {
            attributes![NSBackgroundColorAttributeName] = UIColor.clear
        }
        attributedString.addAttributes(attributes!, range: NSRange.init(location: 0, length: text.characters.count))
        
        label.attributedText = attributedString
        
        return label
    }
    
    fileprivate func addCurtainView() {
        self.addSubview(self.curtainView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DialogView.didTapCurtain(_:)))
        self.curtainView.addGestureRecognizer(tap)
    }
    
    fileprivate func addCanvasView() {
        self.canvasView.layer.cornerRadius = 4
        self.canvasView.backgroundColor = UIColor.white
        
        self.addSubview(self.canvasView)
    }
    
    fileprivate func addSubviews() {
        self.addCurtainView()
        self.addCanvasView()
    }
    
    // MARK: Actions
    
    func didTapCurtain(_ sender: UITapGestureRecognizer) {
        if (self.tapOnCurtainClosesDialog) {
            self.hide(true)
        }
    }

    // MARK: Initialization
    
    convenience init(buttonAlignment: DialogViewButtonAlignment) {
        self.init(frame:CGRect.zero)
        self.buttonAlignment = buttonAlignment
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


open class DialogCurtainView : UIView {
    
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


open class DialogButton : UIButton {
    
    internal var defaultBackgroundColor: UIColor!
    internal var highlightedBackgroundColor: UIColor!
    
    open var dialogView: DialogView!
    
}
