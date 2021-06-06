//
//  ViewController.swift
//  prac_CAEmitterLayer
//
//  Created by 남수김 on 2020/06/19.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createParticles()
        view.backgroundColor = .black
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createParticles()
    }
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()
        particleEmitter.lifetime = 5.0
        
        // MARK: 설정
        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: 100)
//        particleEmitter.zPosition = 100
//        particleEmitter.emitterDepth = 100
//        particleEmitter.emitterZPosition = 100
        
        // 뿌려지는 모양
        particleEmitter.emitterShape = .point
        // 뿌려지는 컨테이너의 크기
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
//        particleEmitter.emitterMode = .volume
        particleEmitter.velocity = 2
        particleEmitter.renderMode = .additive
        
        let white = makeEmitterCell(color: .white)
        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: UIColor.green)
        let blue = makeEmitterCell(color: UIColor.blue)
        
        particleEmitter.birthRate = 1
        
        let firework = makeEmiterCellFirework()
        particleEmitter.emitterCells = [white]
        white.emitterCells = [firework]

        view.layer.addSublayer(particleEmitter)
        
    }
    // layer위에 셀이 생성됨
    // 기본 layer값에 cell의 속성이 더해지는식
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 20
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        
        // MARK: 색관련
        cell.color = color.cgColor
        // alpha값 줄어드는 오차범위
        cell.alphaRange = 0.5
        // red값 오차범위
//        cell.redRange = 100
//         red값 변하는속도
//        cell.redSpeed = 50
//        cell.blueRange = 100
//        cell.blueSpeed = 50
//        cell.greenRange = 100
//        cell.greenSpeed = 50
        // alpha값 줄어드는 속도
        cell.alphaSpeed = -0.3
        
        // MARK: 속도관련
        // 클수록 방향전환영향도 커짐
        cell.velocity = 100
        cell.velocityRange = 1
        // y방향으로 가속도
        cell.yAcceleration = 60
        // 효과 뿌려지는 각도조절
//        cell.emissionLongitude = .pi/2
        cell.emissionRange = .pi * 2
//        cell.emissionLatitude = .pi/2
        cell.spin = 3
        cell.spinRange = 3
        cell.scale = 0.1
        cell.scaleRange = 0.01
        cell.scaleSpeed = -0.01

        cell.contents = UIImage(named: "snow")?.cgImage

        return cell
    }
    
    func makeEmiterCellFirework() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 50
        cell.velocity = 100
        cell.lifetime = 1.0
        cell.emissionRange = (2 * .pi)
        /* determines size of explosion */
        cell.scale = 0.3
        cell.alphaSpeed = -0.2
        cell.yAcceleration = 80
        cell.beginTime = 1.5
        cell.duration = 0.1
        cell.scaleSpeed = -0.015
        cell.spin = 2
        
        cell.redRange = 100
        cell.redSpeed = 50
        cell.blueRange = 100
        cell.blueSpeed = 50
        cell.greenRange = 100
        cell.greenSpeed = 50
        cell.contents = UIImage(named: "snow")?.cgImage
        return cell
    }
    

}

