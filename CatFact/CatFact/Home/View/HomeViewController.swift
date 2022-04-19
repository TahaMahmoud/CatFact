//
//  ViewController.swift
//  CatFact
//
//  Created by Taha on 17/04/2022.
//

import UIKit
import Lottie
import Combine

class HomeViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    private var homeAnimation: AnimationView?
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimationView: CustomView!
    private var loaderAnimation: AnimationView?

    @IBOutlet weak var factText: UITextView!
    
    var subscriptions = Set<AnyCancellable>()
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindLoader()
        bindFactText()

        startHomeAnimation()
        
        viewModel.viewDidLoad()
    }

    func startHomeAnimation() {

        homeAnimation = .init(name: "cat_home")
        homeAnimation!.frame = animationView.bounds
        homeAnimation!.contentMode = .scaleAspectFill
        homeAnimation!.loopMode = .loop
        homeAnimation!.animationSpeed = 0.5
        animationView.addSubview(homeAnimation!)
                
        homeAnimation!.play()

    }
    
    func startLoaderAnimation() {

        loaderAnimation = .init(name: "cat_loading")
        loaderAnimation!.frame = loaderAnimationView.bounds
        loaderAnimation!.contentMode = .scaleAspectFill
        loaderAnimation!.loopMode = .loop
        loaderAnimation!.animationSpeed = 0.5
        loaderAnimationView.addSubview(loaderAnimation!)
                
        loaderAnimation!.play()

    }

    @IBAction func getNewFactTapped(_ sender: Any) {
        viewModel.fetchFact()
    }
    
    func bindFactText() {
        viewModel.$fact
            .sink(receiveValue: { [weak self] fact in
                self?.factText.text = fact
            })
            .store(in: &subscriptions)
    }
    
    func bindLoader() {
        viewModel.$indicator
            .sink(receiveValue: { [weak self] isLoading in
                
                DispatchQueue.main.async {
                    if isLoading ?? false {
                        self?.loaderView.isHidden = false
                        self?.startLoaderAnimation()
                    }
                    else {
                        self?.loaderView.isHidden = true
                        self?.loaderAnimation?.stop()
                        self?.loaderAnimation?.removeFromSuperview()
                    }
                }

            })
            .store(in: &subscriptions)
    }

}

