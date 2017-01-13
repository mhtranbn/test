//
//  ViewController.swift
//  test
//
//  Created by mhtran on 12/19/16.
//  Copyright © 2016 mhtran. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,RSlideViewDelegate,RSlideViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var dicData:[String:AnyObject] = [:]
    var nameImage:Int = -1
    var arrayDetail:[String] = ["Menu","Book Table","Chat"]
    var arrayDescript:[String] = ["Order Items","Make Reservations","Meet others"]
    var arrayType:[String] = ["Items","Tables","Users"]
    var cellID:[String] = ["HeaderProfileCell"]
    @IBOutlet weak var rSlideView: RSlideView!
    var timer: Timer!
    
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func getData(data:[String:AnyObject]){
        self.dicData = data
    }
    
    func setUpUI(){
        self.rSlideView.setPageControlHidden(true, animated: true)
        self.rSlideView.reloadData()
        self.tableView.register(UINib(nibName:"HeaderProfileCell",bundle:nil), forCellReuseIdentifier: cellID[0])
    }
    
    func rSlideViewNumberOfPages() -> Int {
        return 6
    }
    
    func rSlideView(_ slideView: RSlideView!, titleForPageAt index: Int) -> String! {
        nameImage = index
        return "title for \(index)"
    }
    
    func rSlideView(_ slideView: RSlideView!, tapOnPageAt index: Int) {
        nameImage = index
        
        
    }
    
    func rSlideView(_ slideView: RSlideView!, viewForPageAt index: Int) -> UIView! {
        nameImage = index
        return UIImageView(image: UIImage(named:"\(index).jpg"))
    }
    
    func rSlideViewDidEndScrollAnimation(_ sliderView: RSlideView!) {
        
    }
    
    @IBAction func buttonLeftAction(_ sender: Any) {
        self.rSlideView.previousPage()
    }
    
    @IBAction func buttonRightAction(_ sender: Any) {
        self.rSlideView.nextPage()
    }
    

    
    func leftMenuAction(){

    }
    
    func pushToDetailInforVC(){

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
//        let index = indexPath.row
        if let dequeCell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderProfileCell") as? HeaderProfileCell {
            cell = dequeCell
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    

    func onTimer()
    {
        self.rSlideView.nextPage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer =  Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
}

