//
//  TaskHeroTests.swift
//  TaskHeroTests
//
//  Created by Christopher Webb-Orenstein on 12/8/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import XCTest
@testable import TaskHero

class TaskHeroTests: XCTestCase {
    
    var initVC: InitialViewController!
    
    override func setUp() {
        super.setUp()
        self.initVC = InitialViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    func testForInitView() {
        self.initVC.viewDidLoad()
        self.initVC.initView.layoutSubviews()
        XCTAssertNotNil(self.initVC.initView)
        self.initVC.initView.logoImageView = UIImageView(image: UIImage(named:"TaskHeroLogoNew2"))
        XCTAssertNotNil(self.initVC.initView.logoImageView)
        self.initVC.initView.loginButton = ButtonType.login(title: "login").newButton
        XCTAssertNotNil(self.initVC.initView.loginButton)
        dump(self)
    }
    
    
    
    func testExample() {
        
    }
    
    func testPerformanceExample() {
        
        // This is an example of a performance test case.
        self.measure {
            self.initVC.initView.zoomAnimation()
            // Put the code you want to measure the time of here.
        }
    }
    
}
