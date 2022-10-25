//
//  ContentView.swift
//  extension.signing.demo
//
//  Created by Elia Schenker on 24.10.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "square.and.arrow.up")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Image(systemName: "folder.badge.gearshape")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            Text("App Extension Test").padding(.top, 10).font(.title).padding(.bottom, 10)
            Text("Please enable the app extension, if possible.\n As you can see, they will only appear/run if you run the version containing \n unsigned app extension.").multilineTextAlignment(.center)
            Text("To confirm this you can run the top command with grep to check for running extensions.").multilineTextAlignment(.center)
            Button("Open Extensions Preferences") {
                let prefpaneUrl = URL(fileURLWithPath: "/System/Library/PreferencePanes/Extensions.prefPane")
                NSWorkspace.shared.open(prefpaneUrl)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
