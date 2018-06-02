//
//  MasterView.swift
//  Websites
//
//  Created by Macbook on 19.02.18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
var webs = ["Instagram" : "https://Instagram.com", "Google" : "https://Google.com", "VK": "https://VK.com" , "Gmail": "https://Gmail.com"]
var favourites = ["Instagram" : "https://Instagram.com", "Google" : "https://Google.com", "Gmail": "https://Gmail.com"]
class MyCell: UITableViewCell {
    @IBOutlet weak var webName: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    let detail = CustomViewController()
    let master = MasterViewController()
    
    @IBAction func favClick(_ sender: UIButton) {
        if favButton.currentBackgroundImage == UIImage(named: "star.png"){
            favButton.setBackgroundImage(UIImage(named: "star (1).png"), for: .normal)
            favourites[webName.text!] = webs[webName.text!]
            print(favourites)
        }
        else{
            favButton.setBackgroundImage(UIImage(named: "star.png"), for: .normal)
            if webs[webName.text!] == nil{
                webs[webName.text!] = favourites[webName.text!]}
            favourites[webName.text!] = nil
            print(favourites)
            
        }
    }
    
}
class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var webname: String?
    var webaddr: String?
    var one: UITextField?
    var two: UITextField?
    var selectedSegment = 1
    let detail = CustomViewController()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func checkSeg(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectedSegment = 1
        case 1:
            selectedSegment = 2
        default:
            break;
        }
        self.tableView.reloadData()
    }
    func customInit(webname: String, webaddr: String){
        self.webname = webname
        self.webaddr = webaddr
    }
    @IBAction func perf(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Add",
                                                message : "Add new website",
                                                preferredStyle : .alert)
        
        alertController.addTextField(configurationHandler : one )
        alertController.addTextField(configurationHandler: two)
        let okAc = UIAlertAction(title: "Add", style: .default) {
            (alert: UIAlertAction!) -> Void in
            if alertController.textFields![0].text != "" && alertController.textFields![1].text != ""{
                let name1 = alertController.textFields![0]
                let name2 = alertController.textFields![1]
                self.webname = name1.text
                self.webaddr = name2.text
                webs[name1.text!] = name2.text
                self.tableView.reloadData()}
            alertController.dismiss(animated: true, completion: nil)
        }
        let cancelAc = UIAlertAction(title: "Cancel", style: .default) {
            (alert: UIAlertAction!) -> Void in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        present(alertController, animated: true, completion: nil)
        alertController.addAction(okAc)
        alertController.addAction(cancelAc)
    }
    func one(textField: UITextField){
        one = textField
        one?.placeholder = "Enter title"
    }
    func two(textField: UITextField){
        two = textField
        two?.placeholder = "Enter address"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 1{
            return webs.count}
        else{
            return favourites.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1")  as! MyCell
        if selectedSegment == 1{
            cell1.webName?.text = Array(webs)[(indexPath.row)].key
            
            if favourites[cell1.webName.text!] != nil {
                cell1.favButton.setBackgroundImage(UIImage(named: "star (1).png"), for: .normal)
            }
            else{
                cell1.favButton.setBackgroundImage(UIImage(named: "star.png"), for: .normal)
            }
            return cell1}
        else{
            
            cell1.webName?.text = Array(favourites)[(indexPath.row)].key
            if favourites[cell1.webName.text!] != nil {
                cell1.favButton.setBackgroundImage(UIImage(named: "star (1).png"), for: .normal)
            }
            else{
                cell1.favButton.setBackgroundImage(UIImage(named: "star.png"), for: .normal)
            }
            return cell1}
        
        
        
    }
    /*   protocol webSelectionDelegate: class {
     func webSelected(_ newUrl: webs)
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let selectedUrl = Array(webs)[indexPath.row].value
     delegate?.webSelected(selectedUrl)
     }
     */
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            let rightNavController = controllers.last as? UINavigationController
            let detailViewController = rightNavController?.topViewController as? CustomViewController
            if selectedSegment == 1{
                detailViewController?.configureView(urladdr: Array(webs)[indexPath.row].value)
                detailViewController?.title = Array(webs)[indexPath.row].key
                if favourites[Array(webs)[indexPath.row].key] != nil{
                    print ("yeeees")
                    detailViewController?.check = true
                }
                else {
                    detailViewController?.check = false
                    print ("noooo")
                }
                
            }
            else {
                detailViewController?.configureView(urladdr: Array(favourites)[indexPath.row].value)
                detailViewController?.title = Array(favourites)[indexPath.row].key
                
                detailViewController?.check = true
                print("ggggooo")            }
            
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if selectedSegment == 1{
                //  favourites[webName.text!] = nil
                webs[Array(webs)[indexPath.row].key] = nil
                favourites[Array(favourites)[indexPath.row].key] = nil
                
            }
            else{
                favourites[Array(favourites)[indexPath.row].key] = nil
                
            }
            if webs.count == 0 {
                self.tableView.backgroundColor =  UIColor.black
                let alert = UIAlertController(title: "", message: "No Websites", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        } else if editingStyle == .insert {
            
        }
        
    }
}



