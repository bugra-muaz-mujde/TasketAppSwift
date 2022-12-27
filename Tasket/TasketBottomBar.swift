//
//  TasketBottomBar.swift
//  Tasket
//
//  Created by queque on 27.12.2022.
//

import SwiftUI

struct TasketBottomBar: View {
    
    @State private var is_show_add_alert = false
    @State private var task_name: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        HStack(alignment: .center){
            Spacer()
            Button(action:{
                alertAddView(
                    title: "LOGIN",
                    message: "Please enter a task!",
                    hint_text: "Task",
                    primary_title: "ADD",
                    secondary_title: "CANCEL",
                    primary_action: {text in create_task(task_name: text)},
                    secondary_action: {
                    }
                )
            }){
                Image("plus")
            }
            
            Spacer()
            
            Button(action:{
                print("asda")
            }){
                Image("search")
            }
            Spacer()
        }
    }
    
    private func create_task(task_name:String){
        let task = Tasks(context: viewContext)
        task.task_id = UUID().uuidString
        task.task_name = task_name
        task.task_progress = "to_do"
        
        self.save_context()
    }
    
    private func save_context() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }

}

struct TasketBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        TasketBottomBar()
    }
}


extension View {
    
    func alertAddView(
        title:String,
        message:String,
        hint_text:String,
        primary_title:String,
        secondary_title:String,
        primary_action:@escaping (String)->(),
        secondary_action:@escaping ()->()
    ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = hint_text
        }
        alert.addAction(.init(title: secondary_title, style: .cancel, handler: {_ in
            secondary_action()
        }))
        
        alert.addAction(.init(title: primary_title, style: .default, handler: {_ in
            if let text = alert.textFields?[0].text{
                primary_action(text)
            } else{
                primary_action("")
            }
        }))
        
        rootController().present(alert, animated: true, completion: nil)
    }
    
    func rootController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}

