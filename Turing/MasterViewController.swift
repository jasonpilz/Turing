//
//  MasterViewController.swift
//  Turing
//
//  Created by Aaron Careaga & Jason Pilz on 10/26/15.
//

import UIKit

class MasterViewController: BaseTableViewController, ModelDelegate {
    
    let model = Model.sharedInstance
    let tealColor = UIColor(red: 5.0/255.0, green: 194.0/255.0, blue: 209.0/255.0, alpha: 1.0)

    var detailViewController: DetailViewController? = nil
    var people = Model.sharedInstance.people
    var navBorder:UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        model.delegate = self
        if (people.isEmpty) {
            model.fetchPeople()
        }
        
        // Inform Navigation Controller to set the nav item title in white
        self.navigationController?.navigationBar.barStyle = .Black
        
        // Sets the detail view controllers back button to custom teal color
        UINavigationBar.appearance().tintColor = tealColor
        
        self.navigationController?.toolbarHidden = false
        self.navigationController?.toolbar.barTintColor = tealColor
        
        // Set up a refresh control
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: "refreshPeople", forControlEvents: .ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        self.navBorder.removeFromSuperview()
        self.setNavbarBottomBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let person = people[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = person
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "showAddPerson" {
            print("Showing add person form")
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let person = people[indexPath.row]
        cell.textLabel!.text = "\(person.givenName) \(person.lastName)"
        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            people.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: - ModelDelegate
    
    func modelUpdated() {
        refreshControl?.endRefreshing()
        self.people = Model.sharedInstance.people
        tableView.reloadData()
    }
    
    func errorUpdating(error: NSError) {
        let message = error.localizedDescription
        let alert = UIAlertController.init(title: "Error loading people", message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction.init(title: "OK", style: .Default, handler: nil)
        alert.addAction(OKAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateInterfaceForNetworkIssue() {
        self.refreshControl?.endRefreshing()
    }
    
    // MARK: - Custom Functions
    
    func setNavbarBottomBorder() {
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
            self.navBorder = UIView(frame: CGRectMake(0, navigationBar.frame.size.height - 3, navigationBar.frame.size.width, 3))
            navBorder.backgroundColor = tealColor
            navBorder.opaque = true
            //self.tableView.addSubview(self.navBorder)
            self.navigationController?.navigationBar.addSubview(self.navBorder)
        }
    }
    
    func refreshPeople() {
        model.fetchPeople()
    }
    
}

    // MARK: - Extensions

    extension Array {
        func randomItem() -> Element {
            let index = Int(arc4random_uniform(UInt32(self.count)))
            return self[index]
        }
    }