//
//  ViewController.swift
//  GCDSamples
//
//  Created by Gabriel Theodoropoulos on 07/11/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         //simpleQueues()
        
        //queuesWithQoS()
        
        
         concurrentQueues()
         if let queue = inactiveQueue {
            queue.activate()
         }
        
        
        // queueWithDelay()
        
        // fetchImage()
        
        // useWorkItem()
    }
    
    
    
    func simpleQueues() {
        
        let queue = DispatchQueue(label: "com.nvovap.myqueue")
        
        queue.async {
            for i in 0..<10 {
                print("🔴 ", i)
            }
        }
        
        
        let queueT2 = DispatchQueue(label: "com.nvovap.myqueue2")
        
        queueT2.async {
            for i in 0..<10 {
                print("🔵 ", i)
            }
        }
        
        
        queue.sync {
            for i in 0..<10 {
                print("🔶 ", i)
            }
        }
        
        for i in 100..<110 {
            print("Ⓜ️ ", i)
        }
        
        
        
        
    }
    
    
    func queuesWithQoS() {
        let queue1 = DispatchQueue(label: "com.nvovap.queue1", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.nvovap.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0..<10 {
                print("🔴 ", i)
            }
        }
        
        
        queue2.async {
            for i in 100..<110 {
                print("🔵 ", i)
            }
        }
        
        for i in 1000..<1010 {
            print("Ⓜ️", i)
        }
        
    }
    
    
    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
        let anotherQueue = DispatchQueue(label: "com.nvovap.anotherQueue", qos: .utility, attributes: [.initiallyInactive, .concurrent])
        
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 0..<10 {
                 print("🔴 ", i)
            }
        }
        
        anotherQueue.async {
            for i in 100..<110 {
                print("🔵 ", i)
            }
        }
        
        anotherQueue.async {
            for i in 1000..<1010 {
                print("⚫️ ", i)
            }
        }
        
    }
    
    
    func queueWithDelay() {
        
    }
    
    
    func fetchImage() {
        
    }
    
    
    func useWorkItem() {
        
    }
}

