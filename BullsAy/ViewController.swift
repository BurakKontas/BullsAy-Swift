//
//  ViewController.swift
//  BullsAy
//
//  Created by Trakya14 on 19.02.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var targetSliderValue = 0
    var currentSliderValue = 0
    var scoreValue = 0
    var roundValue = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = 50.0
        currentSliderValue = lroundf(slider.value)
        
        randomizeTargetValue()
    }
    
    @IBAction func startover() {
        scoreValue = 0
        roundValue = 1
        randomizeTargetValue()
        scoreLabel.text = String(scoreValue)
        roundLabel.text = String(roundValue)
        currentSliderValue = 50
        slider.value = 50.0
    }
    
    func randomizeTargetValue() {
        var randomGenerator = SystemRandomNumberGenerator()
        targetSliderValue = Int.random(in: 0...100, using: &randomGenerator)
        targetLabel.text = String(targetSliderValue)
    }
    
    func calculateScore() -> (Int, Int) {
        let diff = abs(targetSliderValue - currentSliderValue)
        var score = 100-diff
        
        if(diff == 0) {
            score += 100
        } else if (diff < 5) {
            score += 50
        }
        
        scoreValue += score
        scoreLabel.text = String(scoreValue)
        
        roundValue += 1
        roundLabel.text = String(roundValue)
        
        return (score, diff)
    }
    
    @IBAction func showAlert() {
        let (score, diff) = calculateScore()
        
        var title = ""
        if(diff == 0) {
            title = "Perfect"
        } else if (diff < 5) {
            title = "You Almost Did It"
        } else if (diff < 10) {
            title = "Pretty Good"
        } else {
            title = "Not Even Close..."
        }
        
        let message = "Slider Value = \(currentSliderValue)\nTarget Value = \(targetSliderValue)\nScore: \(score)"
        
        let alert = UIAlertController(title: title,message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        randomizeTargetValue()
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentSliderValue = lroundf(slider.value)
        print("The value of slider is now : \(currentSliderValue)")
    }
}
