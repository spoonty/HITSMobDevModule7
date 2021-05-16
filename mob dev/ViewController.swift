//
//  ViewController.swift
//  mob dev
//
//  Created by Пользователь on 30.04.2021.
//  Copyright © 2021 Пользователь. All rights reserved.
//

//

import UIKit
import SwiftImage




var originalImage = UIImage()

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textToLoad: UILabel!
    @IBOutlet weak var scaling: UITextField!
    @IBOutlet weak var angle: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(load(_ :)))
        img.addGestureRecognizer(tap)
        img.isUserInteractionEnabled = true
    }

    @objc func load(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Изображение", message: nil, preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: "Фотогаллерея", style: .default) { (alert) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: "Камера", style: .default) { (alert) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(actionPhoto)
        alert.addAction(actionCamera)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func rotation(_ sender: Any) {
        let image = Image<RGBA<UInt8>>(uiImage: originalImage)
        let height = image.height
        let width = image.width
        
        var newImage = Image<RGBA<UInt8>>(width: width, height: height, pixel: .black)
//
//        var x = 0
//        var y = 0
//
//        for i in 0..<width {
//            for j in (0..<height).reversed() {
//                newImage[x, y] = image[i,j]
//                x += 1
//            }
//            x = 0
//            y += 1
//        }
        
        var angleVal = Double(angle.text!)!
        
        let centerX = Int(width/2)
        let centerY = Int(height/2)
        var c = cos(angleVal*Double.pi/180)
        var s = sin(angleVal*Double.pi/180)
        var t = tan(angleVal/2*Double.pi/180)
        
        for x in 0..<width {
            for y in 0..<height {
                let xp1 = Int(Double(x-centerX)*1 - Double(y-centerY)*t + Double(centerX))
                let yp1 = Int(Double(y-centerY)*1 + Double(centerY))
                
                let xp2 = Int(Double(xp1-centerX)*1 - Double(yp1-centerY)*0 + Double(centerX))
                let yp2 = Int(Double(xp1-centerX)*c + Double(yp1-centerY)*1 + Double(centerY))
                
                let xp3 = Int(Double(xp2-centerX)*1 - Double(yp2-centerY)*t + Double(centerX))
                let yp3 = Int(Double(xp2-centerX)*0 + Double(yp2-centerY)*1 + Double(centerY))
                
//                newImage[xp, yp] = image[x,y]
                if (0 <= xp3 && xp3 < width && 0 <= yp3 && yp3 < height) {
                    newImage[xp3, yp3] = image[x, y]
                }
//                //print(xp, yp)
            }
        }
        
        
        img.image = newImage.uiImage
        
        //img.image = newImage.uiImage
    }
    
    
//    @IBAction func chooseRotation(_ sender: UISegmentedControl) {
//
//        let image = Image<RGBA<UInt8>>(uiImage: originalImage)
//        let height = image.height
//        let width = image.width
//
//        var newImage = Image<RGBA<UInt8>>(width: height, height: width, pixel: .black)
//
//        var x = 0
//        var y = 0
//
//        for i in 0..<width {
//            for j in (0..<height).reversed() {
//                newImage[x, y] = image[i,j]
//                x += 1
//            }
//            x = 0
//            y += 1
//        }
//
//        img.image = newImage.uiImage
        
        
//        let image: UIImage = originalImage
//
//        let height = Int((image.size.height))
//        let width = Int((image.size.width))
//
//        let bitsPerComponent = Int(8)
//        let bytesPerRowHorizontally = 4 * width
//        let bytesPerRowVertically = 4 * height
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//        let rawDataHorizontally = UnsafeMutablePointer<UInt32>.allocate(capacity: (width * height))
//        let rawDataVertically = UnsafeMutablePointer<UInt32>.allocate(capacity: (height * height))
//
//        let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
//        let CGPointZero = CGPoint(x: 0, y: 0)
//        let rect = CGRect(origin: CGPointZero, size: (image.size))
//
//        let imageContext = CGContext(data: rawDataHorizontally, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRowHorizontally, space: colorSpace, bitmapInfo: bitmapInfo)
//
//        imageContext?.draw(image.cgImage!, in: rect)
//
//        let pixelsOriginal = UnsafeMutableBufferPointer<UInt32>(start: rawDataHorizontally, count: width * height)
//        if sender.selectedSegmentIndex == 0 {
//            img.image = originalImage
//        }
//        if sender.selectedSegmentIndex == 1 {
//
//            let newPixels = UnsafeMutableBufferPointer<UInt32>(start: rawDataVertically, count: width * height)
//            var counter = 0
//            for  x in 0..<width {
//                for  y in 0..<height{
//                    newPixels[counter] = pixelsOriginal[(height-1-y)*width + x]
//                    counter += 1
//                }
//            }
//            let outContext = CGContext(data: newPixels.baseAddress, width: height, height: width, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRowVertically,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)
//            let outImage = UIImage(cgImage: outContext!.makeImage()!)
//            img.image = outImage
//        }
//        if sender.selectedSegmentIndex == 2 {
//            let newPixels = UnsafeMutableBufferPointer<UInt32>(start: rawDataVertically, count: height * width)
//            var counter = 0
//            for y in 0..<height {
//                for x in 0..<width {
//                    newPixels[counter] = pixelsOriginal[(height-1-y)*width + (width-1-x)]
//                    counter += 1
//                }
//            }
//            let outContext = CGContext(data: newPixels.baseAddress, width: width, height: height, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRowHorizontally,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)
//            let outImage = UIImage(cgImage: outContext!.makeImage()!)
//            img.image = outImage
//        }
//        if sender.selectedSegmentIndex == 3 {
//            let newPixels = UnsafeMutableBufferPointer<UInt32>(start: rawDataVertically, count: width * height)
//            var counter = 0
//            for  x in 0..<width {
//                for  y in 0..<height{
//                    newPixels[counter] = pixelsOriginal[(width-1-x) + width*y]
//                    counter += 1
//                }
//            }
//            let outContext = CGContext(data: newPixels.baseAddress, width: height, height: width, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRowVertically,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)
//            let outImage = UIImage(cgImage: outContext!.makeImage()!)
//            img.image = outImage
//        }
    //}
    
    
    func buildMipmap(height: Int, width: Int, k: Double) -> (width: Int, height: Int) {
        var nearest: Int = 1

        while (nearest*2 <= Int(Double(width)*k)) {
            nearest *= 2
        }

        let widthS = nearest
        let heightS = (height*widthS)/width
        let size = (width: widthS, height: heightS)

        return size
    }

    func bilinearInterpolation(image: Image<RGBA<UInt8>>, height: Int, width: Int, heightR: Int, widthR: Int) -> Image<RGBA<UInt8>> {
        var newImage = Image<RGBA<UInt8>>(width: widthR, height: heightR, pixel: .black)

        let xRatio = Double(width-1)/Double(widthR)
        let yRatio = Double(height-1)/Double(heightR)

        for i in 0..<heightR {
            for j in 0..<widthR {
                let x = Int(xRatio * Double(j))
                let y = Int(yRatio * Double(i))
                let xDist: Double = (xRatio*Double(j)) - Double(x)
                let yDist: Double = (yRatio*Double(i)) - Double(y)

                let UL: RGBA<UInt8> = image[x, y]
                let UR: RGBA<UInt8> = image[x+1, y]
                let LL: RGBA<UInt8> = image[x, y+1]
                let LR: RGBA<UInt8> = image[x+1, y+1]

                newImage[j, i].red = UInt8(Double(UL.red)*(1-xDist)*(1-yDist) + Double(UR.red)*xDist*(1-yDist) + Double(LL.red)*(1-xDist)*yDist + Double(LR.red)*xDist*yDist)
                newImage[j, i].green = UInt8(Double(UL.green)*(1-xDist)*(1-yDist) + Double(UR.green)*xDist*(1-yDist) + Double(LL.green)*(1-xDist)*yDist + Double(LR.green)*xDist*yDist)
                newImage[j, i].blue = UInt8(Double(UL.blue)*(1-xDist)*(1-yDist) + Double(UR.blue)*xDist*(1-yDist) + Double(LL.blue)*(1-xDist)*yDist + Double(LR.blue)*xDist*yDist)
            }
        }

        return newImage
    }

    func trilinearInterpolation(image: Image<RGBA<UInt8>>, imageS: Image<RGBA<UInt8>>, height: Int, width: Int, heightS: Int, widthS: Int, heightR: Int, widthR: Int) -> Image<RGBA<UInt8>> {
        var newImage = Image<RGBA<UInt8>>(width: widthR, height: heightR, pixel: .black)

        let xRatio = Double(width-1)/Double(widthR)
        let yRatio = Double(height-1)/Double(heightR)
        let xRatioS = Double(widthS-1)/Double(widthR)
        let yRatioS = Double(heightS-1)/Double(heightR)

        let dist = Double(width-widthR)/Double(width-widthS)

        for i in 0..<heightR {
            for j in 0..<widthR {
                let x = Int(xRatio * Double(j))
                let y = Int(yRatio * Double(i))
                let xDist = (xRatio*Double(j)) - Double(x)
                let yDist = (yRatio*Double(i)) - Double(y)

                let UL: RGBA<UInt8> = image[x, y]
                let UR: RGBA<UInt8> = image[x+1, y]
                let LL: RGBA<UInt8> = image[x, y+1]
                let LR: RGBA<UInt8> = image[x+1, y+1]

                let xS = Int(xRatioS * Double(j))
                let yS = Int(yRatioS * Double(i))
                let xDistS = (xRatioS*Double(j)) - Double(xS)
                let yDistS = (yRatioS*Double(i)) - Double(yS)

                let ULS: RGBA<UInt8> = imageS[xS, yS]
                let URS: RGBA<UInt8> = imageS[xS+1, yS]
                let LLS: RGBA<UInt8> = imageS[xS, yS+1]
                let LRS: RGBA<UInt8> = imageS[xS+1, yS+1]

                newImage[j, i].red = UInt8(Double(UL.red)*(1-xDist)*(1-yDist)*(1-dist) + Double(UR.red)*xDist*(1-yDist)*(1-dist) + Double(LL.red)*yDist*(1-xDist)*(1-dist) + Double(LR.red)*xDist*yDist*(1-dist) + Double(ULS.red)*(1-xDistS)*(1-yDistS)*dist + Double(URS.red)*xDistS*(1-yDistS)*dist + Double(LLS.red)*(1-xDistS)*yDistS*dist + Double(LRS.red)*xDistS*yDistS*dist)
                newImage[j, i].green = UInt8(Double(UL.green)*(1-xDist)*(1-yDist)*(1-dist) + Double(UR.green)*xDist*(1-yDist)*(1-dist) + Double(LL.green)*yDist*(1-xDist)*(1-dist) + Double(LR.green)*xDist*yDist*(1-dist) + Double(ULS.green)*(1-xDistS)*(1-yDistS)*dist + Double(URS.green)*xDistS*(1-yDistS)*dist + Double(LLS.green)*(1-xDistS)*yDistS*dist + Double(LRS.green)*xDistS*yDistS*dist)
                newImage[j, i].blue = UInt8(Double(UL.blue)*(1-xDist)*(1-yDist)*(1-dist) + Double(UR.blue)*xDist*(1-yDist)*(1-dist) + Double(LL.blue)*yDist*(1-xDist)*(1-dist) + Double(LR.blue)*xDist*yDist*(1-dist) + Double(ULS.blue)*(1-xDistS)*(1-yDistS)*dist + Double(URS.blue)*xDistS*(1-yDistS)*dist + Double(LLS.blue)*(1-xDistS)*yDistS*dist + Double(LRS.blue)*xDistS*yDistS*dist)

            }
        }

       return newImage
    }

    @IBAction func set(_ sender: UIStepper) {
        scaling.text = String(sender.value)
    }
    
    
    @IBAction func cgange(_ sender: Any) {
        let k: Double = Double(scaling.text!)!

        let image = Image<RGBA<UInt8>>(uiImage: img.image!)
        let height: Int = image.height
        let width: Int = image.width

        let heightR: Int = Int(Double(height)*k)
        let widthR: Int = Int(Double(width)*k)

        if k > 1.0 {
            let img1: UIImage = bilinearInterpolation(image: image, height: height, width: width, heightR: heightR, widthR: widthR).uiImage
            img.image = img1
        } else if k < 1.0 {
            let size = buildMipmap(height: height, width: width, k: k)
            let heightS = size.height
            let widthS = size.width
            let imageS = bilinearInterpolation(image: image, height: height, width: width, heightR: heightS, widthR: widthS)
            let img1: UIImage = trilinearInterpolation(image: image, imageS: imageS, height: height, width: width, heightS: heightS, widthS: widthS, heightR: heightR, widthR: widthR).uiImage
            img.image = img1
        } else {
            let img1: UIImage = image.uiImage
            img.image = img1
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img.image = pickedImage
            originalImage = pickedImage
            
//            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "tabview1") as! tabView1ViewController
//            viewController.image = originalImage

            let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "test") as! testViewController
            self.navigationController?.pushViewController(next, animated: true)

 
        }
        dismiss(animated: true, completion: nil)
    }
}


