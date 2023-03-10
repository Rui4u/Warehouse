//
//  ChangeIpView.swift
//  ErrorAnalysis
//
//  Created by sharui on 2022/10/12.
//

import Foundation
import SwiftUI


struct ChangeServerView: View {
    //用于退出该界面
    @Environment(\.presentationMode) var presentationMode
    @State var hoverClose: Bool = false
    @EnvironmentObject var serverData: ServerData
    
    var body: some View {
        ZStack {
            Text("添加服务地址").font(.title)
            VStack(alignment: .center) {
                List {
                    ForEach(serverData.servers) { source in
                        IPServerItem(serverModel: source)
                    }
                }.padding()
                HStack (alignment: .center) {
                    Button {
                        serverData.saveToDB()
                        serverData.addEmptyItem()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("添加")
                        }
                    }
                    Spacer()
                    Button {
                        serverData.saveToDB()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                            Text("确定")
                        }
                    }
                    .tint(.green)
                    .controlSize(.large) // .regular 是默认大小
                    .buttonStyle(.borderedProminent) // borderedProminent 可显示 tint 的设置。还有 bordered、plain 和 borderless 可选。
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .accentColor(.green)
                    .buttonBorderShape(.automatic) // 会依据 controlSize 调整边框样式
                    .background(.ultraThinMaterial, in: Capsule())
                    
                }
               
            }
            .padding()
            VStack{
                HStack {
                    Button{
                        serverData.saveToDB()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: hoverClose ? "xmark.circle.fill" :"circle.fill")
                                .onHover { hover in
                                    hoverClose = hover
                                    print(hover)
                                }
                        }.foregroundColor(.red)
                    }
                        .padding()
                    Spacer()
                }
                Spacer()
            }
        }
        .buttonStyle(.plain)
        .background(.white)
    }
}

struct ChangeServerView_Previews: PreviewProvider {
    static var previews: some View {
        let serverData = ServerData.shared
        ChangeServerView()
            .environmentObject(serverData)
            .frame(width: 500,height: 400)
    }
}



struct IPServerItem: View {
    @EnvironmentObject var serverData: ServerData
    @FocusState private var focused: Bool
    var serverModel: ChangeServerModel
    
    var serverIndex: Int? {
        serverData.servers.firstIndex(where: { $0.id == serverModel.id })
    }
    
    var body: some View {
        HStack {
            
            if let serverIndex = serverIndex  {
                Button {
                    let selected = serverData.servers[serverIndex].selected
                    for i in 0..<serverData.servers.count {
                        serverData.servers[i].selected = false
                    }
                    serverData.servers[serverIndex].selected = !selected
                    
                } label: {
                    Image(systemName: serverData.servers[serverIndex].selected ? "checkmark.square.fill" : "square")
                        .foregroundColor(serverData.servers[serverIndex].selected ? .green : .black)
                        .font(.title)
                }
                TextField("输入", text: $serverData.servers[serverIndex].ip)
                
                    .focused($focused)
                    .textFieldStyle(.plain)
                    .submitLabel(.done)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                
                    .onChange(of: focused) { newValue in
                        print(newValue)
                    }.disabled(!serverModel.enableChange)
                
            }
            if serverModel.enableChange {
                Button {
                    serverData.delete(item: serverModel)
                } label: {
                    Image(systemName:"xmark.circle")
                }
            } else {
                Button { } label: {
                    Image(systemName:"xmark.circle")
                }.hidden()
            }
         
        }.buttonStyle(.plain)
        
        
        
        
        //            Button {
        //                serverData.saveToDB()
        //
        //            } label: {
        //                Text("确定")
        //            }
    }
        
}
