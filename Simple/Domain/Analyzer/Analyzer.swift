//
//  Analyzer.swift
//  Simple
//
//  Created by Mikael Weiss on 3/16/21.
//

import Foundation

class Analyzer: TaskAnalyzer {
    private var skippedFilter: TaskFilter
    private var timeFrameFilter: TaskFilter
    private var recurrenceFilter: TaskFilter
    private var priorityAnalyzer: TaskAnalyzer
    
    init(skippedFilter: TaskFilter,
         timeFrameFilter: TaskFilter,
         recurrenceFilter: TaskFilter,
         priorityAnalyzer: TaskAnalyzer) {
        
        self.skippedFilter = skippedFilter
        self.timeFrameFilter = timeFrameFilter
        self.recurrenceFilter = recurrenceFilter
        self.priorityAnalyzer = priorityAnalyzer
    }
    
    func sorted(tasks: [Task], given date: Date) -> [Task] {
        let skipFiltered = skippedFilter.filter(tasks: tasks, given: date)
        let timeFrameFiltered = timeFrameFilter.filter(tasks: skipFiltered, given: date)
        let recurrenceFiltered = recurrenceFilter.filter(tasks: timeFrameFiltered, given: date)
        let priorityAnalyzed = priorityAnalyzer.sorted(tasks: recurrenceFiltered, given: date)
        return priorityAnalyzed
    }
}
