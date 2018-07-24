//
//  ViewController.swift
//  DataPass
//
//  Created by Don Mag on 7/24/18.
//  Copyright © 2018 DonMag. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController {
	
	//MARK: Data Structures
	var userDictionary = [[String: String]]() { didSet { print("userDictionary.count from DIDSET,", userDictionary.count)}}
	
	//MARK: Initialization
	override func viewDidLoad() {
		self.loadUserDictionaryFromDatabase()
	}
	
	func loadUserDictionaryFromDatabase() {
		//...once data is fully loaded
		self.syncDataFromDatabase()
	}
	
	func syncDataFromDatabase() {
		// init dictionary with 4 elements
		for _ in 0...3 {
			let aCounter = userDictionary.count
			userDictionary.append(["ACounter\(aCounter)" : "A new \(aCounter)"])
		}
		print(userDictionary)
	}
	
	//MARK: View Controller Transitions
	@IBAction func segueAtoB(_ sender: Any) {
		self.performSegue(withIdentifier: "segueAtoB", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		//Segue from VCA to VCB
		if segue.identifier == "segueAtoB" {
			if let vcDest = segue.destination as? ViewControllerB {
				//Pass initialized userDictionary from VCA to VCB
				vcDest.userDictionary = self.userDictionary
			}
		}
	}
	
	@IBAction func returnFromB(_ segue: UIStoryboardSegue) {
		if let vcDest = segue.destination as? ViewControllerA,
			let vcSource = segue.source as? ViewControllerB {
				// pass userDictionary from VCB back to VCA
				vcDest.userDictionary = vcSource.userDictionary
			print("unwind segue from B")
		}
	}

	@IBAction func addElement(_ sender: Any) {
		let count = userDictionary.count
		userDictionary.append(["Acounter\(count)" : "A new \(count)"])
		print("Added element to dictionary in VC-A")
	}
	
	@IBAction func printDict(_ sender: Any) {
		print(self.userDictionary)
	}
	
}

class ViewControllerB: UIViewController {
	
	//MARK: Data Structures
	var userDictionary = [[String: String]]()
	
	//MARK: View Controller Transitions
	@IBAction func segueBtoA(_ sender: Any) {
		self.performSegue(withIdentifier: "unwindSegueBtoA", sender: self)
	}
	
	@IBAction func addElement(_ sender: Any) {
		let count = userDictionary.count
		userDictionary.append(["Bcounter\(count)" : "B new \(count)"])
		print("Added element to dictionary in VC-B")
	}

	@IBAction func printDict(_ sender: Any) {
		print(self.userDictionary)
	}
	
}

