//
//  MainViewController.swift
//  mailbox
//
//  Created by Ida Leung on 9/25/14.
//  Copyright (c) 2014 test. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var inboxMessage: UIImageView!
    @IBOutlet weak var msgScroll: UIScrollView!
    @IBOutlet weak var getZero: UIImageView!
    @IBOutlet weak var searchView: UIImageView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var menuView: UIImageView!
    
    var inboxMessageCenter: CGPoint!
    var msgViewCenter: CGPoint!
    var loadCount = 0
    
    let gray   = UIColor(red: 0.749, green: 0.749, blue: 0.749, alpha: 1)
    let green  = UIColor(red: 0.384, green: 0.851, blue: 0.384, alpha: 1)
    let red    = UIColor(red: 0.937, green: 0.329, blue: 0.047, alpha: 1)
    let yellow = UIColor(red: 1, green: 0.827, blue: 0.125, alpha: 1)
    let brown  = UIColor(red: 0.746, green: 0.651, blue: 0.459, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        msgScroll.contentSize.height = getZero.frame.height + searchView.frame.height + inboxMessage.frame.height + feedView.frame.height + 30
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "menuSwipeGesture:")
        edgeGesture.edges = UIRectEdge.Left
        msgView.addGestureRecognizer(edgeGesture)

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        if loadCount > 0 {
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.inboxMessage.backgroundColor = self.yellow
                self.inboxMessage.frame.origin.y -= self.inboxMessage.frame.height
                self.feedView.frame.origin.y -= self.inboxMessage.frame.height
            })
        }
    }
    
    // MENU SWIPE
    @IBAction func menuSwipeGesture(menuSwipe: UIScreenEdgePanGestureRecognizer) {
        var location = menuSwipe.locationInView(view)
        var translation = menuSwipe.translationInView(view)
        var velocity = menuSwipe.velocityInView(view)
        
        if menuSwipe.state == UIGestureRecognizerState.Began {
            menuView.alpha = 1
            msgViewCenter = msgView.center
            println("start")
            
        } else if menuSwipe.state == UIGestureRecognizerState.Changed {
            msgView.center.x = translation.x + msgViewCenter.x
            println("test")
            
        }
        else if menuSwipe.state == UIGestureRecognizerState.Ended {
            if velocity.x < 0 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.msgView.center.x = self.msgViewCenter.x
                })
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.msgView.frame.origin.x = 280
                })

            }

        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MESSAGE SWIPE
    @IBAction func onSwipeCell(gestureRecognizer: UIPanGestureRecognizer) {
        var location = gestureRecognizer.locationInView(view)
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        
        var inboxMessageRight = inboxMessage.center.x + inboxMessage.frame.width/2
        var inboxMessageLeft = inboxMessage.center.x - inboxMessage.frame.width/2
        var messagePanel = inboxMessage.frame.origin.x
        
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            inboxMessageCenter = inboxMessage.center
            laterIcon.alpha = 0
            archiveIcon.alpha = 0
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            // println("changed")
            // rintln("inbox moved by : \(translation.x) pixels")
            
            inboxMessage.center.x = translation.x + inboxMessageCenter.x
            
            
            if (messagePanel >= -320) && (messagePanel < -260 ) {
                UIView.animateWithDuration(0.0, animations: { () -> Void in
                    self.laterIcon.alpha = 1
                    self.laterIcon.image = UIImage(named: "list_icon")
                    self.backgroundView.backgroundColor = self.brown
                    self.laterIcon.frame.origin.x = inboxMessageRight + 10
                })
                println("farend")
                
            } else if (messagePanel >= -260) && (messagePanel < -60 ) {
                UIView.animateWithDuration(0.0, animations: { () -> Void in
                    self.laterIcon.alpha = 1
                    self.backgroundView.backgroundColor = self.yellow
                    self.laterIcon.frame.origin.x = inboxMessageRight + 10
                })
                println("middle")
                
                
            } else if (messagePanel >= -60) && (messagePanel < 0 ) {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.laterIcon.alpha = 1
                    self.backgroundView.backgroundColor = self.gray
                    self.laterIcon.frame.origin.x = 287
                })
                println("starting")
            
            } else if (messagePanel >= 0) && (messagePanel < 60 ) {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.archiveIcon.alpha = 0.5
                    self.backgroundView.backgroundColor = self.gray
                    self.archiveIcon.frame.origin.x = 8
                })
                println("right start")
            
            } else if (messagePanel >= 60) && (messagePanel < 260 ){
                UIView.animateWithDuration(0.0, animations: { () -> Void in
                    self.archiveIcon.alpha = 1
                    self.backgroundView.backgroundColor = self.green
                    self.archiveIcon.frame.origin.x = inboxMessageLeft - 30
                })
                println("right mid")
            
            } else if (messagePanel >= 260) && (messagePanel < 320 ){
                UIView.animateWithDuration(0.0, animations: { () -> Void in
                    self.archiveIcon.alpha = 1
                    self.archiveIcon.image = UIImage(named: "delete_icon")
                    self.backgroundView.backgroundColor = self.red
                    self.archiveIcon.frame.origin.x = inboxMessageLeft - 30
                })
                println("right end")
                
            }
            
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            if (messagePanel >= -320) && (messagePanel < -260 ) {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxMessage.frame.origin.x = -320
                    self.laterIcon.frame.origin.x = -320
                    self.laterIcon.alpha = 0
                    self.archiveIcon.alpha = 0}
                    , completion: {(Bool) -> Void in
                    self.performSegueWithIdentifier("listSegue", sender: self)
                    self.loadCount += 1
                })
                
            } else if (messagePanel >= -260) && (messagePanel < -60 ) {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxMessage.frame.origin.x = -320
                    self.laterIcon.frame.origin.x = -320
                    self.laterIcon.alpha = 0
                    self.archiveIcon.alpha = 0}
                    , completion: {(Bool) -> Void in
                        self.performSegueWithIdentifier("laterSegue", sender: self)
                        self.loadCount += 1
                })
                
            } else if (messagePanel >= -60) && (messagePanel < 0 ) {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxMessage.frame.origin.x = 0
                    self.laterIcon.frame.origin.x = 287
                    self.laterIcon.alpha = 0
                    self.archiveIcon.alpha = 0
                })

                
            } else if (messagePanel >= 0) && (messagePanel < 60 ) {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxMessage.frame.origin.x = 0
                    self.archiveIcon.frame.origin.x = 8
                    self.laterIcon.alpha = 0
                    self.archiveIcon.alpha = 0
                })
                
            } else if (messagePanel >= 60) && (messagePanel < 260 ){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxMessage.frame.origin.x = 320
                    self.archiveIcon.frame.origin.x = 320
                    self.laterIcon.alpha = 0
                    self.archiveIcon.alpha = 0
                })
                
            } else if (messagePanel >= 260) && (messagePanel < 320 ){
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.inboxMessage.frame.origin.x = 320
                    self.archiveIcon.frame.origin.x = 320
                    self.laterIcon.alpha = 0
                    self.archiveIcon.alpha = 0
                })
                
            }
            
         }

    }
    
    func closeMessage (){
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.feedView.frame.origin.y = 108
            }) {(finished: Bool) -> Void in
                self.inboxMessage.alpha = 0
                self.msgScroll.contentSize.height -= self.inboxMessage.frame.height
        }
    }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

