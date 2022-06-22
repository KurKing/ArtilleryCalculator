//
//  ViewController.swift
//  ArtilleryCalculator
//
//  Created by Oleksiy on 21.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedLabel: UILabel?
    var isLightTheme = true
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var lightButton: UIBarButtonItem!
    
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
        
        colorThemeButtonPressed(lightButton)
    }
    
    @IBAction func colorThemeButtonPressed(_ sender: Any) {
        isLightTheme = !isLightTheme
        
        if isLightTheme {
            view.backgroundColor = .white
            view.changeColor(.black)
            refreshButton.tintColor = .black
            lightButton.tintColor = .black
        } else {
            view.backgroundColor = .black
            view.changeColor(.darkRed)
            refreshButton.tintColor = .darkRed
            lightButton.tintColor = .darkRed
        }
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        labels.forEach { $0.text = "00" }
    }
    
    @IBAction func countButtonPressed(_ sender: Any) {
        natoSightLabel.text = (srsrSightLabel.text ?? "").sight
        
        guard let srsrDegreeMeterFirst = Int(srsrDegreeMeterFirstLabel.text ?? ""),
              let srsrDegreeMeterSecond = Int(srsrDegreeMeterSecondLabel.text ?? ""),
              let natoDegreeMeterFirst = Int(natoDegreeMeterFirstLabel.text ?? ""),
              let natoDegreeMeterSecond = Int(natoDegreeMeterSecondLabel.text ?? "") else {
                  return
              }
        
        let srsr = Double(srsrDegreeMeterFirst * 100 + srsrDegreeMeterSecond)
        let nato = Double(natoDegreeMeterFirst * 100 + natoDegreeMeterSecond)
        
        let srsrConst = 6000.0
        let natoConst = 6400.0
        
        guard srsr != 0 || nato != 0 else { return }
        
        if nato == 0 {
            let newNatoValue = Int((natoConst - (srsr * natoConst / srsrConst)).rounded())
            let firstPart = newNatoValue / 100
            natoDegreeMeterFirstLabel.text = "\(firstPart)"
            var secondLabelValue = "\(newNatoValue - firstPart * 100)"
            if secondLabelValue == "0" {
                secondLabelValue += "0"
            }
            natoDegreeMeterSecondLabel.text = "\(secondLabelValue)"
            return
        }
        
        let newSrsrValue = Int((srsrConst - (nato * srsrConst / natoConst)).rounded())
        let firstPart = newSrsrValue / 100
        srsrDegreeMeterFirstLabel.text = "\(firstPart)"
        var secondLabelValue = "\(newSrsrValue - firstPart * 100)"
        if secondLabelValue == "0" {
            secondLabelValue += "0"
        }
        srsrDegreeMeterSecondLabel.text = "\(secondLabelValue)"
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
