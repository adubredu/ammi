//
//  FindViewController.swift
//  ammi
//
//  Created by Alphonsus Adu-Bredu on 1/7/18.
//  Copyright © 2018 ammi team. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {
@IBOutlet weak internal var searchFieldOut: UITextField!
    
    @IBAction func breakfastButton(_ sender: Any)
    {
        performSegue(withIdentifier: "showBreakfastTable", sender: self)
    }
    
    
    @IBAction func lunchButton(_ sender: Any)
    {
        performSegue(withIdentifier: "showLunchTable", sender: self)
    }
    
    
    @IBAction func dinnerButton(_ sender: Any)
    {
        performSegue(withIdentifier: "showDinnerTable", sender: self)
    }
    
    @IBAction func studyButton(_ sender: Any)
    {
        performSegue(withIdentifier: "showStudyTable", sender: self)

    }
    
    @IBAction func hangoutButton(_ sender: Any)
    {
        performSegue(withIdentifier: "showHangoutTable", sender: self)
    }
    
    
    @IBAction func chillButton(_ sender: Any)
    {
        performSegue(withIdentifier: "showChillTable", sender: self)
        
    }
    
    
    @IBAction func miscellaneousButton(_ sender: Any)
    {
        performSegue(withIdentifier: "showMiscTable", sender: self)
    }
    
    
    @IBAction func privateGroupButton(_ sender: Any)
    {
        performSegue(withIdentifier: "goToPrivateSearchField", sender: self)
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FindViewController.searchTaped(recognizer:)))
        tapGestureRecognizer.numberOfTapsRequired=1
        
        searchFieldOut.addGestureRecognizer(tapGestureRecognizer)
    }

    
    
    func searchTaped (recognizer:UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "searchList", sender: self)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
