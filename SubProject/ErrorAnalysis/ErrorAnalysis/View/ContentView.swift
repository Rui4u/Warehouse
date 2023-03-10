//
//  ContentView.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/2/6.
//

import SwiftUI
import CoreData


struct RootContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    var viewModel = ParsingViewModel.shared
    /// 正在刷新
    @State var parsing: Bool = false
    @State var serverCheakKey: Bool = false
    
    @State var listItemWidth: CGFloat = 300
    @State var changeIpAlert: Bool = false
    @EnvironmentObject var serverData: ServerData
    @State var serverCheakString = ""
    
    var body: some View {
        NavigationView {
            SRSidebar()
                .environment(\.managedObjectContext, viewContext)
                .frame(minWidth: 350)
            Text("😁祝你成功😁").font(.largeTitle)
        }
        .hud(isShow: $serverCheakKey) {
            VStack {
                if (serverCheakString == "验证成功") {
                    Image(systemName: "checkmark.seal").foregroundColor(.green).font(.system(size: 50))
                    Text(serverCheakString)
                        .font(.title)
                        .frame(minWidth: 100, minHeight: 30, alignment: SwiftUI.Alignment.center)
                        .foregroundColor(.black)
                } else {
                    HStack {
                        Image(systemName: "exclamationmark.icloud.fill").font(.system(size: 25))
                        Text(serverCheakString)
                            .font(.title)
                            .frame(minWidth: 100, minHeight: 30, alignment: SwiftUI.Alignment.center)
                    }
                    .foregroundColor(.red)
                }
                
                
                
            }
            
            .onAppear() {
                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                    serverCheakKey = false
                }
            }
        }
        .hud(isShow: $parsing) {
            ZStack {
                Text("loading...")
                    .font(SwiftUI.Font.system(size: 18))
                    .frame(width: 80, height: 80, alignment: SwiftUI.Alignment.center)
            }
        }
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                Button {
                    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                } label: {
                    Label("Sidebar", systemImage: "sidebar.left")
                }
            }
            
            ToolbarItem {
                Button(action: {
                    cheakRequest()
                }) {
                    Text("验证服务")
                }
            }
            ToolbarItem {
                Button(action: {
                    changeIpAlert.toggle()
                }) {
                    Text("自定义IP")
                }
            }
        }
        .frame(minWidth: 800)
        .onReceive(ParsingViewModel.shared.$resultModel) { result in
            guard let result = result else {
                return
            }
            viewModel.addItemAllOperation(addItem: result)
        }.onReceive(ParsingViewModel.shared.$parsing) { parsing in
            self.parsing = parsing
        }.onAppear() {
            viewModel.listData = viewModel.listData(reload: true)
            serverData.updateFromDB()
        }.sheet(isPresented: $changeIpAlert) {
            //非全屏模式
            ChangeServerView()
                .frame(width: 500,height: 400)
        }.onAppear() {
            cheakRequest()
        }
    }
    
    func cheakRequest() {
        RequestManager().test_request { serverClose in
            serverCheakString = serverClose ? "打包机服务已关闭 或 自定义服务器错误" : "验证成功"
            serverCheakKey = true
        }
    }
    
}





// MARK: - 扩展 View 使其能够有 HUD 的能力
extension View {
    func hud<V: View>( isShow: Binding<Bool>, @ViewBuilder v: () -> V) -> some View {
        ZStack(alignment: .center) {
            self
            if isShow.wrappedValue == true {
                PHUD(v: v)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
                    .padding()
            }
        }
    }
}

// MARK: - 自定义 HUD
struct PHUD<V: View>: View {
    @ViewBuilder let v: V
    
    var body: some View {
        v
            .padding()
            .foregroundColor(.black)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 5)
            )
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
