//
//  List.swift
//  Simple
//
//  Created by Mikael Weiss on 3/20/21.
//

import Foundation

struct List {
    private(set) var tasks: [Task]
    private(set) var timeFrames: Set<TimeFrame>
    private(set) var observedTasks: [ObservedTask]
}
