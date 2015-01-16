//
//  DetalheEventoViewController.swift
//  PalestrasColetivas
//
//  Created by MARCUS PAULO MELO on 16/01/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

import UIKit
import MapKit

class DetalheEventoViewController: UIViewController {
    
    var evento = Evento();
    
    @IBOutlet weak var tituloDetalheEventoLabel: UINavigationItem!
    @IBOutlet weak var nomeLabel: UILabel!
    
    @IBOutlet weak var descricaoTextView: UITextView!
    @IBOutlet weak var dataInicioLabel: UILabel!
    
    @IBOutlet weak var enderecoLabel: UILabel!
    @IBOutlet weak var mapa: MKMapView!
    
    @IBOutlet weak var tipoMapaSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        println(evento.name);
        
        tituloDetalheEventoLabel.title = evento.name;
        descricaoTextView.text = evento.description;
        dataInicioLabel.text = evento.day;
        enderecoLabel.text = evento.street;
        
    }

    @IBAction func selecionarTipoMapa(sender: AnyObject) {
        println(tipoMapaSegmentedControl.selectedSegmentIndex)
        
        switch tipoMapaSegmentedControl.selectedSegmentIndex {
        case 1: mapa.mapType = MKMapType.Satellite;
        case 2: mapa.mapType = MKMapType.Hybrid;
            
        default: mapa.mapType = MKMapType.Standard;
            
        }
    }
}
