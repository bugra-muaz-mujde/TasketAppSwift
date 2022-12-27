//
//  TasketView.swift
//  Tasket
//
//  Created by queque on 27.12.2022.
//

import SwiftUI

struct TaskRow: View {
    var task:String
    
    var body: some View {
        Text(task)
    }
}

struct TasketListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
        
    @FetchRequest(entity: Tasks.entity(), sortDescriptors: [])
    private var tasks: FetchedResults<Tasks>
    
    @State var current_progress = "to_do"
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                List {
                    ForEach(tasks, id: \.self) { task in
                        if (task.task_progress == self.current_progress) {
                            HStack {
                                Text(task.task_name ?? "Not found")
                                Spacer()
                            }.swipeActions(edge: .leading, allowsFullSwipe: false){
                                Button{
                                    if self.current_progress == "to_do"{
                                        update_progress(task: task, progress: "in_progress")
                                    } else if self.current_progress == "in_progress" {
                                        update_progress(task: task, progress: "done")
                                    } else if self.current_progress == "done" {
                                        update_progress(task: task, progress: "in_progress")
                                    }
                                } label: {
                                    if self.current_progress == "to_do" {
                                        Label("In Progress", systemImage: "")
                                    } else if self.current_progress == "in_progress" {
                                        Label("Done", systemImage: "")
                                    } else if self.current_progress == "done" {
                                        Label("In Progress", systemImage: "")
                                    }
                                }.tint(.orange)
                            }.swipeActions{
                                Button (role: .destructive) {
                                    withAnimation {
                                        viewContext.delete(task)
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            // show error
                                        }
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Product Database")
                Spacer()
                TasketBottomBar()
                    .padding(.bottom, 20.0)
            }.navigationBarTitle("Tasket APP", displayMode: .inline)
                .navigationBarItems(
                    leading:
                        HStack{
                            Button(action: {
                                if self.current_progress == "to_do"{
                                    self.current_progress = "on_hold"
                                } else if self.current_progress == "in_progress" {
                                    self.current_progress = "to_do"
                                } else {
                                    self.current_progress = "in_progress"
                                }
                            }){
                                if self.current_progress == "in_progress" {
                                    Text("To Do")
                                } else if self.current_progress == "done" {
                                    Text("In Progress")
                                } else if self.current_progress == "to_do" {
                                    Text("On Hold")
                                }
                            }
                        }
                    ,trailing:
                        HStack{
                            Button(action: {
                                if self.current_progress == "to_do" {
                                    self.current_progress = "in_progress"
                                } else if self.current_progress == "on_hold" {
                                    self.current_progress = "to_do"
                                } else {
                                    self.current_progress = "done"
                                }
                            }){
                                if self.current_progress == "in_progress" {
                                    Text("Done")
                                } else if self.current_progress == "to_do" {
                                    Text("In Progress")
                                } else if self.current_progress == "on_hold" {
                                    Text("To Do")
                                }
                            }
                        }
                )
        }
    }
    
    private func update_progress(task:Tasks, progress:String){
        task.task_progress = progress
        save_context()
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

struct TasketView_Previews: PreviewProvider {
    static var previews: some View {
        TasketListView()
            .previewInterfaceOrientation(.portrait)
    }
}

