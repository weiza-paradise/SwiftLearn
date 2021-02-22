//
//  AlamofireLearnViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/2/20.
//

import UIKit
import Alamofire

struct Login: Encodable {
    let username: String
    let password: String
}

//Alamofire 5.4.0
class AlamofireLearnViewController: BaseViewController {

    lazy var contentLable: UILabel = {
        let label = UILabel()
        label.text = "内容"
        label.backgroundColor = .red
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = .orange
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //getRequest()
        //postRequest()
        //downLoad()
        //downLoadDestination()
        //downloadProgress()
        //downloadResume()
        uploadData()
    }
    
    override func configUI() {
        view.addSubview(contentLable)
        print(navBarHeight)
        contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(navBarHeight)
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(contentLable.snp_bottomMargin).offset(10)
            make.size.equalTo(CGSize(width: screenWidth, height: screenWidth*0.5))
        }
    }
    
}


extension AlamofireLearnViewController {
    
    
    /// get  请求
    func getRequest() {
        AF.request("https://www.wanandroid.com/banner/json").responseJSON { (response) in
            //debugPrint(response)
            print(response)
        }
    }
    
    /// post 请求
    func postRequest() {
        //let login = ["username":"weiza","password":"111111"]
        let login = Login(username: "weiza", password: "111111")
        AF.request("https://www.wanandroid.com/user/login", method: .post, parameters: login).responseJSON { (response) in
            //debugPrint(response)
            print(response)
        }
    }

    
    /// 普通下载
    func downLoad() {
        AF.download("https://goss.cfp.cn/creative/vcg/800/new/VCG211302411264.jpg").responseData { (response) in
            debugPrint(response)
            if let data = response.value {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
    }
    
    /// 下载到指定目录
    func downLoadDestination() {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        AF.download("https://goss.cfp.cn/creative/vcg/800/new/VCG211283710619.jpg", to: destination).response { response in
            debugPrint(response)
            if response.error == nil, let imagePath = response.fileURL?.path {
                let image = UIImage(contentsOfFile: imagePath)
                self.imageView.image = image
            }
            
            /**
             success(Optional(file:///Users/wei/Library/Developer/CoreSimulator/Devices/321E4952-ADF5-46E3-B83C-99F299792CAF/data/Containers/Data/Application/65B2F234-2F71-46D7-87C0-D619A89637C3/Documents/VCG211283710619.jpg))
             */
        }
    }
    
    /// 下载进度
    func downloadProgress()  {
        AF.download("https://goss2.cfp.cn/creative/vcg/800/new/VCG211189348444.jpg")
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                //debugPrint(response)
                if let data = response.value {
                    let image = UIImage(data: data)
                    self.imageView.image = image
                }
            }
    }
    
    /// 恢复下载
    func downloadResume()  {
        
        var resumeData: Data!

        let download = AF.download("https://goss2.cfp.cn/creative/vcg/800/new/VCG211275370528.jpg").responseData { response in
            if let data = response.value {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }

        // download.cancel(producingResumeData: true)
        // Makes resumeData available in response only.
        // 取消下载,会把已经下载的数据,暂存到 resumeData
        download.cancel { data in
            resumeData = data
        }

        //继续去下载,使用暂存的数据 resumeData 继续 (这里直接使用会崩溃,需要模拟)
        AF.download(resumingWith: resumeData).responseData { response in
            if let data = response.value {
                let image = UIImage(data: data)
                self.imageView.image = image
                resumeData = nil
            }
        }
    }
    
    
    /// 上传data
    func uploadData() {
        let data = Data("datadata".utf8)
        AF.upload(data, to: "https://httpbin.org/post").responseString { (response) in
            print(response)
        }
    }
    
    /// 文件上传
    func uploadFile() {
        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mov")!
        AF.upload(fileURL, to: "https://httpbin.org/post").responseJSON { (response) in
            print(response)
        }
    }
    
    /// 上传 MultipartData
    func uploadMultipartData() {
        AF.upload(multipartFormData: { multipartFormData in
            //多了用for
            multipartFormData.append(Data("one".utf8), withName: "one")
            multipartFormData.append(Data("two".utf8), withName: "two")
        }, to: "https://httpbin.org/post")
            .responseJSON { (response) in
                print(response)
            }
    }
    
    //上传进度
    func uploadProgress() {
        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mov")!
        AF.upload(fileURL, to: "https://httpbin.org/post")
            .uploadProgress { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }
            .responseJSON { (response) in
                print(response)
            }
    }
    
    
}
