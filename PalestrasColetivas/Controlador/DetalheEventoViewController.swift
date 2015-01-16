//
//  DetalheEventoViewController.swift
//  PalestrasColetivas
//
//  Created by MARCUS PAULO MELO on 16/01/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

import UIKit

class DetalheEventoViewController: UIViewController {
    
    var evento = Evento();
    
    @IBOutlet weak var tituloDetalheEventoLabel: UINavigationItem!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    
    @IBOutlet weak var dataInicioLabel: UILabel!
    override func viewDidLoad() {
        println(evento.name);
        
        tituloDetalheEventoLabel.title = evento.name;
        nomeLabel.text = evento.name;
        descricaoLabel.text = evento.description;
        dataInicioLabel.text = evento.day;
        
    }

}
