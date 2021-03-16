//
//  LoginDemoViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/11.
//

import UIKit
import RxSwift
import RxCocoa

class LoginDemoViewController: BaseViewController {
    
    @IBOutlet weak var userName_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var drpassword_field: UITextField!
    @IBOutlet weak var userName_label: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var drpassworlabel: UILabel!
    @IBOutlet weak var submit_btn: UIButton!
    
    var viewModel : LoginDemoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    fileprivate func bindViewModel() {
        //输入流绑定信号
        viewModel = LoginDemoViewModel(input: LoginDemoViewModel.Input(
            userName: userName_field.rx
                .value
                .orEmpty
                .asObservable()
                .distinctUntilChanged()
                .debounce(DispatchTimeInterval.seconds(Int(0.5)), scheduler: MainScheduler.instance),
            psd: password_field.rx.value
                .orEmpty
                .asObservable()
                .distinctUntilChanged()
                .debounce(DispatchTimeInterval.seconds(Int(0.5)), scheduler: MainScheduler.instance),
            cofirmPsd: drpassword_field
                .rx
                .value
                .orEmpty
                .asObservable()
                .distinctUntilChanged()
                .debounce(DispatchTimeInterval.seconds(Int(0.5)), scheduler: MainScheduler.instance),
            signUpBtnTaps: submit_btn.rx.tap.asObservable()
        ))
        
        //输出流
        viewModel.output.userNameValidateResult.subscribe { [weak self] (event:Event<ValidateResult>) in
            switch event {
            case .completed: break //信号完成
            case .error(_):
                self?.userName_label.text = ""
                self?.userName_label.textColor = .red
            case .next(let result): //接受信号
                switch result {
                case .ok:
                    self?.userName_label.text = ""
                    self?.userName_label.textColor = .red
                case .validating: //验证中...
                    self?.userName_label.text = ""
                    self?.userName_label.textColor = .brown
                case .failed(let resaon):// 验证出错
                    switch resaon {
                    case .emptyInput:
                        self?.userName_label.text = ""
                    case .other(let msg):
                        self?.userName_label.text = msg
                        self?.userName_label.textColor = .red
                    }
                }
            }
        }.disposed(by: disposeBag)
        
        //输出流观察 password
        viewModel.output.psdValidateResult.subscribe { [weak self] (event: Event<ValidateResult>) in
            //信号发送过来,查看状态
            switch event{
            case .completed: return  //信号完成
            case .error(_):   //出错
                self?.passwordLabel.text = "验证服务错误"
                self?.passwordLabel.textColor = .red
            case .next(let result): //接受到信号
                switch result {
                case .ok: //验证通过
                    self?.passwordLabel.text = ""
                    self?.passwordLabel.textColor = .red
                case .validating: //验证中...
                    self?.passwordLabel.text = "验证中"
                    self?.passwordLabel.textColor = .brown
                case .failed(let resaon): //验证出错 和 空
                    switch resaon {
                    case .emptyInput:
                        self?.passwordLabel.text = ""
                    case .other(let msg):
                        self?.passwordLabel.text = msg
                        self?.passwordLabel.textColor = .red
                    }
                }
            }
        }.disposed(by: rx.disposeBag)
        
        //输出流观察 confirmpassword
        viewModel.output.confirmPsdValidateResult.subscribe { [weak self] (event: Event<ValidateResult>) in
            //信号发送过来,查看状态
            switch event{
            case .completed: return  //信号完成
            case .error(_):   //出错
                self?.drpassworlabel.text = "验证服务错误"
                self?.drpassworlabel.textColor = .red
            case .next(let result): //接受到信号
                switch result {
                case .ok: //验证通过
                    self?.drpassworlabel.text = ""
                    self?.drpassworlabel.textColor = .red
                case .validating: //验证中...
                    self?.drpassworlabel.text = "验证中"
                    self?.drpassworlabel.textColor = .brown
                case .failed(let resaon): //验证出错 和 空
                    switch resaon {
                    case .emptyInput:
                        self?.drpassworlabel.text = ""
                    case .other(let msg):
                        self?.drpassworlabel.text = msg
                        self?.drpassworlabel.textColor = .red
                    }
                }
            }
        }.disposed(by: rx.disposeBag)
        
        //注册按钮的 enable状态输出流
        viewModel.output.signUpEnable.subscribe(onNext: { [weak self] (isEnable) in
            self?.submit_btn.isEnabled = isEnable
            self?.submit_btn.alpha = isEnable ? 1 : 0.5
        }).disposed(by: rx.disposeBag)
        
        //点击注册按钮
        viewModel.output.signInResult.subscribe(onNext: { [weak self] (isSignInSuccess) in
            if (isSignInSuccess) {
                print("登录成功")
                self?.navigationController?.popViewController()
            }
        }, onError: { (errorMsd) in
            print("登录失败")
        }).disposed(by: disposeBag)
    }
    
}
