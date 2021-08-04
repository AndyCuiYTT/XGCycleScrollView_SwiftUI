//
//  XGCycleScrollView_SwiftUIApp.swift
//  XGCycleScrollView_SwiftUI
//
//  Created by CuiXg on 2021/8/4.
//

import SwiftUI

@main
struct XGCycleScrollView_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            XGCycleScrollView(imagesUrl: ["https://img0.baidu.com/it/u=251614576,2693916083&fm=26&fmt=auto&gp=0.jpg",
                                          "https://img2.baidu.com/it/u=1728522718,1340994382&fm=26&fmt=auto&gp=0.jpg",
                                          "https://img0.baidu.com/it/u=103721101,4076571305&fm=26&fmt=auto&gp=0.jpg",
                                          "https://img0.baidu.com/it/u=1824151452,3654743938&fm=26&fmt=auto&gp=0.jpg"],
                              spacing: 10, cornerRadius: 10) { index in
                print("dddddddddddd---\(index)")
            }
        }
    }
}
