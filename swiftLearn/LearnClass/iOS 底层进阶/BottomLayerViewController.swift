//
//  BottomLayerViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/2/8.
//

import UIKit


struct BottomViewModel {
    
    let list : [ClassInfo] = [
        ClassInfo(name: "alloc 源码流程分析", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/fxdn99"),
        ClassInfo(name: "内存对齐", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/xwlooa"),
        ClassInfo(name: "isa 指针", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/rlli8q"),
        ClassInfo(name: "类", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/pp6dww"),
        ClassInfo(name: "cache_t", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/shwffh"),
        ClassInfo(name: "方法的本质 objc_msgSend", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/vnqpup"),
        ClassInfo(name: "消息转发", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/ddotin"),
        ClassInfo(name: "启动加载dyld分析", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/ixkf6s"),
        ClassInfo(name: "类的加载", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/rirvkg"),
        ClassInfo(name: "懒加载类和分类的加载", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/ytricx"),
        ClassInfo(name: "类扩展+关联对象+loadImages", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/oxab8b"),
        ClassInfo(name: "KVO", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/rne54q"),
        ClassInfo(name: "GCD 使用篇", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/ogk37c"),
        ClassInfo(name: "线程锁 一", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/qsu19z"),
        ClassInfo(name: "线程锁 二", class: WebViewController.self, link:
            "https://www.yuque.com/taidu-9hlv6/gs4bgx/mf8iki"),
        ClassInfo(name: "Block", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/ggnmgx"),
        ClassInfo(name: "内存管理", class: WebViewController.self, link: "https://www.yuque.com/taidu-9hlv6/gs4bgx/wi0urh"),
    ]
    
}


class BottomLayerViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listData = BottomViewModel().list
    }

}
