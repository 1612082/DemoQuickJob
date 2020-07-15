//
//  Data.swift
//  DemoQuickJob
//
//  Created by HongDang on 4/18/20.
//  Copyright © 2020 HongDang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//let arrBannerImg:[UIImage] = [#imageLiteral(resourceName: "images"),#imageLiteral(resourceName: "tuyen-dung-agn-1170x780"),#imageLiteral(resourceName: "tuyendung2")]
//struct Job {
//    let Name:String
//    let Addr:String
//    let Sallary:String
//    let Cate:Int //0-null 1-fulltime 2-parttime 3- product
//    let Avatar:UIImage
//}
//struct JobTime {
//    let j:Job
//    let timeWork:String
//    let placeWork:String
//    let detail:String
//    let benefit:String
//    let require:String
//    let owner:String
//}
//struct JobProduct {
//    let j:Job
//    let detail:String
//    let owner:String
//}
//let arrJob:[Job] = [
//    Job(Name: "Tuyển dụng nhân viên kho Logicstic", Addr: "Quận 7, Hồ Chí Minh", Sallary: "5,5-7 triệu / tháng", Cate: 1, Avatar: #imageLiteral(resourceName: "avatar")),
//    Job(Name: "Phỏng vấn khảo sát thị trường", Addr: "Bình Thạnh, Hồ Chí Minh", Sallary: "500-1 triệu / ngày", Cate: 0, Avatar: #imageLiteral(resourceName: "avatar")),
//    Job(Name: "Nhân viên PartTime nhà hàng", Addr: "Thủ Đức, Hồ Chí Minh", Sallary: "23.500đ / giờ", Cate: 2, Avatar: #imageLiteral(resourceName: "avatar")),
//    Job(Name: "CTV phân loại hàng", Addr: "Long Biên, Hà Nội", Sallary: "27.500đ / giờ", Cate: 0, Avatar: #imageLiteral(resourceName: "avatar")),
//    Job(Name: "Nhân viên bàn hàng", Addr: "Thanh Xuân, Hà Nội", Sallary: "18.000đ / giờ", Cate: 0, Avatar: #imageLiteral(resourceName: "avatar")),
//    Job(Name: "Cày rank LMHT", Addr: "", Sallary: "100.000đ", Cate: 3, Avatar: #imageLiteral(resourceName: "avatar")),
//    Job(Name: "Mâm cúng ngày giỗ", Addr: "Bình Tân, Hồ Chí Minh", Sallary: "500.000", Cate: 3, Avatar: #imageLiteral(resourceName: "avatar")),
//    Job(Name: "Viết lại CSS và Boostrap cho web", Addr: "", Sallary: "20.000", Cate: 3, Avatar: #imageLiteral(resourceName: "avatar")),
//    Job(Name: "Trả lời câu hỏi môn quản trị học", Addr: "", Sallary: "20.000", Cate: 3, Avatar: #imageLiteral(resourceName: "avatar")),
//    Job(Name: "Sửa chữa PC", Addr: "", Sallary: "30.000", Cate: 3, Avatar: #imageLiteral(resourceName: "avatar"))
//]
//let arrJobProduct:[JobProduct] = [
//    JobProduct(j: arrJob[5], detail: "Hiện tại mình đang bk2 73đ mình cần cày lên kc4", owner: "Dang Nguyen"),
//    JobProduct(j: arrJob[6], detail: "Cần một mâm cúng giỗ gia tiên ngày rằm", owner: "Liên Nguyễn"),
//    JobProduct(j: arrJob[7], detail: "Trang web bị lệch", owner: "Đoàn"),
//    JobProduct(j: arrJob[8], detail: "Câu 2: Bình luận ý kiến cho rằng “Chức năng tổ chức chỉ được thực hiện ở giai đoạn đầu khi tổ chức mới được thành lập”.", owner: "Anh"),
//    JobProduct(j: arrJob[9], detail: "Máy bị lag ạ :(( vào web hay ứng dụng gì cũng lag ( pc )", owner: "Trí")
//]
//let arrJobTime:[JobTime] = [
//    JobTime(j: arrJob[0], timeWork: "8:00 - 17:00", placeWork: "Quận 7, Hồ Chí Minh\n96 Đào Trí , Phường Phú Nhuận, Quận 7, Thành phố Hồ Chí Minh", detail: "-Nhận hàng từ nhà cung cấp, kiểm đếm số lượng sản phẩm\n-Lưu hàng vào kho nhập lên hệ thống\nPick hàng, đóng gói hàng hoá\n-Xứ lý trả hàng về kho", benefit: "-BHXH sau 1 tháng thử việc\nPhụ cấp ăn trưa 25 nghìn/ngày\n-Lương tháng 13", require: "-Nam, nữ tuổi từ 18 - 35\n-Ưu tiên biết sử dụng máy tính\n-Trình độ lớp 9 trở lên", owner: "Công ty cổ phần ETON"),
//    JobTime(j: arrJob[1], timeWork: "", placeWork: "", detail: "", benefit: "", require: "", owner: "Cimigo"),
//    JobTime(j: arrJob[2], timeWork: "", placeWork: "", detail: "", benefit: "", require: "", owner: "Golden Gate Group"),
//    JobTime(j: arrJob[3], timeWork: "18h - 24h", placeWork: "", detail: "", benefit: "", require: "", owner: "Ninja Van"),
//    JobTime(j: arrJob[4], timeWork: "", placeWork: "", detail: "", benefit: "", require: "", owner: "MIMI-Organic & Naturallife"),
//
//]

struct APPLY {
    var name:String
    var price:String
}
let listApply:[APPLY] = [
    APPLY(name: "Tú", price: "90 000"),
    APPLY(name: "Nam", price: "100 000"),
    APPLY(name: "Thư", price: "100 000"),
    APPLY(name: "Bảo", price: "100 000"),
    APPLY(name: "Bình", price: "100 000"),
]
let arrHeaderMange:[String] = ["Lịch làm việc","Đã đăng ký","Bài đăng"]
let date = Date()
let calendar = Calendar.current



struct PROFILECELL {
    let title:String
    let content:String
    let btnTitle:String
}
let arrProfileCell:[PROFILECELL] = [
    PROFILECELL(title: "Danh hiệu", content: "Bạn chưa có danh hiệu nào. Hoàn tất hồ sơ để nhận danh hiệu đầu tiên của bạn", btnTitle: "Hoàn tất hồ sơ"),
    PROFILECELL(title: "Kinh nghiệm trên app", content: "Bạn chưa làm công việc nào trên app", btnTitle: "Tìm việc ngay"),
//    PROFILECELL(title: "Kinh nghiệm khác", content: "Điền thông tin bạn đã làm việc trước đây để làm đệp hồ sơ và khả năng được duyệt khi nhận việc", btnTitle: "Thêm kinh nghiệm"),
    PROFILECELL(title: "Học vấn", content: "Bạn chưa có thông tin về học vấn của mình", btnTitle: "Thêm học vấn"),
//    PROFILECELL(title: "Kỹ năng", content: "Cập nhật kỹ năng của bạn đê gây ấn tượng", btnTitle: "Thêm kỹ năng"),

    
]
struct AWARD {
    let ID:String
    let avatar:UIImage
    let cate:String
}
let arrAward:[AWARD] = [
    AWARD(ID: "1", avatar: #imageLiteral(resourceName: "avatar"), cate: "Biên - Phiên dịch"),
    AWARD(ID: "2", avatar: #imageLiteral(resourceName: "avatar"), cate: "Cày rank"),
    AWARD(ID: "3", avatar: #imageLiteral(resourceName: "avatar"), cate: "học tập"),
]
let arrCatePushJob:[String] = ["Cộng tác viên","Free lance","Online","Offline","Full Time","Part Time","Tình nguyện","Làm việc tết"]
//let arrKindOfJob:[String] = ["Bán hàng","Dịch thuật","Giáo viên","Sự kiện","IT","Khác"]
//var arrListHighFilter:[String] = []
