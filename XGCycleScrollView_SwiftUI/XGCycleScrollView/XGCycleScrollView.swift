//
//  XGCycleScrollView.swift
//  XGCycleScrollView
//
//  Created by CuiXg on 2021/8/4.
//

import SwiftUI

struct XGCycleScrollView: View {

    // 图片地址
    var imagesUrl: [String] = []

    // 滑动速度
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    // 当前位置索引
    @State private var currentIndex: Int = 1

    // 图片间距
    var spacing: CGFloat = 10

    // 拖拽偏移量
    @State private var dragOffsetX: CGFloat = .zero

    var cornerRadius: CGFloat = 10

    var imageTapGesture: ((Int) -> Void)?

    // 是否需要动画
    @State private var isAnimation: Bool = true

    var isAuto: Bool = true

    var body: some View {

        GeometryReader(content: { geometry in
            let currentOffsetX = CGFloat(currentIndex) * (geometry.size.width + spacing)

            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
                HStack(alignment: .center, spacing: spacing, content: {
                    ForEach(0 ..< getImageCount()) {
                        XGCycleScrollImage(imageUrl: getImageUrl(at: $0))
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .cornerRadius(cornerRadius)
                            .onTapGesture {
                                imageTapGesture?(currentIndex - 1)
                            }
                    }
                })
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: dragOffsetX - currentOffsetX)
                .gesture(dragGesture)
                .animation(isAnimation ? .spring() : .none)
                .onChange(of: currentIndex, perform: { value in
                    isAnimation = false
                    if value == 0 {
                        currentIndex = getImageCount() - 2
                    }else if value == getImageCount() - 1 {
                        currentIndex = 1
                    }

                })
                .onReceive(timer, perform: { _ in
                    if isAuto {
                        isAnimation = true
                        currentIndex += 1
                    }
                })

                HStack(alignment: .bottom, spacing: 5, content: {
                    ForEach(1 ..< getImageCount() - 1) {
                        Circle()
                            .foregroundColor($0 == currentIndex ? .red: .gray)
                            .frame(width: 5, height: 5, alignment: .center)
                    }
                })
                .frame(width: CGFloat((getImageCount() - 2) * 10) + 15, height: 15, alignment: .center)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(7.5)
                .offset(y: -15)
            })
        })
        .padding()
    }

    private func getImageCount() -> Int {
        if imagesUrl.count == 0 {
            return 0
        }else {
            return (imagesUrl.count + 2)
        }
    }

    private func getImageUrl(at index: Int) -> String {

        if index == 0 {
            return imagesUrl.last ?? ""
        }else if index == imagesUrl.count + 1 {
            return imagesUrl.first ?? ""
        }else {
            return imagesUrl[index - 1]
        }
    }
}

extension XGCycleScrollView {

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                isAnimation = true
                dragOffsetX = value.translation.width
            }
            .onEnded { value in
                dragOffsetX = .zero
                /// 拖动右滑，偏移量增加，显示 index 减少
                if value.translation.width > 50 {
                    currentIndex -= 1
                    /// 拖动左滑，偏移量减少，显示 index 增加
                }else if value.translation.width < -50 {
                    currentIndex += 1
                }
                currentIndex = max(min(currentIndex, getImageCount() - 1), 0)
            }
    }
}

struct XGCycleScrollView_Previews: PreviewProvider {
    static var previews: some View {
        XGCycleScrollView(imagesUrl: ["https://img0.baidu.com/it/u=251614576,2693916083&fm=26&fmt=auto&gp=0.jpg",
                                      "https://img2.baidu.com/it/u=1728522718,1340994382&fm=26&fmt=auto&gp=0.jpg",
                                      "https://img0.baidu.com/it/u=103721101,4076571305&fm=26&fmt=auto&gp=0.jpg",
                                      "https://img0.baidu.com/it/u=1824151452,3654743938&fm=26&fmt=auto&gp=0.jpg",
                                      "https://img0.baidu.com/it/u=251614576,2693916083&fm=26&fmt=auto&gp=0.jpg",
                                                                    "https://img2.baidu.com/it/u=1728522718,1340994382&fm=26&fmt=auto&gp=0.jpg",
                                                                    "https://img0.baidu.com/it/u=103721101,4076571305&fm=26&fmt=auto&gp=0.jpg",
                                                                    "https://img0.baidu.com/it/u=1824151452,3654743938&fm=26&fmt=auto&gp=0.jpg"],
                        cornerRadius: 10, isAuto: true)
    }
}
