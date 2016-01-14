//
//  Requests.swift
//  NetworkPut
//
//  Created by amela on 27/11/15.
//  Copyright © 2015 amela. All rights reserved.
//

import Foundation
import Security

class Request: NSObject, NSURLSessionDelegate {
    
   
    // MARK: -  Def. Singelton
    
    static let sharedRequest = Request()
    
   
    // MARK: -  Get & Put Functions
    
    func getData(myUrl: String, handler: (String?) -> () ) {
        let request = NSMutableURLRequest()
        
        request.URL = NSURL(string: myUrl)
        
        //request.URL = NSURL(string: "https://google.com")
        request.HTTPMethod = "GET"
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            print("Session runnung.")
            if error != nil {
                print(error)
                handler(nil)
                
            } else {
                let result = NSString(data: data!, encoding:
                    NSASCIIStringEncoding)!
                handler(result as String)
            }
        }
        //let task =  session.dataTaskWithRequest(request)
        
        task.resume()
    }
    
    func putData(state: String, myUrl: String, handler: () -> Void) {
        let request = NSMutableURLRequest()
        
        request.URL = NSURL(string: myUrl)
        request.HTTPMethod = "PUT"
        
        let data = NSString(string: state).dataUsingEncoding(NSASCIIStringEncoding)
        request.HTTPBody = data!
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            print("Session runnung.")
            if error != nil {
                print(error)
                
            } else {
                //print("imam rezultat")
                //let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!
                handler()
                //print("konec handlerja")
            }
        }
        //let task =  session.dataTaskWithRequest(request)
        
        task.resume()
        
        print("lala")
    }

    
    // MARK: - Test Certificate
    
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
        print("v delegatu sem")
        
        let serverTrust = challenge.protectionSpace.serverTrust
        let certificate = SecTrustGetCertificateAtIndex(serverTrust!, 0)
        let remoteCertificateData = SecCertificateCopyData(certificate!)
        
        let cerPath = NSBundle.mainBundle().pathForResource("servercert", ofType: "der", inDirectory: ".")
        let localCertData = NSData(contentsOfURL: NSURL(fileURLWithPath: cerPath!))
        
        //print(localCertData)
        //print(remoteCertificateData   )
        
        if remoteCertificateData == localCertData {
            let credential = NSURLCredential(forTrust: serverTrust!)
            challenge.sender?.useCredential(credential, forAuthenticationChallenge: challenge)
            completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, credential)
            print("certificate: approved")
            
        } else {
            challenge.sender?.cancelAuthenticationChallenge(challenge)
            completionHandler(NSURLSessionAuthChallengeDisposition.CancelAuthenticationChallenge, nil)
            //completionHandler(NSURLSessionAuthChallengeDisposition.RejectProtectionSpace, nil)
            print("certificate: rejected")
        }
    }
    
    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        print (error)
    }
}