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

    @IBOutlet weak var labelEndTime: UILabel!
    @IBOutlet weak var labelElapsed: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    //MARK:- view life cycle methods
    override func viewDidLoad() {
        setUpAudioPlayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
        invalidateTimer()
    }
    
    //Set the label and other IBOutlets values
    private func setUI(){
        labelEndTime.text = "\(Float(audioPlayer.duration))"
    }
    
    //Set up audio player and play
    private func setUpAudioPlayer(){
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: selectedMusicInformationModelObject.pathString!)
            audioPlayer.play()
         
            addTimer()
            setUI()
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
            labelElapsed.text = "\(Float(audioPlayer.currentTime/audioPlayer.duration))"
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
    }
}
