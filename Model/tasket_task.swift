//
//  task_model.swift
//  Tasket
//
//  Created by queque on 26.12.2022.
//

import Foundation

enum TaskProgress: String, CaseIterable {
    case to_do = "TO DO"
    case in_progress = "IN PROGRESS"
    case on_hold = "ON HOLD"
    case done = "DONE"
}

class TasketTask {
    
    let id: UUID
    var task: String
    var progress: TaskProgress
    
    init(id:UUID, task:String, progress:TaskProgress) {
        self.id = id
        self.task = task
        self.progress = progress
    }
}
