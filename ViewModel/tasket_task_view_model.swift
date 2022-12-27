//
//  task_view_model.swift
//  Tasket
//
//  Created by queque on 26.12.2022.
//

import Foundation

class TasketTaskViewModel {
    
    var tasket_tasks:Array<TasketTask>
    
    init(){
        self.tasket_tasks = []
    }
    
    func feed_tasks_from_core_data(tasket_task:TasketTask){
        self.tasket_tasks.append(tasket_task)
    }
    
    func add_task_to_tasket_tasks(tasket_task:TasketTask){
        self.tasket_tasks.append(tasket_task)
    }
    
    func pop_task_to_tasket_tasks(tasket_task_id:Int) {
        
    }
    
    func update_task(tasket_task:TasketTask, new_tasket_task: String){
        tasket_task.task = new_tasket_task
    }
    
}
