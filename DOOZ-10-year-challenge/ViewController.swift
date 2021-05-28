//
//  ViewController.swift
//  DOOZ-10-year-challenge
//
//  Created by 蔡佳穎 on 2021/4/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DOOZImageView:
        UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var yearLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    var timer: Timer?
    var sliderValue = 0
    var syncYear = 2011
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func moveSlider(_ sender: UISlider) {
        //取得slider年份
        sender.value = sender.value.rounded()
        sliderValue = Int(sender.value)
        
        //連動label,imageView,datePicker
        yearLabel.text = "♥\(sliderValue)♥"
        DOOZImageView.image = UIImage(named: "\(sliderValue)")
        let yearString = String(sliderValue)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.date(from: yearString)
        if let year = year {
            datePicker.date = year
        }
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        //取得datePicker年份
        let selectYear = sender.date
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: selectYear)
        let year = Float(yearString)
        
        //連動label,slider,imageView
        yearLabel.text = "♥"+yearString+"♥"
        if let year = year {
            slider.value = year
        }
        DOOZImageView.image = UIImage(named: yearString)
    }
    
    @IBAction func autoPlay(_ sender: UISwitch) {
        if sender.isOn {
            datePicker.isEnabled = false
            slider.isEnabled = false
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
                self.yearLabel.text = "♥\(syncYear)♥"
                self.DOOZImageView.image = UIImage(named: "\(self.syncYear)")
                self.slider.value = Float(self.syncYear)
                let yearString = String(syncYear)
                dateFormatter.dateFormat = "yyyy"
                let year = dateFormatter.date(from: yearString)
                if let year = year {
                    datePicker.date = year
                }
                if syncYear <= 2020 {
                    self.syncYear += 1
                }
            }
        } else {
            datePicker.isEnabled = true
            slider.isEnabled = true
            syncYear = 2011
            timer?.invalidate()
            
        }
    }
}

