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
    
    //var task:Task
    
    override func setUp() {
        super.setUp()
        //self.initVC = InitialViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testTaskItem() {
        let task = Task(taskID: "exampleID", taskName: "Example Task", taskDescription: "Task is an example", taskCreated: "01/2017", taskDue: "Example", taskCompleted: false , pointValue: 5)
        XCTAssertEqual(task.taskName, "Example Task", "Task name should be equal to Example Task")
    }
    
    
    func testtaskList() {
        let task = Task(taskID: "exampleID", taskName: "Example Task", taskDescription: "Task is an example", taskCreated: "01/2017", taskDue: "Example", taskCompleted: false , pointValue: 5)
        let store = DataStore.sharedInstance
        store.tasks = [task]
        XCTAssertEqual(store.tasks.count, 1, "Should be one task in tasks")
    }
    
    
    func testPerformanceExample() {
        
        // This is an example of a performance test case.
        self.measure {
            //  self.initVC.initView.zoomAnimation()
            // Put the code you want to measure the time of here.
        }
    }
    
}
