//
//  PerformanceViewController.swift
//  CoreAnimationDemo
//
//  Created by hao on 2017/3/20.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    lazy var firstNameList: [String] = {
        return ["杨", "黄", "谢", "李", "王",
                "钱", "石", "孙", "陈", "蔡"]
    }()
    
    lazy var lastNameList: [String] = {
        return ["昊", "冰", "洪飞", "蓉",
                "靖", "浩", "娜娜", "嘉贤"]
    }()
    
    lazy var avatarList = {
        return ["04_00_01", "04_00_02",
                "04_00_03", "04_00_04",
                "04_00_05", "04_00_06"]
    }()
    
    var randomPeopleList: [[String:String]] = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for _ in 0...1000 {
            randomPeopleList.append(["name" : randomName(), "avatar" : randomAvatar()])
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func randomName() -> String{
        return "\(firstNameList[Int(arc4random()) % firstNameList.count]) \(lastNameList[Int(arc4random()) % lastNameList.count])"
    }
    
    func randomAvatar() -> String {
        return avatarList[Int(arc4random()) % avatarList.count]
    }

}

extension PerformanceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomPeopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let item = randomPeopleList[indexPath.row]
        if let path = Bundle.main.path(forResource: item["avatar"], ofType: "jpg") {
            let image = UIImage(contentsOfFile: path)
            cell.imageView?.image = image
        }
        cell.imageView?.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.imageView?.layer.shadowOpacity = 0.75
        cell.clipsToBounds = true
        cell.textLabel?.text = item["name"]
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.textLabel?.layer.shadowOpacity = 0.5
        return cell
    }
}
