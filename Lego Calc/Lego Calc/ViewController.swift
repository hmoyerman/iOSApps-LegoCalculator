//
//  ViewController.swift
//  Lego Calc
//
//  Created by Henry Moyerman on 1/6/16.
//  Copyright © 2016 Henry Moyerman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calcType: UISegmentedControl!
    @IBOutlet weak var numberOfPlates: UISegmentedControl!
    @IBOutlet weak var depthOfBrick: UISegmentedControl!
    @IBOutlet weak var lengthOfBrick: UISegmentedControl!
    @IBOutlet weak var brickType: UISegmentedControl!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var numberOfPlatesLabel: UILabel!
    @IBOutlet weak var depthOfBrickLabel: UILabel!
    @IBOutlet weak var lengthOfBrickLabel: UILabel!
    @IBOutlet weak var brickTypeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.becomeFirstResponder()
        inputField.text = ""
        resultLabel.text = ""
        changeLabels(0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeLabels(calcTypeValue:Int) {
        // Set labels based on the calculation type
        if calcTypeValue == 0 {
            inputLabel.text = "Number of Studs"
            numberOfPlatesLabel.hidden = true
            numberOfPlates.hidden = true
            depthOfBrickLabel.hidden = true
            depthOfBrick.hidden = true
            lengthOfBrickLabel.hidden = true
            lengthOfBrick.hidden = true
            brickTypeLabel.hidden = true
            brickType.hidden = true
            
        } else if calcTypeValue == 1 {
            inputLabel.text = "Number of Bricks"
            numberOfPlatesLabel.hidden = false
            numberOfPlates.hidden = false
            depthOfBrickLabel.hidden = true
            depthOfBrick.hidden = true
            lengthOfBrickLabel.hidden = true
            lengthOfBrick.hidden = true
            brickTypeLabel.hidden = true
            brickType.hidden = true
            
        } else {
            inputLabel.text = "Number of Bricks"
            numberOfPlatesLabel.hidden = true
            numberOfPlates.hidden = true
            depthOfBrickLabel.hidden = false
            depthOfBrick.hidden = false
            lengthOfBrickLabel.hidden = false
            lengthOfBrick.hidden = false
            brickTypeLabel.hidden = false
            brickType.hidden = false

        }
    }
    
    func formatUnits(result:Double, unitType:String) -> String {
        let intValueDouble = floor(result)
        let remainder = result - intValueDouble
        var intValue = Int(intValueDouble)
        var fract = ""
        var s = ""
        var num = 0
        var dm = 0
        // Set numerator and denominator based on remainder value
        if remainder == 0 {
        } else if remainder < 0.0625 {
            num = 1
            dm = 16
        } else if remainder < 0.25 {
            num = 1
            dm = 8
        } else if remainder < 0.1875 {
            num = 3
            dm = 16
        } else if remainder < 0.25 {
            num = 1
            dm = 4
        } else if remainder < 0.3125 {
            num = 5
            dm = 16
        } else if remainder < 0.375 {
            num = 3
            dm = 8
        } else if remainder < 0.4375 {
            num = 7
            dm = 16
        } else if remainder < 0.5 {
            num = 1
            dm = 2
        } else if remainder < 0.5625 {
            num = 9
            dm = 16
        } else if remainder < 0.625 {
            num = 5
            dm = 8
        } else if remainder < 0.6875 {
            num = 11
            dm = 16
        } else if remainder < 0.75 {
            num = 3
            dm = 4
        } else if remainder < 0.8125 {
            num = 13
            dm = 16
        } else if remainder < 0.875 {
            num = 7
            dm = 8
        } else if remainder < 0.9375 {
            num = 15
            dm = 16
        } else {
            intValue = intValue + 1
        }
        if num != 0 {  // Formats fraction
            fract = String(num) + "/" + String(dm)
        }
        if unitType == "in" {
            // Formats for feet and inches
            let mod12Remain = intValue%12
            var feet = intValue - mod12Remain
            if feet == 0 {
                if mod12Remain == 0 {
                    s = fract + " in"
                } else {
                    if fract == "" {
                        s = String(mod12Remain) + " in"
                    } else {
                        s = String(mod12Remain) + " " + fract + " in"
                    }
                }
                return s
            } else {
                feet = feet/12
                if mod12Remain == 0 {
                    s = String(feet) + " ft, " + fract + " in"
                } else {
                    if fract == "" {
                        s = String(feet) + " ft, " + String(mod12Remain) + " in"
                    } else {
                        s = String(feet) + " ft, " + String(mod12Remain) + " " + fract + " in"
                    }
                }
                return s
            }
        } else {
            // Formats for pounds and ounces
            let mod16Remain = intValue%16
            var pounds = intValue - mod16Remain
            if pounds == 0 {
                if mod16Remain == 0 {
                    s = fract + " oz"
                } else {
                    if fract == "" {
                        s = String(mod16Remain) + " oz"
                    } else {
                        s = String(mod16Remain) + " " + fract + " oz"
                    }
                }
                return s
            } else {
                pounds = pounds/16
                if mod16Remain == 0 {
                    s = String(pounds) + " lb, " + fract + " oz"
                } else {
                    if fract == "" {
                        s = String(pounds) + " lb, " + String(mod16Remain) + " oz"
                    } else {
                        s = String(pounds) + " lb, " + String(mod16Remain) + " " + fract + " oz"
                    }
                }
                return s
            }
        }
    }
    
    func getWeight(brick_type:String, brick_class:Int) -> Double {
        // Gets weight per brick based on the brick_type and brick_class
        var weight_per_brick = 0.0
        if brick_class == 0 {
            if brick_type == "1x1" {
            weight_per_brick = 0.0155205
        } else if brick_type == "1x2" || brick_type == "2x1" {
            weight_per_brick = 0.0282192
        } else if brick_type == "1x3" {
            weight_per_brick = 0.04373971
        } else if brick_type == "1x4" {
            weight_per_brick = 0.0578493
        } else if brick_type == "1x6" {
            weight_per_brick = 0.08536299
        } else if brick_type == "1x8" {
            weight_per_brick = 0.1132294
        } else if brick_type == "2x2" {
            weight_per_brick = 0.04444519
        } else if brick_type == "2x3" {
            weight_per_brick = 0.06772601
        } else if brick_type == "2x4" {
            weight_per_brick = 0.08183559
        } else if brick_type == "2x6" {
            weight_per_brick = 0.1319246
        } else {
            weight_per_brick = 0.1675513
            }
        } else {
            if brick_type == "1x1" {
            weight_per_brick = 0.00705479
        } else if brick_type == "1x2" || brick_type == "2x1" {
            weight_per_brick = 0.0126986
        } else if brick_type == "1x3" {
            weight_per_brick = 0.0186952
        } else if brick_type == "1x4" {
            weight_per_brick = 0.0250445
        } else if brick_type == "1x6" {
            weight_per_brick = 0.0373904
        } else if brick_type == "1x8" {
            weight_per_brick = 0.04797259
        } else if brick_type == "2x2" {
            weight_per_brick = 0.02257534
        } else if brick_type == "2x3" {
            weight_per_brick = 0.03280478
        } else if brick_type == "2x4" {
            weight_per_brick = 0.0423288
        } else if brick_type == "2x6" {
            weight_per_brick = 0.06137669
        } else {
            weight_per_brick = 0.08007189
            }
        }
        return weight_per_brick
    }

    @IBAction func onEditingChange(sender: AnyObject) {
        changeLabels(calcType.selectedSegmentIndex)
        let inputcheck = inputField.text
        if inputcheck == "" {
            resultLabel.text = ""
        } else if 100000000 <= (inputField.text! as NSString).doubleValue {
            resultLabel.text = "Input Is Too Large"
        } else {
            var s: String
            s = ""
            let calcTypeValue = calcType.selectedSegmentIndex
            if calcTypeValue == 0 {
                // A length calculation
                
                let length_bricks: Double = (inputField.text! as NSString).doubleValue
                let result = length_bricks * 0.31208333333333   // Calculate length
                s = formatUnits(result, unitType: "in")  // Format the result for inches
                
                
//                if length_bricks == 1 {  // Takes care of string formatting for non-plural cases
//                    s = "Length: " + String(length_bricks) + " Stud = " + s
//                } else {
//                    s = "Length: " + String(length_bricks) + " Studs = " + s
//                }
                
                
                
            } else if calcTypeValue == 1 {
                // A height calculation

                let height_bricks: Double = (inputField.text! as NSString).doubleValue
                
                //accounts for additional plates
                let additional_plates = numberOfPlates.selectedSegmentIndex
                let height_bricks_and_plates: Double = height_bricks + (Double(additional_plates) * 0.3333333333333);
                var result = height_bricks_and_plates * 0.37574404761905 // Calculate height
                result = result + 0.0708661 // Adds the top stud from the top bricks
                s = formatUnits(result, unitType: "in"); // Format the result for inches
                
                
//                if (additional_plates == 0) {
//                    // Takes care of string formatting for all non-plural cases
//                    // Also checks if height_bricks or additional_plates is 0, and should be left out of the string
//                    if height_bricks == 1 {
//                        s = "Height: " + String(height_bricks) + " Brick = " + s
//                    } else {
//                        s = "Height: " + String(height_bricks) + " Bricks = " + s
//                    }
//                } else if height_bricks == 0 {
//                    if additional_plates == 1 {
//                        s = "Height: " + String(additional_plates) + " Plate = " + s
//                    } else {
//                        s = "Height: " + String(additional_plates) + " Plates = " + s
//                    }
//                } else {
//                    if height_bricks == 1 && additional_plates == 1 {
//                        s = "Height: " + String(height_bricks) + " Brick + " + String(additional_plates) + " Plate = " + s
//                    } else if height_bricks == 1 {
//                        s = "Height: " + String(height_bricks) + " Brick + " + String(additional_plates) + " Plates = " + s
//                    } else if additional_plates == 1 {
//                        s = "Height: " + String(height_bricks) + " Bricks + " + String(additional_plates) + " Plate = " + s
//                    } else {
//                        s = "Height: " + String(height_bricks) + " Bricks + " + String(additional_plates) + " Plates = " + s
//                    }
//                }

                
                
            } else {
                // A weight calculation
            
                let weight_bricks: Double = (inputField.text! as NSString).doubleValue
                var lengthOfBrickIndex = lengthOfBrick.selectedSegmentIndex + 1
                if lengthOfBrickIndex == 5 {
                    lengthOfBrickIndex = 6
                } else if lengthOfBrickIndex == 6 {
                    lengthOfBrickIndex = 8
                }
                let brick_type = String(depthOfBrick.selectedSegmentIndex + 1) + "x" + String(lengthOfBrickIndex)
                let brick_class = brickType.selectedSegmentIndex
                // Gets weight per brick based on the brick_type and brick_class
                let weight_per_brick: Double = getWeight(brick_type, brick_class: brick_class)
                let result = weight_per_brick * weight_bricks;  // Calculate weight
                s = formatUnits(result, unitType: "oz"); // Format the result for ounces
                
                
//                if weight_bricks == 1 { // Takes care of string formatting for all non-plural cases
//                    s = "Weight: " + String(weight_bricks) + " " + String(brick_type) + " " + String(brick_class) + " Brick = " + s;
//                } else {
//                    s = "Weight: " + String(weight_bricks) + " " + String(brick_type) + " " + String(brick_class) + " Bricks = " + s;
//                }
                
                
                
            }
            resultLabel.text = s;
        }

    }

}

