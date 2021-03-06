//
//  PlanBViewController.swift
//  PlanB
//
//  Created by 王迺瑜 on 2017/6/11.
//  Copyright © 2017年 AppWorksHackathon. All rights reserved.
//

import UIKit

class PlanBTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!

}

class PlanBViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let planBLists: [[String : Any]] = []
    let activityId: Int!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return planBLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PlanBTableViewCell = tableView.dequeueReusableCell(withIdentifier: "planBCell", for: indexPath) as! PlanBTableViewCell
        
        cell.topView.layer.cornerRadius = cell.topView.bounds.width / 2
        cell.bigView.layer.cornerRadius = 10
        cell.rejectButton.layer.cornerRadius = 8
        cell.acceptButton.layer.cornerRadius = 8
        cell.rejectButton.addTarget(self, action: #selector(reject(sender:)), for: .touchUpInside)
        cell.acceptButton.addTarget(self, action: #selector(accept(sender:)), for: .touchUpInside)
        cell.rejectButton.tag = indexPath.row
        cell.acceptButton.tag = indexPath.row
        
        cell.titleLabel.text = self.activities[indexPath.row]["title"] as? String ?? "----"
        cell.locationLabel.text = self.activities[indexPath.row]["actPlace"] as? String ?? "----"
        cell.descriptionLabel.text = self.activities[indexPath.row]["description"] as? String ?? "----"
        
        switch self.activities[indexPath.row]["type"] as? String ?? "----" {
            
        case "movie":
            cell.tagImage.image = UIImage(named: "movie")
            
        case "food":
            cell.tagImage.image = UIImage(named: "food")
            
        case "outdoor":
            cell.tagImage.image = UIImage(named: "outdoor")
            
        case "sport":
            cell.tagImage.image = UIImage(named: "sport")
            
        case "shopping":
            cell.tagImage.image = UIImage(named: "shopping")
            
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    
    func reject(sender: UIButton) {
        
        let alert = UIAlertController(title: "Whaaaaaaaat", message: "There is always a plan B, but you reject it", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "我知錯了", style: .default, handler: {
        
            let myActivityVC = MyActivityViewController()
            self.present(MyActivityViewController, animated: true, completion: {
            self.dismiss(animated: true, completion: nil)
            })
        })
        print("reject")
    }
    
    func accept(sender: UIButton) {
        
        let planB = planBLists[sender.tag]
        UserManager.shared.activities[activityId] = planB
        
        let alert = UIAlertController(title: "Fantastic", message: "There is always a plan B, and you accept it", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "帶我走", style: .default, handler: {
            
            let myActivityVC = MyActivityViewController()
            self.present(MyActivityViewController, animated: true, completion: {
            self.dismiss(animated: true, completion: nil)
            })
        })
        print("accpet")
    }
}
