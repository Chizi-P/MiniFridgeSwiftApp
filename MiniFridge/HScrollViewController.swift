//
//  HScrollViewController.swift
//  weiboDemo2
//
//  Created by tt Wong on 27/10/2020.
//

import SwiftUI
//Content這種類型需遵循view這種協議
struct HScrollViewController<Content: View>: UIViewControllerRepresentable {
    
    //可描述的/可表達的把uikit的view controlloer封裝成view
    let pageWidth : CGFloat
    let contentSize: CGSize
    let content: Content
    
    @Binding var leftPercent: CGFloat
    
    init(pageWidth: CGFloat, contentSize: CGSize,leftPercent: Binding<CGFloat>, @ViewBuilder content:() -> Content) {
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPercent = leftPercent //初始化時前面要加下滑線
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    //makeUICiewController自動生成/
    func makeUIViewController(context: Context) ->  UIViewController {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false  //反彈
        scrollView.showsVerticalScrollIndicator = false //水平滾軸
        scrollView.showsHorizontalScrollIndicator = false
        //垂直滾軸
        scrollView.delegate = context.coordinator
        context.coordinator.scrollView = scrollView
        
        
        let vc = UIViewController()
        vc.view.addSubview(scrollView)
        
        //起到橋接的作用，把swiftUI的View封裝成了UIkit裡面的UIViewController
        let host = UIHostingController(rootView: content)
        vc.addChild(host) //父/子
        scrollView.addSubview(host.view)
        host.didMove(toParent: vc)//告訴host已經添加到vc
        context.coordinator.host = host
        
        return vc
        
    }
//更新//加感嘆號，不能為空
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let scrollView = context.coordinator.scrollView!
        scrollView.frame = CGRect(x: 0, y: 0,width: pageWidth, height: contentSize.height)
        scrollView.contentSize = contentSize
        scrollView.setContentOffset(CGPoint(x: leftPercent * (contentSize.width - pageWidth), y: 0),animated: true)
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
        
    }
    
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollView: UIScrollView!
        var host: UIHostingController<Content>!
        
        
        init(_ parent: HScrollViewController) {
            self.parent = parent
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation() {
                parent.leftPercent = scrollView.contentOffset.x < parent.pageWidth * 0.5 ? 0 : 1
            }
           
        }
    }
}



