//
//  MainView.swift
//  ScreenLock
//
//  Created by sharui on 2022/12/27.
//

import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity
import Foundation
import StoreKit
struct MainView: View {
    @EnvironmentObject var center : AuthorizationCenter
    @EnvironmentObject var launchManager : LaunchManager
    @State private var selection: Tab = .featured
    enum Tab {
        case featured
        case setting
    }
    
    var body: some View {
//        ContentToastView()
        if (launchManager.showAuthority) {
            TabView(selection: $selection) {
                HomePage()
                    .tabItem{
                        Label("应用程序" , systemImage: "apps.iphone.badge.plus")
                    }
                    .tag(Tab.featured)

                SettingPage()
                    .tabItem {
                        Label("设置" , systemImage: "gear")
                    }
                    .tag(Tab.setting)
            }
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
            }
            .accentColor(.blue) //设置文字默认选中颜色
        } else {
            VStack() {
                Image("undraw_Dog")
                Text("请您授权")
                    .fontWeight(.heavy)
                Text("如果授权失败，请重新啊打开App")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .padding()
            }
        }
    }
}

struct ContentSahuaView: View {
    @State private var showConfetti = false

    var body: some View {
        ZStack {
            // Your other views here

            if showConfetti {
                ConfettiView()
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .animation(.easeInOut(duration: 1.0))
            }
        }
        .onAppear {
            self.showConfetti = true
        }
    }
}

struct ConfettiView: View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .pink, .purple]

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<100) { index in
                Circle()
                    .foregroundColor(self.colors[index % self.colors.count])
                    .frame(width: 10, height: 10)
                    .offset(x: CGFloat.random(in: -100...100), y: CGFloat.random(in: -100...100))
                    .rotationEffect(Angle(degrees: Double.random(in: 0...360)))
                    .animation(Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5))
                    .position(x: CGFloat.random(in: 0...geometry.size.width), y: CGFloat.random(in: 0...geometry.size.height))
            }
        }
    }
}

