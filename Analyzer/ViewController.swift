//
//  ViewController.swift
//  Analyzer
//
//  Created by Alaa on 21/08/2023.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController {
    let images: [ImageDetails] = [
        ImageDetails(fileName: "Arla-Ecological-Medium-Fat-Milk_001.jpg"),
        ImageDetails(fileName: "Arla-Ecological-Medium-Fat-Milk_002.jpg"),
        ImageDetails(fileName: "Arla-Ecological-Medium-Fat-Milk_003.jpg"),
        ImageDetails(fileName: "Arla-Ecological-Medium-Fat-Milk_004.jpg"),
        ImageDetails(fileName: "Arla-Ecological-Medium-Fat-Milk_005.jpg"),
        ImageDetails(fileName: "Arla-Medium-Fat-Milk_001.jpg"),
        ImageDetails(fileName: "Arla-Medium-Fat-Milk_002.jpg"),
        ImageDetails(fileName: "Arla-Medium-Fat-Milk_003.jpg"),
        ImageDetails(fileName: "Arla-Medium-Fat-Milk_004.jpg"),
        ImageDetails(fileName: "Arla-Standard-Milk_001.jpg"),
        ImageDetails(fileName: "Arla-Standard-Milk_002.jpg"),
        ImageDetails(fileName: "Arla-Standard-Milk_003.jpg"),
        ImageDetails(fileName: "Arla-Standard-Milk_004.jpg"),
        ImageDetails(fileName: "Arla-Standard-Milk_005.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Medium-Fat-Milk_001.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Medium-Fat-Milk_002.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Medium-Fat-Milk_003.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Medium-Fat-Milk_004.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Medium-Fat-Milk_005.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Medium-Fat-Milk_006.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Standard-Milk_001.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Standard-Milk_002.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Standard-Milk_003.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Standard-Milk_004.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Standard-Milk_005.jpg"),
        ImageDetails(fileName: "Garant-Ecological-Standard-Milk_006.jpg"),
        ImageDetails(fileName: "Oatly-Oat-Milk_001.jpg"),
        ImageDetails(fileName: "Oatly-Oat-Milk_002.jpg"),
        ImageDetails(fileName: "Oatly-Oat-Milk_003.jpg"),
        ImageDetails(fileName: "Oatly-Oat-Milk_004.jpg"),
        ImageDetails(fileName: "Oatly-Oat-Milk_005.jpg"),
        ImageDetails(fileName: "Oatly-Natural-Oatghurt_001.jpg"),
        ImageDetails(fileName: "Oatly-Natural-Oatghurt_002.jpg"),
        ImageDetails(fileName: "Oatly-Natural-Oatghurt_003.jpg"),
        ImageDetails(fileName: "Oatly-Natural-Oatghurt_004.jpg"),
        ImageDetails(fileName: "Oatly-Natural-Oatghurt_005.jpg")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createExcelForNameSize()
        createJSONDetails()
        
        
    }
    func createExcelForNameSize() {
        let csvFileName = "image_sizes.csv"
        
        var csvText = "Images,Size\n"
        
        for image in images {
            
            if let imageN = UIImage(named: image.fileName) {
                let imageSize = imageN.size
                
                let newLine = "\(image.fileName),\(imageSize)\n"
                csvText.append(newLine)
            }
            
            do {
                let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let fileURL = documentsDirectory.appendingPathComponent(csvFileName)
                try csvText.write(to: fileURL, atomically: true, encoding: .utf8)
                print("CSV file created at: \(fileURL)")
            } catch {
                print("Error creating CSV file: \(error)")
            }
        }
    }
    func createJSONDetails() {
        var imagesAfter: [[String: Any]] = []
        for item in images {
            if let imageN = UIImage(named: item.fileName) {
                let imageSize = imageN.size
                let width = imageSize.width
                let height = imageSize.height
                
                
                let imageAfter: [String: Any] = [
                    "name": item.fileName,
                    "width": width,
                    "height": height
                ]
                imagesAfter.append(imageAfter)
                
            }
            
        }
        
        let jsonDictionary: [String: Any] = [
            "images" : imagesAfter
        ]
        
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
            
            
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let jsonFileURL = documentsDirectory.appendingPathComponent("data.json")
            
            
            try jsonData.write(to: jsonFileURL)
            
            print("JSON file created at: \(jsonFileURL)")
        } catch {
            print("Error creating JSON file: \(error)")
        }
    }
}
