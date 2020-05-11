//
//  PhotoViewController.swift
//  fnet
//
//  Created by Georges on 08/05/2020.
//  Copyright © 2020 Nomicos. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    var takenPhoto: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var displayText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let availableImage = takenPhoto {
            imageView.image = availableImage
            
            let postRequest = APIRequest(endpoint: "inference")
            
            postRequest.sendImage(image: availableImage, completionHandler: { data, error in
                switch error {
                    case .allow:
                        print("Succesfully sent data")
                    case .cancel:
                        print("Failed sending data")
                    default:
                        print("Unknown error")
                    }
                guard let returnData = data else {
                    print("No data available")
                    return
                }
                DispatchQueue.main.async {
                    self.displayText.text = returnData
                    print(returnData)
                }
            })
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
