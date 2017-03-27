//
//  SongDetailViewController.swift
//  EcoSound
//
//  Created by Pradeep Choudhary on 3/27/17.
//  Copyright © 2017 Pardeep chaudhary. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class SongDetailViewController: UIViewController {
    
    var selectedMusicInformationModelObject : MusicInformation!
    var audioPlayer:AVAudioPlayer!
    var audioTimer : Timer?

    
    @IBOutlet weak var labelSongName: UILabel!
    @IBOutlet weak var labelArtist: UILabel!
    @IBOutlet weak var labelAlbum: UILabel!
    @IBOutlet weak var labelType: UILabel!
    
    
    @IBOutlet weak var labelEndTime: UILabel!
    @IBOutlet weak var labelElapsed: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    //MARK:- view life cycle methods
    override func viewDidLoad() {
        setUI()
        setUpAudioPlayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
        invalidateTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        audioPlayer.stop()
        invalidateTimer()
    }
    
    //Set the label and other IBOutlets values
    private func setUI(){
        self.navigationItem.title = "Song detail"
        labelSongName.text = selectedMusicInformationModelObject.song
        setAttributedTextOnArtistLabel(labelInstance: labelArtist, heading: "Artist", artistName: selectedMusicInformationModelObject.artists!)
        setAttributedTextOnArtistLabel(labelInstance: labelAlbum, heading: "Album", artistName: selectedMusicInformationModelObject.album!)
        setAttributedTextOnArtistLabel(labelInstance: labelType, heading: "Type", artistName: selectedMusicInformationModelObject.type!)
    }
    
    private func setDurationLabel(){
        labelEndTime.text = stringFromTimeInterval(interval: audioPlayer.duration)        
    }
    
    //Set up audio player and play
    private func setUpAudioPlayer(){
        //Have the ability to run in the background, allowing for other sounds to be output while continuing to play the .mp3
        let audioSession = AVAudioSession.sharedInstance()
        _ = try? audioSession.setCategory(AVAudioSessionCategoryPlayback, with: [.mixWithOthers])
        _ = try? audioSession.setActive(true)
        
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: selectedMusicInformationModelObject.pathString!)
            audioPlayer.play()
         
            addTimer()
            setDurationLabel()
        }
        catch
        {
            print("An error occurred while trying to extract audio")
        }
    }
    
    //MARK:- Timer functionality
    //Timer to update the progress view
    private func addTimer(){
        audioTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
        progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
    }
    
    //Invalidate the timer for memory optimization
    private func invalidateTimer(){
        if audioTimer != nil {
            audioTimer?.invalidate()
            audioTimer = nil
        }
    }
    
    func updateAudioProgressView()
    {
        if audioPlayer.isPlaying
        {
            labelElapsed.text = stringFromTimeInterval(interval: audioPlayer.currentTime)
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)   //Update progress
        }
    }
    
    //MARK:- IBAction methods
    
    @IBAction func btnPlayAction(_ sender: UIBarButtonItem) {
        if !audioPlayer.isPlaying{
            audioPlayer.play()
        }
    }
    
    @IBAction func btnPauseAction(_ sender: UIBarButtonItem) {
        audioPlayer.pause()
    }
    
    @IBAction func btnStopAction(_ sender: UIBarButtonItem) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressView.progress = 0.0
        labelElapsed.text = "00:00"
    }
    
    //MARK:- Attributed text helper methods
    private func setAttributedTextOnArtistLabel(labelInstance : UILabel, heading : String, artistName : String){
        let departureAttribute = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 14.0),
            NSForegroundColorAttributeName : UIColor.black,
            ]
        let departureAttributedString = NSMutableAttributedString(string: String(format: "%@ ⇾ ",heading), attributes: departureAttribute)
        
        let arrivalAttribute = [
            NSFontAttributeName : UIFont.systemFont(ofSize: 14.0),
            NSForegroundColorAttributeName : getRandomColor()
            ]
        let arrivalAttributedString = NSAttributedString(string: String(format: "%@", artistName), attributes: arrivalAttribute)
        
        departureAttributedString.append(arrivalAttributedString)
        labelInstance.attributedText = departureAttributedString
    }

    //MARK:- Utility methods (These utility methods can be moved to separate utility class in case of multiple view controllers)
    private func getRandomColor() -> UIColor{
        let randomRed = Float(drand48())
        let randomGreen = Float(drand48())
        let randomBlue = Float(drand48())
        return UIColor.init(colorLiteralRed: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let ti = NSInteger(interval)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        
        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
}
