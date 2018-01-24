//
//  ViewController.swift
//  URLSessionRequest
//
//  Created by Alugbin LordRahl Abiodun Olutola on 23/01/2018.
//  Copyright © 2018 Alugbin LordRahl Abiodun Olutola. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var userList: UITableView!
    var TableItems=[String:String]()
    var TableData:[[String:String]]=[[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userList.dataSource=self
        
    }
    
    
    @IBAction func onGetTapped(_ sender: UIButton) {
        guard let url=URL(string: "https://jsonplaceholder.typicode.com/users") else {return}
        let session=URLSession.shared
        let task=session.dataTask(with: url) { (data, response, error) in
            if let data=data{
                do{
                    let jsonData=try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
                    
                    for json in jsonData!{
                        let element = json as? [String:Any]
                        let name=element!["name"]
                        let email=element!["email"]
                        
                        print("Name is: \(name!), Email is: \(email!)")
                        self.TableData.append(["name":"\(name!)","email":"\(email!)"])
                    }
                    
                    self.userList.reloadData()
                }
                catch{
                    print("Invalid Response gotten \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    @IBAction func onPostTapped(_ sender: UIButton) {
    }

    
    @IBAction func newUserAccount(_ sender: UIButton) {
        
    }
    
    
    //============DataSource protocol functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let rowInfo=TableData[indexPath.row]
        print(rowInfo)
        let name=rowInfo["name"]
        let email=rowInfo["email"]
        cell.textLabel?.text=name
        cell.detailTextLabel?.text=email
        return cell
    }

}

