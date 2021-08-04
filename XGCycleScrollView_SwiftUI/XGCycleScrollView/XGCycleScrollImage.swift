//
//  XGCycleScrollImage.swift
//  XGCycleScrollView
//
//  Created by CuiXg on 2021/8/4.
//

import SwiftUI

struct XGCycleScrollImage: View {

    var imageUrl: String

    @State private var remoteImage: UIImage? = nil

    private let placeholderImage = UIImage(named: "placeholder_image")

    var body: some View {

        GeometryReader(content: { geometry in
            Image(uiImage: remoteImage ?? placeholderImage!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }).onAppear(perform: {
            guard let url = URL(string: imageUrl) else { return }
            URLSession.shared.dataTask(with: url) { data, _, _  in
                if let _data = data {
                    self.remoteImage = UIImage(data: _data)
                }
            }.resume()
        })
    }
}

struct XGCycleScrollImage_Previews: PreviewProvider {
    static var previews: some View {
        XGCycleScrollImage(imageUrl: "https://img0.baidu.com/it/u=251614576,2693916083&fm=26&fmt=auto&gp=0.jpg")
    }
}
