# DialogView
Highly customisable dialog (alert) view made in swift


![Alt text](/relative/path/to/img.jpg?raw=true "Optional Title")


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