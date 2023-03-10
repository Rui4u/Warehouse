//
//  ImageZipTools.swift
//  ImageZipSwfit
//
//  Created by sharui on 2021/2/5.
//

import Cocoa

struct ImageZipTools {
    static func zip() {
        let argv = CommandLine.arguments
        CommandTools.output(helpString)
        
        if argv.contains("-help") {
            CommandTools.output(helpString)
        }else {
            let path = CommandTools.argsToDictionary()["path"] as? String
            let numberOfColors = CommandTools.argsToDictionary()["number-of-colors"] as? Int ?? 32
            let quality = CommandTools.argsToDictionary()["quality"] as? Array<Int> ?? [40,80]
            print(">>>>begin")
            doZip(path:path, numberOfcolors:numberOfColors, quality:quality)
        }
//        /Users/lagou/Desktop/教育购买
    }
    
    static func doZip(path : String?, numberOfcolors: Int, quality:Array<Int>){
        guard let path = path else {
            CommandTools.output("请输入路径，按回车结束")
            let str = String(data: FileHandle.standardInput.availableData, encoding: String.Encoding.utf8)
            doZip(path: CommandTools.input(inputs: str),numberOfcolors: numberOfcolors, quality: quality)
            return;
        }
//        /Users/lagou/Desktop/教育购买
        print("loading...")
        let pathsList = SRFileManager.enumPath(url: path)
        let fileCount = pathsList.count;
        print("文件个数",fileCount)
        
        if fileCount == 0 {
            CommandTools.output("该资源目录下无图片")
            return
        }
        
        var oldSize : Int = 0;
        var newSize : Int = 0;
        var index = 0
        
        var progress : Float = 0
        let beginTime = Date(timeIntervalSinceNow: 0)
        
        for path in pathsList {
            autoreleasepool {
                oldSize = SRFileManager.fileSize(path: path) + oldSize
                ImageZipTools.imageZip(path: path,numberOfcolors:numberOfcolors, quality:quality)
                index = index + 1
                let currentProgress = Float(String(format:"%.3f",(Float(index) / Float(fileCount)))) ?? 0
                if currentProgress != progress {
                    progress = currentProgress;
                    print("当前进度为:" + "\(String(format: "%.2f", progress * 100))" + "%")
                }
            }
        }
        
        for path in pathsList {
            newSize = SRFileManager.fileSize(path:path) + newSize
        }
        
        let saveSize = Float(oldSize - newSize) / (1024 * 1024);
        let costTime = NSCalendar.current.dateComponents([.second,.minute], from: beginTime, to: Date(timeIntervalSinceNow: 0))
        
        print("文件个数",fileCount)
        print("开始大小",oldSize);
        print("结束大小",newSize);
        print("节省大小",saveSize);
        print("花费时间" + "\(costTime.minute ?? 0)" + "分" + "\(costTime.second ?? 0)" + "秒");
    }
    
    static func imageZip(path : String,numberOfcolors: Int = 32, quality:Array<Int> = [40,80]) {
        let task = Process()
        
        var argumentsList = ["-Q",
                             "--no-imageoptim",
                             "--imagealpha",
                             "--number-of-colors", String(numberOfcolors),
                             "--quality","\(String(quality.first ?? 100) + "-" + String(quality.last ?? 100))",
                             path]
        
        if path.extension != ".png" && path.extension != ".webp" {
            argumentsList = ["-Q",
                             "--number-of-colors", String(numberOfcolors),
                             "--quality","\(String(quality.first ?? 100) + "-" + String(quality.last ?? 100))",
                             path]
        }
        
        task.launchPath = "/usr/local/bin/imageoptim"
        task.arguments = argumentsList
        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        // Launch the task
        task.launch()
        //        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        //        let output = String(data: data, encoding: String.Encoding.utf8) ?? ""
        //        print(output)
        //        pipe.fileHandleForReading.closeFile()
        //        pipe.fileHandleForWriting.closeFile()
        
        task.waitUntilExit()
    }
}
