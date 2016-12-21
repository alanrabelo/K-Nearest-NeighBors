//
//  ViewController.swift
//  K-NN Cassifier
//
//  Created by Alan Rabelo Martins on 21/12/16.
//  Copyright © 2016 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func classificar(_ sender: UIButton) {
        
        var porcentagemDeAcertos = [Float]()
        
        for i in 0..<10 {
        guard let randomIrisData = IrisData.loadRandomIrisObjects(withCount: 100) else {
            return
        }
        
        var acertos = 0
        
        let trainningData = randomIrisData.first!
        let testData = randomIrisData.last!
        
        
        for flower in testData {
            
            let prediction = flower.classify(inData: trainningData, withCount: 10)
            
//            print("O valor correto é \(flower.type.irisFlower)")
//            print("O valor do KNN é \(prediction)")
            
            if flower.type.irisFlower == prediction {
                acertos += 1

            } else {
//                print("Errou")
            
            }
            
        }
        
        print("acertou \(acertos) de \(testData.count) flores testadas")
        
        porcentagemDeAcertos.append(Float(acertos) / Float(testData.count))
        
        }
        
        print("A média foi \(porcentagemDeAcertos.average)")
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension Array {
    var average : Float {
        
        var sum : Float = 0.0
        for value in self {
            sum += value as! Float
        }
        
        return sum / Float(self.count)
        
    }
}

extension String {
    var irisFlower : IrisFlower  {
        switch self {
        case "Iris-virginica":
            return IrisFlower.virginica
        case "Iris-versicolor":
            return IrisFlower.versicolor
        case "Iris-setosa":
            return IrisFlower.setosa
        default:
            return IrisFlower.virginica
        }
    }
}

