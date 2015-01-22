//
//  DetalheEventoViewController.swift
//  PalestrasColetivas
//
//  Created by MARCUS PAULO MELO on 16/01/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

import UIKit
import MapKit
import Social

class DetalheEventoViewController: UIViewController {
    
    var evento = Evento();
    
    @IBOutlet weak var tituloDetalheEventoLabel: UINavigationItem!
    @IBOutlet weak var nomeLabel: UILabel!
    
    @IBOutlet weak var descricaoTextView: UITextView!
    @IBOutlet weak var dataInicioLabel: UILabel!
    
    @IBOutlet weak var enderecoLabel: UILabel!
    @IBOutlet weak var mapa: MKMapView!
    
    @IBOutlet weak var tipoMapaSegmentedControl: UISegmentedControl!
    
    @IBOutlet var toolbar: UIToolbar!
    
    @IBOutlet var textView: UITextView!
    
//    lazy var activityPopover:UIPopoverController = {
//        return UIPopoverController(contentViewController: self.activityViewController)
//        }()
    
    lazy var activityViewController:UIActivityViewController = {
        return self.createActivityController()
        }()

    
    override func viewDidLoad() {
        
        descricaoTextView.layer.cornerRadius = 5
        
        
//        tituloDetalheEventoLabel.title = evento.name
        descricaoTextView.text = evento.description
        dataInicioLabel.text = evento.fullDate
        enderecoLabel.text = evento.street
        
    }

    @IBAction func selecionarTipoMapa(sender: AnyObject) {
        println(tipoMapaSegmentedControl.selectedSegmentIndex)
        
        switch tipoMapaSegmentedControl.selectedSegmentIndex {
        case 1: mapa.mapType = MKMapType.Satellite;
        case 2: mapa.mapType = MKMapType.Hybrid;
            
        default: mapa.mapType = MKMapType.Standard;
            
        }
    }
    
    @IBAction func shareAction(sender: AnyObject) {
        share(sender)
    }
    
    func share(sender: AnyObject) {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.navigationController?.presentViewController(activityViewController, animated: true, completion: nil)
        }
//        else if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
//            // actually, you don't have to do this. But if you do want a popover, this is how to do it.
//            iPad(sender)
//        }
    }
    
//    func iPad(sender: AnyObject) {
//        if !self.activityPopover.popoverVisible {
//            if sender is UIBarButtonItem {
//                self.activityPopover.presentPopoverFromBarButtonItem(sender as UIBarButtonItem,
//                    permittedArrowDirections:.Any,
//                    animated:true)
//            } else {
//                var b = sender as UIButton
//                self.activityPopover.presentPopoverFromRect(b.frame,
//                    inView: self.view,
//                    permittedArrowDirections:.Any,
//                    animated:true)
//            }
//        } else {
//            self.activityPopover.dismissPopoverAnimated(true)
//        }
//    }
    
    func createActivityController() -> UIActivityViewController {
        
        
        let url:NSURL = NSURL(string:"http://palestrascoletivas.com")!
        
        
        // let's add a String and an NSURL
        var activityViewController = UIActivityViewController(
            activityItems: [evento.name + " #PalestrasColetivas", url],
            applicationActivities: nil)
        
        activityViewController.completionHandler = {(activityType, completed:Bool) in
            if !completed {
                println("cancelled")
                return
            }
            
            if activityType == UIActivityTypePostToTwitter {
                println("twitter")
            }
            
            if activityType == UIActivityTypePostToFacebook {
                println("Facebook")
            }
            
//            if activityType == UIActivityTypeMail {
//                println("mail")
//            }
        }
        
        // you can specify these if you'd like.
        activityViewController.excludedActivityTypes =  [
//                    UIActivityTypePostToTwitter,
//                    UIActivityTypePostToFacebook,
                    UIActivityTypePostToWeibo,
                    UIActivityTypeMessage,
                    UIActivityTypeMail,
                    UIActivityTypePrint,
                    UIActivityTypeCopyToPasteboard,
                    UIActivityTypeAssignToContact,
                    UIActivityTypeSaveToCameraRoll,
                    UIActivityTypeAddToReadingList,
                    UIActivityTypePostToFlickr,
                    UIActivityTypePostToVimeo,
                    UIActivityTypePostToTencentWeibo
        ]
        
        return activityViewController
    }


    
    @IBAction func twitterButtonPushed(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText(evento.name + " #PalestrasColetivas")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Atenção", message: "Para compartilhar, é necessário logar no Twitter", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func facebookButtonPushed(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText(evento.name + " #PalestrasColetivas")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Atenção", message: "Para compartilhar, é necessário logar no Facebook", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
