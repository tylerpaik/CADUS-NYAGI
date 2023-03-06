//
//  ContentView.swift
//  cadus_nyagi
//
//  Created by Anna Easter on 2/24/23.
//

import SwiftUI

import SwiftUI
import UIKit


struct homeView: View {
    
    @State private var showEditView = false
    @State private var addWordView = false
    @State private var addCategoryView = false
    @State private var showCategory = false
    @State private var maximumWidth = Double.infinity
    @State private var maximumHeight = Double.infinity
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(){

                if realmManager.viewController == "keyboard" {
                    KeyboardModeView().environmentObject(realmManager)
                } else if realmManager.viewController == "edit" {
                    HStack(){
                        AddWordButton().onTapGesture{
                            addWordView.toggle()
                        }.sheet(isPresented: $addWordView) {
                            AddWordView().environmentObject(realmManager)
                        }

                        AddCategoryButton().onTapGesture{
                            addCategoryView.toggle()
                        }.sheet(isPresented: $addCategoryView) {
                            AddCategoryView().environmentObject(realmManager)
                        }
                    }.frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
                    .background(.green)
                    

                    CurrentLocationView().environmentObject(realmManager)

                    if realmManager.currCat == nil {
                        WordsEditView().environmentObject(realmManager)
                        CategoryEditView().environmentObject(realmManager)
                    }
                    else{
                        CatDisplayView().environmentObject(realmManager)
                    }
                } else {
                    HStack(){
                        PlayButton().onTapGesture{

                                let playerItem = AVPlayerItem(url: URL(string: "https://api.voicerss.org/?key=013e3effb971484786ba6c657af1cb70&hl=en-us&c=MP3&src=\(realmManager.stringSentence)")!)
                                player = AVPlayer(playerItem: playerItem)
                                player?.play()
                        }
                        SentenceView().environmentObject(realmManager)
                        DeleteButton().onTapGesture {
                            realmManager.deleteSentenceWord()
                        }
                    }

                    CurrentLocationView().environmentObject(realmManager)

                    if realmManager.currCat == nil {
                        let layout = [
                            GridItem(.adaptive(minimum: 130, maximum: 140)),
                        ]
                        
                        LazyVGrid(columns: layout) {
                            
                            WordsView().environmentObject(realmManager)
                            CategoriesView().environmentObject(realmManager)
                            
                        }
                    }
                    else{
                        let layout = [
                            GridItem(.adaptive(minimum: 130, maximum: 140)),
                        ]
                        
                        ZStack() {
                            CatDisplayView().environmentObject(realmManager).zIndex(2)
                            LazyVGrid(columns: layout) {
//                                ZStack() {
                                WordsView().environmentObject(realmManager)
                                CategoriesView().environmentObject(realmManager)
                                //}
                                
                            }.zIndex(3)
                            
                            
                            ////////
                            //Image(uiImage: realmManager.screenshotView!)
                        
                        }
                    }
                }
                
                Spacer()


                HStack() {
                    homeButton()
                    }
                }.frame(maxWidth: .infinity, maxHeight: 50, alignment: .bottom)
                    .background(.white)

            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(hue: 288, saturation: 0.03, brightness: 0.87))
            
    }
}



struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
