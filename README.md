# DialogView
Highly customisable dialog (alert) view made in swift. You can customise pretty much anything prom inner paddings and margins to all colors and views.


![Screenshot 1](https://raw.githubusercontent.com/manGoweb/DialogView/master/_orig/screenshot1.jpg "Screenshot 1")
![Screenshot 2](https://raw.githubusercontent.com/manGoweb/DialogView/master/_orig/screenshot2.jpg "Screenshot 2")


#### Basic usage
``` swift
let alert: DialogView = DialogView()
alert.setTitle("Dialog Title")
alert.setMessage("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a augue eget felis dictum ultrices ac a arcu.")

let button: DialogButton = alert.addButton("Ok", type: .Done)
button.addTarget(self, action: "myAlertAction:", forControlEvents: .TouchUpInside)
alert.showInController(self)
```

#### Advanced usage
``` swift
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
```

#### You can add an image on top of DialogView
``` swift
let alert: DialogView = DialogView()

//Title will be under the image
alert.setTopImage(UIImage(named: "nice_image")!)
//set size of imageView (sizesToFit)
alert.imageSize = CGSizeMake(100, 50)
```

#### You can even have all buttons in one row
``` swift
//just use this constructor:
let alert: DialogView = DialogView(buttonAlignment: .OneRow)

```


#### Installation

DialogView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DialogView"
```

#### Author

Ondrej Rafaj, manGoweb.cz <software@mangoweb.cz>

#### License

DialogView is available under the MIT license. See the LICENSE file for more info.

#### TODO
* Different animations
* Custom controls in the canvas
* More predefined styles
* Any more ideas? :)
