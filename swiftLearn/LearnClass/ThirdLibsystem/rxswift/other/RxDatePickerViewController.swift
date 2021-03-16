//
//  RxDatePickerViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa

class RxDatePickerViewController: BaseViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    
    //剩余时间
    let leftTime = BehaviorRelay(value: TimeInterval(180))
    //当前倒计时是否结束
    let countDownStopped = BehaviorRelay(value:true)
    
    lazy var dateFormater : DateFormatter  = {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy年MM月dd日 HH:mm"
        return formater
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //选中的时间和label绑定在一起
        datePicker.rx.date.map { [weak self] in
            "选中的时间:" + self!.dateFormater.string(from: $0)
        }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        //倒计时
        //双向绑定
        //        DispatchQueue.main.async {
        //            _ = self.timerPicker.rx.countDownDuration <-> self.leftTime
        //        }
        
        self.timerPicker.rx.countDownDuration.asObservable().bind(to: self.leftTime).disposed(by: disposeBag)
        
        Observable.combineLatest(leftTime.asObservable(), countDownStopped.asObservable()){
            leftTimeValeu,countDownStoppedValue in
            if countDownStoppedValue {
                return "开始"
            }else{
                return "倒计时开始,还有\(Int(leftTimeValeu)) 秒 ..."
            }
        }
        .bind(to: startButton.rx.title())
        .disposed(by: disposeBag)
        
        //倒计时开始不能点击按钮和时间选项
        countDownStopped.asDriver().drive(timerPicker.rx.isEnabled).disposed(by: disposeBag)
        countDownStopped.asDriver().drive(startButton.rx.isEnabled).disposed(by: disposeBag)
        
        startButton.rx.tap.subscribe(onDisposed:  { [weak self] in
            print("我们iOS")
            self?.startClicked()
        }).disposed(by: disposeBag)
        
    }
    
    
    func startClicked() {
        self.countDownStopped.accept(false)
        //创建定时器
        Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .takeUntil(countDownStopped.asObservable().filter({ $0}))
            .subscribe { (event) in
                self.leftTime.accept(self.leftTime.value - 1)
                if self.leftTime.value == 0 {
                    self.countDownStopped.accept(true)
                    self.leftTime.accept(180)
                }
            }.disposed(by: disposeBag)
    }
    
}
