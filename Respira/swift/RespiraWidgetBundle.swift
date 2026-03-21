//
//  RespiraWidgetBundle.swift
//  RespiraWidget
//
//  Created by Amada Hernández Borges on 3/21/26.
//

import WidgetKit
import SwiftUI


struct RespiraWidgetBundle: WidgetBundle {
    var body: some Widget {
        RespiraWidget()
        RespiraQuickActionWidget()
    }
}
