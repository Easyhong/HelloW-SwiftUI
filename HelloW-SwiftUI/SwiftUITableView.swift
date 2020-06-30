//
//  SwiftUITableView.swift
//  HelloW-SwiftUI
//
//  Created by ronzhang on 2020/6/30.
//  Copyright © 2020 ronzhang. All rights reserved.
//

import SwiftUI

struct SwiftUITableView: View {
    var body: some View {
        PageTabViewStyleExampleView()
    }
}


struct PageTabViewStyleExampleView: View {
    
    let colors: [Color] = [.red, .green, .orange, .blue]

    var body: some View {
        TabView {
            ForEach(0..<4) { index in
                    Text("Tab \(index)")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(self.colors[index])
                    .cornerRadius(8)
                }
        }
          
        //.tabViewStyle(PageTabViewStyle())
    }
}

struct SwiftUITableView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITableView()
    }
}

//WindowGroup {
//           TabView {
//               Text("The First Tab")
//                   .tabItem {
//                       Image(systemName: "1.square.fill")
//                       Text("First")
//                   }
//               Text("Another Tab")
//                   .tabItem {
//                       Image(systemName: "2.square.fill")
//                       Text("Second")
//                   }
//               Text("The Last Tab")
//                   .tabItem {
//                       Image(systemName: "3.square.fill")
//                       Text("Third")
//                   }
//           }
//           .font(.headline)
//           .tabViewStyle(PageTabViewStyle())
//       }
