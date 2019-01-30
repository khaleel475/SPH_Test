//
//  FirstViewController.swift
//  SPH_Test_Khaleel
//
//  Created by ShivaReddy on 30/01/19.
//  Copyright © 2019 Khaleel. All rights reserved.
//

import UIKit


class HeadlineTableViewCell: UITableViewCell {
    @IBOutlet weak var headLineTitle: UILabel!
    @IBOutlet weak var headLineDescription: UILabel!
    
}

class FirstViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var listTable: UITableView!
    var dataList: [QuarterModal] = []

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Yearly List"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listTable.dequeueReusableCell(withIdentifier: "listTableIdentifier", for: indexPath) as! HeadlineTableViewCell
        
        let quarterModal = self.dataList[indexPath.row]
        
        cell.headLineTitle.text = "Quarter: " + quarterModal.quarter
        cell.headLineDescription.text = "Volume: " + quarterModal.volume

        return cell;

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let session = URLSession.shared

        let todoEndpoint: String = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            // ...
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                if let passDic = todo["result"] as? [String:Any],
                    let innerItem = passDic["records"] as? [Any] {
                    print(innerItem)
                    

                    for obj in innerItem {
                        
                        let quarterModal = QuarterModal()

                        let dic = obj as! [String:Any]
                        
                        print(dic)
                        let num = dic["_id"] as! NSNumber
                        
                        quarterModal.id = num.stringValue
                        quarterModal.quarter = dic["quarter"] as! String
                        quarterModal.volume = dic["volume_of_mobile_data"] as! String
                        self.dataList.append(quarterModal)
                    }

                    DispatchQueue.main.async {
                        self.listTable.reloadData()
                    }

                }

//
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        })
        task.resume()

        self.listTable.reloadData()


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

