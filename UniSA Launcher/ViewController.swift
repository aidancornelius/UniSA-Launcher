//
//  ViewController.swift
//  Quick Launcher
//
//  Created by Aidan Cornelius-Bell on 13/8/20.
//  Copyright © 2020 Aidan Cornelius-Bell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate, NSSearchFieldDelegate, NSWindowDelegate {
    
    @IBOutlet weak var UOSearchText: NSSearchField!
    @IBOutlet weak var LOSearchText: NSSearchField!
    @IBOutlet weak var directorySearch: NSSearchField!

    @IBAction func searchUOTopics(_ sender: Any) {
        NSLog(UOSearchText.stringValue)
        
        if let url = URL(string: "https://uo.unisa.edu.au/course/search.php?search="+UOSearchText.stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! ?? ""), NSWorkspace.shared.open(url) {
            cleanUp()
        }
    }
    
    @IBAction func searchLOTopics(_ sender: Any) {
        NSLog(LOSearchText.stringValue)
        
        if let url = URL(string: "https://lo.unisa.edu.au/course/search.php?search="+LOSearchText.stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! ?? ""), NSWorkspace.shared.open(url) {
            cleanUp()
        }
    }
    
    @IBAction func searchPeople(_ sender: Any) {
        NSLog(directorySearch.stringValue)
        
        var theUrl = "https://people.unisa.edu.au/" + directorySearch.stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! ?? ""
        
        if let url = URL(string: theUrl), NSWorkspace.shared.open(url) {
            cleanUp()
        }
    }
    
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if control.tag == 0 {
            if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
                // Do something against ENTER key
                searchUOTopics(self)
                return true
            } else {
                return false
            }
        } else if control.tag == 1 {
            if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
                searchLOTopics(self)
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
            return false
        }
    }
    
    func cleanUp() {
        // Empty our search fields and close the window
        UOSearchText.stringValue = ""
        LOSearchText.stringValue = ""
        directorySearch.stringValue = ""
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
