//
//  AnimationView.swift
//  BabyTracker
//
//  Created by Nilgul Cakir on 18.01.2024.
//

import Foundation
import UIKit
import Lottie

extension UIView {
    func blurEffects(lottie: LottieAnimationView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        
        lottie.animation = LottieAnimation.named("saved")
        self.addSubview(lottie)
        lottie.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        lottie.play()
    }
}
