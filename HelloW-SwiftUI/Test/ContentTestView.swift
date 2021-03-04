//
//  ContentTestView.swift
//  HelloW-SwiftUI
//
//  Created by taozhang on 2020/12/9.
//  Copyright © 2020 ronzhang. All rights reserved.
//

import SwiftUI

struct ContentTestView: View {
   
    @State private var results = [Result]()
    
    var color: Color = Color(.sRGB, red: 0.90, green: 0.90, blue: 0.99, opacity: 1.0)

    var body: some View {
        
        List(results, id: \.trackId) { item in
            
            ZStack {
                
                 Rectangle()
                    .foregroundColor(color)
                    .frame(width: UIScreen.main.bounds.width, height: 120, alignment: .leading)
                    .cornerRadius(4)
                
              
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text("\(item.trackId)")
                        Text(item.trackName).font(.subheadline)
                        Text(item.collectionName)
                    }.padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                    Spacer()
                }
                
            }

            
        }
        .onAppear {
          
            loadData()
            UITableView.appearance().separatorColor = .clear
        }
        .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 14))
        
        
    }
    
    
    func loadData() -> Void {
       
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let data = data {
                
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                        print("data: \(decodedResponse.results)")
                    }
                    return
                }
            }
            // 如果代码跑到这里了，说明发生了某些错误
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}

struct ContentTestView_Previews: PreviewProvider {
    static var previews: some View {
        ContentTestView()
    }
}



struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

