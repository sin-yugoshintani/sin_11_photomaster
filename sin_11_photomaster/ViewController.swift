//
//  ViewController.swift
//  sin_11_photomaster
//
//  Created by 菊地英治 on 2022/05/11.
//
import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker,animated: true,completion: nil)
        }
    }
    
    
    
    
    
    func imagePickerController(_picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true,completion: nil)
        photoImageView.image = info[.originalImage] as?UIImage
    }
    
    
    @IBAction func onTappedCameraButton(){
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sourceType: .photoLibrary)
        
    }
    
    
    
    func drawText(image:UIImage)-> UIImage {
        let text = "Lifeistech!"
        let textFontArributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial", size: 120),
            NSAttributedString.Key.foregroundColor:UIColor.red
        ]
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let margin: CGFloat = 5.0
        let textRect = CGRect(x: margin, y: margin, width: image.size.width, height: image.size.height)
        text.draw(in: textRect, withAttributes: textFontArributes as [NSAttributedString.Key : Any])
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    func drawMaskImage(image: UIImage) -> UIImage{
        let maskImage = UIImage(named: "furo_ducky")!
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let margin: CGFloat = 50.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin, y: image.size.height - maskImage.size.height - margin, width: maskImage.size.width, height: image.size.height)
        maskImage.draw(in: maskRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    @IBAction func onTappedTextButton(){
        if photoImageView.image != nil {
            photoImageView.image = drawText(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
    }
    @IBAction func onTappedIllustButton(){
        if photoImageView.image != nil {
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else {
            print("画像がありません")
        }
    }
    
    @IBAction func onTappeduploadButton(){
        if photoImageView.image != nil{
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!,"#PhotoMaster"],applicationActivities:  nil)
            self.present(activityVC,animated: true,completion: nil)
        } else {
            print("画像がありません")
        }
    }
    
}

