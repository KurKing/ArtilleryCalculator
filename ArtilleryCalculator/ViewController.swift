//
//  ViewController.swift
//  ArtilleryCalculator
//
//  Created by Oleksiy on 21.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedLabel: UILabel?
    
    @IBOutlet weak var srsrSightLabel: UILabel!
    @IBOutlet weak var natoSightLabel: UILabel!
    
    @IBOutlet weak var srsrDegreeMeterFirstLabel: UILabel!
    @IBOutlet weak var srsrDegreeMeterSecondLabel: UILabel!
    
    @IBOutlet weak var natoDegreeMeterFirstLabel: UILabel!
    @IBOutlet weak var natoDegreeMeterSecondLabel: UILabel!
    
    private var labels: [UILabel] {
        [srsrSightLabel, natoSightLabel,
         srsrDegreeMeterFirstLabel, srsrDegreeMeterSecondLabel,
         natoDegreeMeterFirstLabel, natoDegreeMeterSecondLabel]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labels.forEach {
            $0.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelPressed(sender:)))
            tap.cancelsTouchesInView = false
            
            if $0 != natoSightLabel {
                $0.addGestureRecognizer(tap)
            }
        }
    }
    
    @IBAction func colorThemeButtonPressed(_ sender: Any) {
        print("colorThemeButtonPressed")
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        labels.forEach { $0.text = "00" }
    }
    
    @IBAction func countButtonPressed(_ sender: Any) {
        print("countButtonPressed")
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        guard var selectedLabelText = selectedLabel?.text, let senderText = sender.titleLabel?.text else {
            return
        }
        
        selectedLabelText = selectedLabelText == "00" ? "" : selectedLabelText
        selectedLabel?.text = selectedLabelText + senderText
    }
    
    @objc func labelPressed(sender: UITapGestureRecognizer) {
        if let labelToSelect = sender.view as? UILabel {
            selectedLabel = labelToSelect
        }
    }
}
