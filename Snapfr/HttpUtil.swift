//
//  HttpUtil.swift
//  Snapfr
//
//  Created by Rommel Suarez on 22/8/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class HttpUtil {
    
    
    func  sendRequest(params : Dictionary<String, AnyObject>,method: String, url : String, completion:(NSData!, NSError!) -> Void) -> () {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = method
        var err: NSError? = nil
      
        
        if params.count > 0 {
            do {
                
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            } catch let error as NSError {
                err = error
                request.HTTPBody = nil
            }
        }
       
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error -> Void in
         
          do {
            
     
                if error != nil {
               
                    completion(nil, error)
                
                    return
                }
            
               if let httpResponse =  response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completion(data, nil)
                    } else {
                        if let errorDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                            let responseError : NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: errorDict as? [NSObject : AnyObject])
                            completion(nil, responseError)
                        }
                    }
                }
            
          }catch{
           completion(nil, nil)
          }
       })
            
        
     
    
            // start the task
            task.resume()
    
    }
    
    
    
    
    func  sendUploadRequest(params : Dictionary<String, AnyObject>,imageData:NSData,imageKey:String,method: String, url : String, completion:(NSData!, NSError!) -> Void) -> () {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = method
        
        
        let boundary = generateBoundaryString()
        
       
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = createBodyWithParameters(params, filePathKey: imageKey, imageDataKey: imageData, boundary: boundary)
        
        
        
        
        let  task = session.dataTaskWithRequest(request, completionHandler: { data, response, error -> Void in
            
             do {
            
                if error != nil {
                
                    completion(nil, error)
                
                    return
                }
            
           
                if let httpResponse =  response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completion(data, nil)
                    } else {
                        var _:NSError?
                        if let errorDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                            let responseError : NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: errorDict as? [NSObject : AnyObject])
                            completion(nil, responseError)
                        }
                    }
                }
                
             }catch{
                print(error)
            }
 
        })
        
            
        
        
        
        // start the task
        task.resume()
        
    }
    

    
    func createBodyWithParameters(parameters:Dictionary<String, AnyObject>, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        
    
        
        if !parameters.isEmpty  {
            for (key, value) in parameters {
                body.appendString("--\(boundary)\r\n")
                body.appendString ("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    

    func jsonReposnseParser(responseDict:NSDictionary) -> ResponseMessage {
        
        
        print(responseDict)
       
        
        let responseMessage = ResponseMessage()
        
        if let code = responseDict["code"] as? String {
            
            if code == "00" {
                 responseMessage.code = ResponseStatus.Failed
            }else if code == "01" {
                responseMessage.code = ResponseStatus.Success
            }else if code == "02" {
                responseMessage.code = ResponseStatus.Record_Not_Found
            }else if code == "03" {
                responseMessage.code = ResponseStatus.Update_Failed
            }

           
        }
        
        if let message = responseDict["message"] as? String {
            responseMessage.message = message
        }
        
        if let data = responseDict["data"] as? NSDictionary {
            responseMessage.data = data
        }
        
        if let data = responseDict["data"] as? NSArray {
            responseMessage.dataCollection = data
        }
        
        if let error = responseDict["error"] as? NSDictionary {
            responseMessage.error = error
        }
       
        return responseMessage;
    }

}


extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
