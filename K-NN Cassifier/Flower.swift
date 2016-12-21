//
//  Flower.swift
//  K-NN Cassifier
//
//  Created by Alan Rabelo Martins on 21/12/16.
//  Copyright © 2016 Alan Rabelo Martins. All rights reserved.
//

import CoreGraphics
import Foundation

class Flower {
    let sepalWidth, sepalLength, petalWidth, petalLength : Float
    let type : String
    var distance : Float?
    
    init(withDataArray array : [String]) {
        self.sepalWidth = Float(array[1])!
        self.sepalLength = Float(array[0])!

        self.petalWidth = Float(array[3])!
        self.petalLength = Float(array[2])!
        
        self.type = array[4]
    }
    
    
    fileprivate func distance(toFlower flower : Flower) -> Float {
        let sW = self.sepalWidth - flower.sepalWidth
        let sL = self.sepalLength - flower.sepalLength
        
        let pW = self.petalWidth - flower.petalWidth
        let pL = self.petalLength - flower.petalLength
        
        return sqrt(sW * sW + sL * sL + pW * pW + pL * pL)
    }
    
    func classify(inData data : [Flower], withCount count : Int) -> IrisFlower {
        
        let nearestNeighBoors = self.nearestNeighBoors(inData: data, withCount: count)
        
        
        switch mostFrequent(array: nearestNeighBoors)!.key {
        case "Iris-versicolor":
            return IrisFlower.versicolor
        case "Iris-virginica":
            return IrisFlower.virginica
        case "Iris-setosa":
            return IrisFlower.setosa
        default :
            return IrisFlower.versicolor
        
        }
        
    }
    
    
    fileprivate func mostFrequent(array: [Flower]) -> (key: String, value: Int)? {
        
        var frequency: [String:Int] = [:]
        
        for x in array {
            // set frequency to the current count of this element + 1
//            print("\(x.type)")
            frequency[x.type] = (frequency[x.type] ?? 0) + 1
        }
        
        let descending = frequency.sorted(by: {
            $0.1 > $1.1
        })
        
        return descending.first!
        
    
    }
    
    fileprivate func nearestNeighBoors(inData data : [Flower], withCount count : Int) -> [Flower] {
        
        
        let dataUnsorted = data
        
        for flower in dataUnsorted {
            flower.distance = self.distance(toFlower: flower)
        }
        
        let dataSorted = data.sorted {
            $0.distance! < $1.distance!
        }
        
//        for flower in dataSorted {
//            print("\(flower.type) - \(flower.distance)")
//        }
        
        var nearestNeighboors = [Flower]()
        
        for index in 0..<count {
            nearestNeighboors.append(dataSorted[index])
        }
        
        return nearestNeighboors
        
        
    }
    
    
    

}

enum IrisFlower {
    case virginica
    case versicolor
    case setosa
}

class KNNClassifier {
    
}

class IrisData {

    let file = "iris" //this is the file. we will write to and read from it
    
    static fileprivate func loadData(fromFile file : String) -> String? {
        
        if let irisDataPath = Bundle.main.path(forResource: "irisData", ofType: "txt") {
            do {
                

                let irisDataText = try String(contentsOfFile: irisDataPath)
                return irisDataText
            } catch {
                print("error loading iris data")
            }
        }
        
        return nil
    }
    
    static func loadIrisObjects() -> [Flower]? {
        if let txtData = self.loadData(fromFile: "iris") {
            
            var objectsArray = [Flower]()
            let txtArray = txtData.components(separatedBy: "\n")
            
            
            for line in txtArray {
                let components = line.components(separatedBy: ",")

                let flower = Flower(withDataArray: components)
                objectsArray.append(flower)
            }
            
            return objectsArray
            
        }
        
        
        return nil
        
    }
    
    static func loadRandomIrisObjects(withCount count : Int) -> [[Flower]]? {
        if let txtData = self.loadData(fromFile: "iris") {
            
            var trainningData = [Flower]()
            var testData = [Flower]()
            var txtArray = txtData.components(separatedBy: "\n")
            
            
            for i in 0..<txtArray.count {
                
                let upperBound = txtArray.count
                
                let line = txtArray[Int(arc4random_uniform(UInt32(upperBound)))]
                
                txtArray.remove(at: txtArray.index(of: line)!)
                
                let components = line.components(separatedBy: ",")
                
                let flower = Flower(withDataArray: components)
                
                
                if trainningData.count < count {
                    trainningData.append(flower)

                } else {
                    testData.append(flower)
                }
                
                
            }
            
            return [trainningData, testData]
            
        }
        
        
        return nil
    }

    
//    if let dir = Bundle.main.path(forResource: "Iris", ofType: "data") {
    
//        print(dir)
//        //let path = dir.appendingPathComponent(file)
//        
//        //writing
//        do {
//            try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
//        }
//        catch {/* error handling here */}
//        
//        //reading
//        do {
//            let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
//        }
//        catch {/* error handling here */}
//    }
//    }

}
