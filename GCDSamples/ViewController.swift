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
        
        
//         concurrentQueues()
//         if let queue = inactiveQueue {
//            queue.activate()
//         }
//        
        
 //        queueWithDelay()
        
//        let globalQueue = DispatchQueue.global(qos: .userInitiated)
//        
//        globalQueue.async {
//            for i in 0..<10 {
//                print("🔴 ", i)
//            }
//        }
        
//         fetchImage()
        
         useWorkItem()
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
        let delayQueue = DispatchQueue(label: "com.nvovap.delayqueue", qos: .userInitiated)
        
        print(Date())
        
        let additionalTime: DispatchTimeInterval = .seconds(2)
        
       // print(Double(additionalTime))
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
        
        delayQueue.asyncAfter(deadline: .now() + 0.75) {
            print(Date())
        }
    }
    
    
    func fetchImage() {
        
        let imageURL: URL = URL(string: "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!
        
        (URLSession(configuration: URLSessionConfiguration.default).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            if let data = imageData {
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
                
            }
        })).resume()
        
    }
    
    
    func useWorkItem() {
        var value = 10
        
        let workItem = DispatchWorkItem { 
            value += 5
            print(value)
        }
        
        
        DispatchQueue.global().async {
            workItem.perform()
        }
        
        
        DispatchQueue.global().async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) { 
            print("Value = ", value)
        }
        
        
    }
}

