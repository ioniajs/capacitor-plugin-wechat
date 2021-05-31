import Foundation
import Capacitor
import WechatOpenSDK

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(Wechat)
public class Wechat: CAPPlugin {

    @objc func isInstalled(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            call.success([
                "value": WXApi.isWXAppInstalled()
            ])
        }
    }

    @objc func shareText(_ call: CAPPluginCall) {
        DispatchQueue.main.async {

            let req = SendMessageToWXReq()
            
            req.text = call.getString("text")!
            req.bText = true
            req.scene = Int32(call.getInt("scene")!)
 
        
            WXApi.send(req) { (res) in
                call.success([
                    "value": res
                ])
            }
           
        }
    }
    
    @objc func shareLink(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            
            let ext = WXWebpageObject()
            ext.webpageUrl = call.getString("url")!
            

            let message = WXMediaMessage()
            message.title = call.getString("title")!
            message.description = call.getString("description")!
            
            let thumb = call.getString("thumb") ?? ""
   
            let url = URL(string: thumb)
            if let data = try? Data(contentsOf: url!) {
                message.setThumbImage(UIImage(data: data)!)
            }
            
            message.mediaObject = ext

            let req = SendMessageToWXReq()
            req.bText = false
            req.scene = Int32(call.getInt("scene")!)
            req.message = message


            WXApi.send(req) { (res) in
                call.success([
                    "value": res
                ])
            }

        }
    }
    
    @objc func shareImage(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            
            let ext = WXImageObject()
            
            let image = call.getString("url")!
            if let imageData = try? Data(contentsOf: URL(string: image)!) {
                ext.imageData = UIImage(data: imageData)!.pngData()!
            }
        
            // if let imageData = Data(base64Encoded: image) {
            //     ext.imageData = UIImage(data: imageData)!.pngData()!
            // }

            let message = WXMediaMessage()
            message.title = call.getString("title")!
            message.description = call.getString("description")!
            
            let thumb = call.getString("thumb")!
            if let data = try? Data(contentsOf: URL(string: thumb)!) {
                message.setThumbImage(UIImage(data: data)!)
            }
           
            message.mediaObject = ext

            let req = SendMessageToWXReq()
            req.bText = false
            req.scene = Int32(call.getInt("scene")!)
            req.message = message


            WXApi.send(req) { (res) in
                call.success([
                    "value": res
                ])
            }

        }
    }

    @objc func shareMiniProgram(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            let obj = WXMiniProgramObject()
            obj.webpageUrl = call.getString("webpageUrl")!
            obj.userName = call.getString("userName")!
            obj.path = call.getString("path")!

            let hdImageData = call.getString("hdImageData")!
            let url = URL(string: hdImageData)
            
            if let data = try? Data(contentsOf: url!) {
                obj.hdImageData = data;
            }
            
            obj.withShareTicket = call.getBool("withShareTicket")!
            obj.miniProgramType = WXMiniProgramType(rawValue: UInt(call.getInt("miniProgramType")!)) ?? WXMiniProgramType.release
            

            let message = WXMediaMessage()
            message.title = call.getString("title")!
            message.description = call.getString("description")!
            message.thumbData = nil
            message.mediaObject = obj
            
            let req = SendMessageToWXReq()
            req.bText = false
            req.scene = Int32(call.getInt("scene")!)
            req.message = message
            
            WXApi.send(req) { (res) in
                call.success([
                    "value": res
                ])
            }
        }
    }

    @objc func openMiniProgram(_ call: CAPPluginCall) {
        DispatchQueue.main.async {

            let req = WXLaunchMiniProgramReq()
            req.userName = call.getString("userName")!
            req.path = call.getString("path")!
            req.miniProgramType = WXMiniProgramType(rawValue: UInt(call.getInt("miniProgramType")!)) ?? WXMiniProgramType.release

            WXApi.send(req) { (res) in
                call.success([
                    "value": res
                ])
            }

        }
    }
}
