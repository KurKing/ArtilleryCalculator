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
        natoSightLabel.text = (srsrSightLabel.text ?? "").sight
        
        guard let srsrDegreeMeterFirst = Int(srsrDegreeMeterFirstLabel.text ?? ""),
              let srsrDegreeMeterSecond = Int(srsrDegreeMeterSecondLabel.text ?? ""),
              let natoDegreeMeterFirst = Int(natoDegreeMeterFirstLabel.text ?? ""),
              let natoDegreeMeterSecond = Int(natoDegreeMeterSecondLabel.text ?? ""),
              let srsrSecondLength = srsrDegreeMeterSecondLabel.text?.count,
              let natoSecondLength = natoDegreeMeterSecondLabel.text?.count else {
                  return
              }
        
        let srsr = Double(srsrDegreeMeterFirst.multiplyBy10(times: srsrSecondLength) + srsrDegreeMeterSecond)
        let nato = Double(natoDegreeMeterFirst.multiplyBy10(times: natoSecondLength) + natoDegreeMeterSecond)
        
        let srsrConst = 6000.0
        let natoConst = 6400.0
        
        guard srsr != 0, nato != 0 else { return }
        
        if nato == 0 {
            let newNatoValue = Int(natoConst - (srsr * natoConst / srsrConst))
            let firstPart = newNatoValue / 100

            natoDegreeMeterFirstLabel.text = "\(firstPart)"
            natoDegreeMeterSecondLabel.text = "\(newNatoValue - firstPart)"
            
            return
        }
        
        let newSrsrValue = Int(srsrConst - (srsr * srsrConst / natoConst))
        let firstPart = newSrsrValue / 100

        srsrDegreeMeterFirstLabel.text = "\(firstPart)"
        srsrDegreeMeterSecondLabel.text = "\(newSrsrValue - firstPart)"
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        guard var selectedLabelText = selectedLabel?.text, let senderText = sender.titleLabel?.text else {
            return
        }
        
        selectedLabelText = selectedLabelText == "00" ? "" : selectedLabelText
        if selectedLabelText.count != 2 || selectedLabel == srsrSightLabel {
            selectedLabel?.text = selectedLabelText + senderText
        }
    }
    
    @objc func labelPressed(sender: UITapGestureRecognizer) {
        if let labelToSelect = sender.view as? UILabel {
            selectedLabel = labelToSelect
        }
    }
}
