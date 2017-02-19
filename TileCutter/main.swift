//
//  main.swift
//  TileCutter
//
//  Created by hao on 2017/2/19.
//  Copyright © 2017年 Vito. All rights reserved.
//

import Foundation
import AppKit

/*
 How to use?
 
 swift (这个main文件所在的目录/main.swift) 需要分割的图片路径
 e.g. : swift ~/Project/CoreAnimationDemo/TileCutter/ ~/Pictures/image.jpg
 */

guard CommandLine.argc >= 2 else {
    print("TileCutter arguments: inputfile")
    exit(1)
}

// input file
let inputFile = CommandLine.arguments[1]

// tile size
let tileSize = 256
// output path
var outputPath = URL(fileURLWithPath: inputFile).deletingPathExtension()

// load image
guard let image = NSImage(contentsOfFile: inputFile) else {
    print("load image error")
    exit(1)
}
var size = image.size
let representations = image.representations
if let representation = representations.first {
    size.width = CGFloat(representation.pixelsWide)
    size.height = CGFloat(representation.pixelsHigh)
}
var rect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
guard let imageRef = image.cgImage(forProposedRect: &rect, context: nil, hints: nil) else {
    exit(1)
}

// calculate rows and columns
let rows: Int = Int(ceil(Double(size.height) / Double(tileSize)))
let cols: Int = Int(ceil(Double(size.width) / Double(tileSize)))

// generate tiles
for y in 0..<rows {
    for x in 0..<cols {
        // extract tile image
        let tileRect = CGRect(x: x * tileSize, y: y * tileSize, width: tileSize, height: tileSize)
        if let tileImage = imageRef.cropping(to: tileRect) {
            // convert to jpeg data
            let imageRep = NSBitmapImageRep(cgImage: tileImage)
            let data = imageRep.representation(using: .JPEG, properties: [:])
            
            // save file
            let path = outputPath.appendingPathExtension(String(format: "_%02i_%02i.jpg", x, y))
            try? data?.write(to: path, options: Data.WritingOptions.atomic)
        }
    }
}


print("haha")
