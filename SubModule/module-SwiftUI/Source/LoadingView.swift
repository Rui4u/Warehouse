//
//  LoadingView.swift
//  CoverApps
//
//  Created by sharui on 2023/3/7.
//

import SwiftUI

struct SRLoadingView: View {
    
    var body: some View {
        LoadingView(isShowing: .constant(true)) {
            VStack {
                Text("ceshi")
            }
        }
    }
}

struct SRLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SRLoadingView()
    }
}



public struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var message: String = "Loading..."
    var content: () -> Content
    public init(isShowing: Binding<Bool>, message: String = "Loading", content: @escaping () -> Content) {
        self._isShowing = isShowing
        self.message = message
        self.content = content
    }
    public var body: some View {
        ZStack(alignment: .center) {
            
            self.content()
                .disabled(self.isShowing)
                .blur(radius: self.isShowing ? 3 : 0)
            
            VStack {
                Text(message)
                    .font(.body)
                    .fontWeight(.medium)
                    .padding()
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            }
            .frame(width: 150,
                   height: 150)
            .background(Color.white)
            .foregroundColor(Color.primary)
            .cornerRadius(20)
            .opacity(self.isShowing ? 1 : 0)
            .shadow(color: .init(white: 0.95), radius: 10, x: 0, y: 0)
            
        }
//        .id(UUID())
    }

}


struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}


public struct LoadingView2: View {
    @State private var isLoading = false
    public init() {
        self._isLoading = State(initialValue: self.isLoading)
    }
    public var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.blue, lineWidth: 5)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
                }

            Text("Loading...")
        }
    }
}

