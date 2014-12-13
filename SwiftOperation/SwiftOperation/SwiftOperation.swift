//
//  SwiftOperation.swift
//  SwiftOperation
//
//  Created by jins on 14/12/13.
//  Copyright (c) 2014年 BlackWater. All rights reserved.
//

import Foundation

public class Operation {
    // Event
    let beginEvent = Event(name: "begin", code: "begin")
    let pauseEvent = Event(name: "pause", code: "pause")
    let resumeEvent = Event(name: "resume", code: "resume")
    let progressEvent = Event(name: "progress", code: "progress")
    let fulfillEvent = Event(name: "fulfill", code: "fulfill")
    let rejectEvent = Event(name: "reject", code: "reject")
    let resetEvent = Event(name: "reset", code: "reset")
    
    // State
    let idle = StateType(name: "idle")
    let running = StateType(name: "running")
    let paused = StateType(name: "paused")
    let fulfilled = StateType(name: "fulfilled")
    let rejected = StateType(name: "rejected")
    
    // Machine
    var machine: StateMachine
    
    // Controller
    var controller: Controller
    
    
    init() {
        // Transition
        idle.addTransition(beginEvent, toState: running)
        running.addTransition(pauseEvent, toState: paused)
        paused.addTransition(resumeEvent, toState: running)
        running.addTransition(progressEvent, toState: running)
        running.addTransition(fulfillEvent, toState: fulfilled)
        running.addTransition(rejectEvent, toState: rejected)
        paused.addTransition(rejectEvent, toState: rejected)
        
        machine = StateMachine(initState: idle)
        machine.addResetEvents(resetEvent)
        
        controller = Controller(currentState: idle, machine: machine)
        
        self.setupAction()
    }
    
    func setupAction() {
        self.running.entry = {
            progress in
            println(progress)
        }
        self.rejected.entry = {
            _ in
            println("I am cancel")
        }
        self.fulfilled.entry = {
            value in
            println("I am fulfill: \(value)")
        }
        self.paused.entry = {
            _ in
            println("I am pause")
        }
    }
    
    public func begin() {
        self.controller.handle("begin")
    }
    
    public func progress(time: AnyObject) {
        self.running.entryValue = time
        self.controller.handle("progress")
    }
    
    public func pause() {
        self.controller.handle("pause")
    }
    
    public func resume() {
        self.controller.handle("resume")
    }
    
    public func cancel() {
        self.controller.handle("reject")
    }
    
    public func success(value: AnyObject) {
        self.fulfilled.entryValue = value
        self.controller.handle("fulfill")
    }

}