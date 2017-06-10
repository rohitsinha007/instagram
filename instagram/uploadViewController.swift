//
//  uploadViewController.swift
//  instagram
//
//  Created by admin on 09/06/17.
//  Copyright © 2017 bang. All rights reserved.
//

import UIKit
import ImagePicker
import Alamofire

class uploadViewController: UIViewController, ImagePickerDelegate
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let imagePicker = ImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }

    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage])
    {
        self.dismiss(animated: true, completion: nil)
        let url = try! URLRequest(url: "api.petoye.com/feeds/2/create", method: .post)
        Alamofire.upload(multipartFormData: { (data) in
            
            let image = UIImagePNGRepresentation(images[0])
            data.append(image!, withName: "Image", fileName: "test.png", mimeType: "image/png")
            let parameter = ["message": "Hello"]
            for (key,value) in parameter
            {
                data.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, with: url) { (result) in
            
            switch result
            {
            case .success(let upload,_,_):
            print("Success")
                
            default: break
            }
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
    }


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
