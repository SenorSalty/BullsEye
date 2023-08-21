//
//  ViewController.swift
//  BullsEye
//
//  Created by Tyler Gerard on 8/16/23.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 50;
    
    var targetValue = 0;
    
    var score = 0
    
    var round = 0
    
    @IBOutlet var roundLabel: UILabel!
    
    @IBOutlet var slider:UISlider!
    
    @IBOutlet var targetLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        let transition = CATransition()
          transition.type = CATransitionType.fade
          transition.duration = 1
          transition.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeOut)
          view.layer.add(transition, forKey: nil)
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!

        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(
        named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)
    }
    @IBOutlet var scoreLabel: UILabel!
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)

        let points = 100 - difference
        
        score += points
        
        if difference == 0 {
            score+=100
        }
        
        let title: String
          if difference == 0 {
            title = "Perfect! Bonus 100 Points!"
          } else if difference < 5 {
            title = "You almost had it!"
          } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
          }
        
          let message = "You scored \(points) points"
        
        let alert = UIAlertController(
          title: title,
          message: message,
          preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
              self.startNewRound()
            })
        
           alert.addAction(action)
          present(alert, animated: true, completion: nil)
        }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value);
    }
    
    func startNewRound(){
        round += 1   
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value=Float(currentValue)
        updateLabels()
    }
    
    @IBAction func startNewGame() {
      score = 0
      round = 0
      startNewRound()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}

