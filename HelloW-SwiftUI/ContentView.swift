//
//  ContentView.swift
//  HelloW-SwiftUI
//
//  Created by ronzhang on 2020/6/29.
//  Copyright © 2020 ronzhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    var colors: [Color]
    
    var body: some View {
        
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                 
                 VStack(alignment: .center, spacing: 0) {
                     
                     ForEach(colors, id: \.self) { color in
                         
                         VStack(alignment: .center, spacing: 0) {
                             Rectangle().foregroundColor(color)
                             .frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
                             
                              Button(action: {
                                         print("Delete tapped!")
                                     }) {
                                         HStack {
                                             Image(systemName: "trash")
                                                 .font(.title)
                                             Text("Delete")
                                                 .fontWeight(.semibold)
                                                 .font(.title)
                                         }
                                         .padding()
                                          //   .frame(minWidth: 0, maxWidth: .infinity)

                                         .foregroundColor(.white)
                                             
                                             .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                                             .cornerRadius(40)
                                     }
                         
                         }
                            
                         
                     }
                     
                 }.padding(.vertical, 10)
                 
            }
            
            .edgesIgnoringSafeArea(.bottom).navigationBarTitle(Text("helloW").foregroundColor(.red), displayMode: NavigationBarItem.TitleDisplayMode.inline)
            .navigationBarBackButtonHidden(false)
            
            .background(NavigationConfigurator { nc in
                               nc.navigationBar.barTintColor = UIColor(named: "red")
                           })
        }

 
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(colors: [.blue, .red, .yellow] )
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}
