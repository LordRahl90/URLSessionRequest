//
//  PostViewController.swift
//  URLSessionRequest
//
//  Created by Alugbin LordRahl Abiodun Olutola on 23/01/2018.
//  Copyright © 2018 Alugbin LordRahl Abiodun Olutola. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.topItem?.title="Hello World"
        // Do any additional setup after loading the view.
    }


    @IBAction func onPostTapped(_ sender: UIButton) {
        
        let parameters=["username":"@LordRahl90", "tweet":"Hello World!!!"]
        guard let url=URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        var request=URLRequest(url: url)
        request.httpMethod="POST"
        guard let httpBody=try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody=httpBody
        
        let session=URLSession.shared
        let task=session.dataTask(with: request) { (data, response, error) in
            if let data=data{
                do{
                    let json=try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }
                catch{
                    print(error)
                }
            }
        }
        
        task.resume()
    }

}
