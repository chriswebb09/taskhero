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

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTaskItem() {
        let task = Task(taskID: "exampleID", taskName: "Example Task", taskDescription: "Task is an example", taskCreated: "01/2017", taskDue: "Example", taskCompleted: false , pointValue: 5)
        XCTAssertEqual(task.taskName, "Example Task", "Task name should be equal to Example Task")
    }
    
    func testTaskList() {
        let task = Task(taskID: "exampleID", taskName: "Example Task", taskDescription: "Task is an example", taskCreated: "01/2017", taskDue: "Example", taskCompleted: false , pointValue: 5)
        let store = DataStore.sharedInstance
        store.tasks = [task]
        XCTAssertEqual(store.tasks.count, 1, "Should be one task in tasks")
    }
    
    func testUserProperties() {
        let task = Task(taskID: "exampleID", taskName: "Example Task", taskDescription: "Task is an example", taskCreated: "01/2017", taskDue: "Example", taskCompleted: false , pointValue: 5)
        let store = DataStore.sharedInstance
        store.currentUser = User(uid: "exampleUserID", email: "example@email.com", firstName: "First", lastName: "Last", profilePicture: "None", username: "exampleUser", experiencePoints: 0, level: "Task Goat", joinDate: "Today", tasks: [task], numberOfTasksCompleted: 0)
        XCTAssertEqual(store.currentUser.tasks?.count, 1, "Should be one task in current user tasks")
    }
    
    func testSharedInstance() {
        let shared = DataStore.sharedInstance
        XCTAssertNotNil(shared, "not nil")
    }
    
    func testLogin() {
        var loginViewController = LoginViewController()
        //loginViewController.store = DataStore.sharedInstance
        loginViewController.viewDidLoad()
        loginViewController.loginView.emailField.text = "chris.webb5249@gmail.com"
        loginViewController.loginView.passwordField.text = "123456"
        loginViewController.loadingView = LoadingView()
        XCTAssertNotNil(loginViewController.handleLogin(), "Handled login")
        XCTAssertNotNil(loginViewController.store, "Handled login")
        XCTAssertEqual(loginViewController.store.currentUser, nil)
        //loginViewController.viewDidLoad()
        //XCTAssertNotNil(loginViewController.store.currentUser, "\(loginViewController.store.currentUser)")
       // XCTAssertEqual(loginViewController.store.currentUser.email, "chris.webb5249@gmail.com")
       //
    }
    
    
    func testPerformanceExample() {
        
        // This is an example of a performance test case.
        self.measure {
            
            // Put the code you want to measure the time of here.
        }
    }
    
}
