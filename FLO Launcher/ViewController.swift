//
//  ViewController.swift
//  FLO Launcher
//
//  Created by Aidan Cornelius-Bell on 13/8/20.
//  Copyright © 2020 Aidan Cornelius-Bell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate, NSSearchFieldDelegate, NSWindowDelegate {
    
    @IBOutlet weak var topicSearchtext: NSSearchField!
    @IBOutlet weak var topicIdentifier: NSSearchField!
    @IBOutlet weak var directorySearch: NSSearchField!
    @IBOutlet weak var topicSearchStuSys: NSSearchField!
    
    @IBAction func jumpToTopics(_ sender: Any) {
        NSLog(topicIdentifier.stringValue)
        
        
        if let url = URL(string: "https://flo.flinders.edu.au/course/view.php?id="+topicIdentifier.stringValue), NSWorkspace.shared.open(url) {
            print("Default browser was successfully opened")
            cleanUp()
        }
    }
    
    @IBAction func searchTopics(_ sender: Any) {
        NSLog(topicSearchtext.stringValue)
        
        if let url = URL(string: "https://flo.flinders.edu.au/course/search.php?search="+topicSearchtext.stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! ?? ""), NSWorkspace.shared.open(url) {
            print("Default browser was successfully opened")
            cleanUp()
        }
    }
    
    @IBAction func searchPeople(_ sender: Any) {
        NSLog(directorySearch.stringValue)
        
        var theUrl = "https://www.flinders.edu.au/people?q=" + directorySearch.stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! ?? ""
        theUrl = theUrl + "#results-search-response"
        
        if let url = URL(string: theUrl), NSWorkspace.shared.open(url) {
            print("Default browser was successfully opened")
            cleanUp()
        }
    }
    
    @IBAction func searchTopicsStuSys(_ sender: Any) {
        NSLog(topicSearchStuSys.stringValue)
        
        let theUrl = "https://www.flinders.edu.au/webapps/stusys/index.cfm/topic/main/?topic=" + topicSearchStuSys.stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url = URL(string: theUrl), NSWorkspace.shared.open(url) {
            print("Default browser was successfully opened")
            cleanUp()
        }
    }
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if control.tag == 0 {
            if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
                // Do something against ENTER key
                jumpToTopics(self)
                return true
            } else {
                return false
            }
        } else if control.tag == 1 {
            if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
                searchTopics(self)
                return true
            } else {
                return false
            }
        } else if control.tag == 2 {
            if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
                searchPeople(self)
                return true
            } else {
                return false
            }
        } else {
            if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
                searchTopicsStuSys(self)
                return true
            } else {
                return false
            }
        }
    }
    
    func cleanUp() {
        // Empty our search fields and close the window
        topicSearchtext.stringValue = ""
        topicIdentifier.stringValue = ""
        directorySearch.stringValue = ""
        topicSearchStuSys.stringValue = ""
        self.view.window?.close()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.delegate = self
    }

    override var representedObject: Any? {
        didSet {
        }
    }


}

extension ViewController {
    static func freshController() -> ViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("ViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
          fatalError("No VC available.")
        }
        return viewcontroller
    }
}
