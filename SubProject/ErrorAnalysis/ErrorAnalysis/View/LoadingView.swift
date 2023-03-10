//
//  LoadingView.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/2/10.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("解析中")
            .frame(width: 80, height: 80)
            .cornerRadius(10)
            .shadow(color: .black, radius: 10, x: 0, y: 0)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
