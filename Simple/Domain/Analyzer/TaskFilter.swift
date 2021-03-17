//
//  TaskFilter.swift
//  Simple
//
//  Created by Mikael Weiss on 3/16/21.
//

import Foundation

protocol TaskFilter {
    func filter(tasks: [Task], given date: Date) -> [Task]
}
