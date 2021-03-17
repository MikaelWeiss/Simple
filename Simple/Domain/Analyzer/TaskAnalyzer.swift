//
//  TaskAnalyzer.swift
//  Simple
//
//  Created by Mikael Weiss on 3/16/21.
//

import Foundation

protocol TaskAnalyzer {
    func sorted(tasks: [Task]) -> [Task]
}
