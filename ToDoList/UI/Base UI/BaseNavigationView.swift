//
//  BaseNavigationView.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import SwiftUI

struct BaseNavigationView<Content, Toolbar> : View where Content : View, Toolbar : ToolbarContent {
    private var content: Content
    private var toolBar: Toolbar

    init(@ViewBuilder content: () -> Content, @ToolbarContentBuilder toolBar: () -> Toolbar) {
        self.content = content()
        self.toolBar = toolBar()
    }

    var body: some View {
        NavigationView {
            content
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    toolBar
                }
        }
    }
}
