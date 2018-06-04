//
//  ViewController.swift
//  Guardian
//
//  Created by Edwardchen on 19/5/18.
//  Copyright © 2018 Edwardchen. All rights reserved.
//

import UIKit
import MapKit
import MessageUI
import AVFoundation

class TimeGuardian: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        switch result{
        case .sent:
            print("Message Sent")
        case .cancelled:
            print("Message Cancelled")
        case .failed:
            print("Fail to sent the message")
        // Get the result of sending messages
        }
    }
    
    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var labelVal: UILabel!
    
    let locationManager = CLLocationManager()
    var currentLongitude = "";
    var currentLatitude = "";
    var setTime = 0;
    var hour = 0;
    var min = 0;
    var sec = 0;
    var showTime = "";
    var timer : Timer!;
    var des = "";
    var emerNum = "";
    var userName = "";
    var emerName = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Ask allowence of using GPS
        self.locationManager.requestWhenInUseAuthorization()
        // Estimate if the locationservice is on
        if CLLocationManager.locationServicesEnabled(){
            // Start locating the user
            locationManager.delegate = self
            mapKitView.showsUserLocation = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        hour = setTime/3600;
        min = (setTime - hour*3600)/60;
        sec = 0;
        showTime = "Time Left: "+String(hour)+" : "+String(min)+" : "+String(sec);
        timeLeft.text = showTime;
        // Present the set time
        timer = Timer.scheduledTimer(timeInterval: 1 ,target:self, selector: #selector(self.timeCount), userInfo: nil, repeats: true)
        // Set the timer, call the timeCount function every second
    }
    
    @objc func timeCount() {
        if sec != 0 {
            sec -= 1;
        }
        if sec == 0 {
            if min != 0 {
                sec = 59;
                min -= 1;
            }
            else {
                if hour != 0 {
                    hour -= 1;
                    min = 59;
                    sec = 59
                }
                else {
                    timer.invalidate()
                    let lastView = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    let alertController1 = UIAlertController(title:"A message has been sent to your emergency contact", message:nil, preferredStyle: .alert)
                    self.present(alertController1, animated: true, completion: nil)
                    let okAction1 = UIAlertAction(title: "Confirm", style: .cancel, handler: {
                        action in
                        self.present(lastView, animated: true, completion: nil)
                    })
                    alertController1.addAction(okAction1)
                    // If the time runs out, end the timer, present the alert message and after click the confirm button, the application will go back to the main page
                }
            }
        }
        showTime = "Time Left "+String(hour)+" : "+String(min)+" : "+String(sec);
        timeLeft.text = String(showTime)
        // Present the rest time
    }
    
    @IBAction func newOne(_ sender: Any) {
        timer.invalidate()
        // If click the one tap sos button, the timer will stop
        let controller = MFMessageComposeViewController()
        userName = UserDefaults.standard.string(forKey: "userName")!;
        emerName = UserDefaults.standard.string(forKey: "emerName")!;
        emerNum = UserDefaults.standard.string(forKey: "emerNum")!;
        // Get the saved user information
        controller.body = "Hi " + emerName + ", I " + userName + " am in danger! My current Longitude is:" + currentLongitude + ", current Latitude is:" + currentLatitude + ". And I was going to " + des + ". Check my situation now! "
        // Set the content of the message
        controller.recipients = [self.emerNum]
        // Set the destination number of your message
        controller.messageComposeDelegate = self
        self.present(controller, animated: true, completion: nil)
        // Present the message interface
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         // Get user's coordinate
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        currentLongitude = String(locValue.longitude);
        currentLatitude = String(locValue.latitude);
        // Relocate user's coordinate when it changed
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 600, 600)
        // Update mapview
        mapKitView.setRegion(viewRegion,animated:true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func emergencyLight(_ sender: Any) {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if (device != nil) {
            if (device!.hasTorch) {
                do {
                    try device!.lockForConfiguration()
                    if (device!.torchMode == AVCaptureDevice.TorchMode.on)
                        // Turn on the flashlight
                    {
                        device!.torchMode = AVCaptureDevice.TorchMode.off
                        // Turn off the flashlight
                    } else {
                        do {
                            try device!.setTorchModeOn(level: 1.0)
                            // Set flashlight
                        } catch {
                            print(error)
                        }
                    }
                    
                    device!.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
}

