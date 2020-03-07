
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mylabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var hardnessLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    let value = ["Soft": 300, "Medium": 15, "Hard": 20]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        
        totalTime = value[hardness]!
        secondsPassed = 0
        progressBar.progress = 0.0
        hardnessLabel.text = hardness + " Egg"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        //example functionality
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            percentageLabel.text = String((secondsPassed / totalTime) * 100) + "%"
            print(percentageLabel.text!)
            
            DispatchQueue.main.async{
                self.mylabel.text! = "Keep Boiling"
            }
            
        } else if totalTime == secondsPassed {
            timer.invalidate()
            DispatchQueue.main.async{
                self.mylabel.text! = "Done"
                let _:NSURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")! as NSURL
            }
            playSound()
        }
}
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error as NSError {
            print(error.description)
        }
    }
}
