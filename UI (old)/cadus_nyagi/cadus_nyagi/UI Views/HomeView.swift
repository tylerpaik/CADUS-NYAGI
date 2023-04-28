//
//  homeView.swift
//HomeView.swift
//  cadus_nyagi
//
//  Created by Anna Easter on 2/24/23.
//


import SwiftUI
import UIKit


struct HomeView: View {
    
//    @EnvironmentObject var bodyOptionsList: bodyOptions
    @EnvironmentObject var bodyOptionsList: bodyOptions
    
    var body: some View {
        NavigationView{
            
            VStack{
                
                Image("Logo").frame(height: 80)
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    let layout = [
                        GridItem(.adaptive(minimum: 210, maximum: 250)),
                    ]
                    
                    LazyVGrid(columns: layout) {
                        
                        ForEach(bodyOptionsList.categories.keys.sorted(by : >), id: \.self) { key in
                            
                            NavigationLink{
                                GiveUltrasoundView(name: key)
                            } label: {
                                areaButton(name: key)
                            }
                            
                            
                        }.padding(10)
                        
                    }.padding(.top, 20)
                    
                }.background(Color(red: 0.8, green: 0.9, blue: 1))
                
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
    }
    
    
    
    
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(bodyOptions())
    }
}