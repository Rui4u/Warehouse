//
//  Coordinator.swift
//  CoverApps
//
//  Created by sharui on 2023/1/18.
//
import SwiftUI

@available(iOS 16.0, *)
public class Coordinator: ObservableObject {
    @Published public var path = NavigationPath()
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public init(path: NavigationPath = NavigationPath()) {
        self.path = path
    }
}
