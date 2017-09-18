//
//  ViewController.swift
//  MyApp04
//
//  Created by user22 on 2017/9/18.
//  Copyright © 2017年 Brad Big Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnGuess: UIButton!
    @IBOutlet weak var textGuess: UITextField!
    @IBOutlet weak var textHist: UITextView!

    private var answer = ViewController.createAnswer(number: 3)
    private var hist = ""
    private var counter = 0
    
    
    @IBAction func doGuess(_ sender: Any) {
        counter += 1
        let gvalue = textGuess.text // String?
        let result = ViewController.checkAB(guess: gvalue!, answer: answer)
        
        if result == "3A0B" {
            showDialog(mesg: "WINNER")
            initGame()
        }else if counter == 10 {
            showDialog(mesg: "Loser:\n\(answer)")
            initGame()
        }else {
            showDialog(mesg: result)
            
            hist += "\(gvalue!) => \(result)\n"
            textHist.text = hist
            textGuess.text = ""
        }
        
        
    }
    
    @IBAction func doReset(_ sender: Any) {
        initGame()
    }

    @IBAction func doSetting(_ sender: Any) {
    }
    @IBAction func doExit(_ sender: Any) {
        exit(0)
    }

    private func showDialog(mesg : String) {
        let alert = UIAlertController(title: "Result", message: mesg, preferredStyle: .alert )
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        btnGuess.layer.cornerRadius = 10
        
        initGame()
    }
    
    func initGame(){
        answer = ViewController.createAnswer(number: 3)
        hist = ""
        counter = 0
        textHist.text = ""
        textGuess.text = ""
    }
    
    // 輸入(guess, answer) -> 檢查幾A幾B => "1A2B"
    static func checkAB(guess:String, answer:String) -> String {
        let len = guess.characters.count
        
        if len != 3 {return "別鬧了"}
        
        var A = 0, B = 0
        
        for i in 0..<len {
            let gchar = mysubstrv2(source: guess, from: i, to: i+1)
            let achar = mysubstrv2(source: answer, from: i, to: i+1)
            if gchar == achar {
                A += 1
            }else if answer.contains(gchar) {
                B += 1
            }
        }
        
        return "\(A)A\(B)B"
    }
    
    // 取出子字串
    static func mysubstrv2(source:String, from:Int, to:Int) -> String {
        let cs = Array(source.characters);
        var ret = ""
        for i in from..<to {
            ret += String(cs[i])
        }
        return ret
    }
    
    // 產生謎底
    static func createAnswer(number:Int) -> String{
        var num = Array((0...9))
        num = shullfe(source: Array(num))
        var ret = ""
        for v in 0..<number {
            ret += String(num[v])
        }
        return ret
    }
    
    // 洗牌邏輯
    static func shullfe(source:Array<Int>) -> Array<Int> {
        var poker = source
        let n = poker.count
        var rand = -1
        var temp = -1
        var max = -1
        for i in 0..<n {
            max = n - i
            rand = Int(arc4random_uniform(UInt32(max)))
            
            // swap : poker[rand] <-> poker[last]
            temp = poker[rand];
            poker[rand] = poker[max-1]
            poker[max-1] = temp
        }
        return poker
    }
    
    
}

