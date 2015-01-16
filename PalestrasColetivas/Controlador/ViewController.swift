//
//  ViewController.swift
//  PalestrasColetivas
//
//  Created by MARCUS PAULO MELO on 06/01/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var eventos = [Evento]()
    
    var evento = Evento()

    override func viewDidLoad() {
        super.viewDidLoad()
//        limparAtributos();
        
        //Carregar Eventos do Palestras Coletivas
        carregarEventos();
        
        println(eventos.count)
        
        carregarEventos();
        
        
        testarListaEventos();

    }
    
    //Função Responsável por Carregar os Eventos e converter para o Objeto Evento.
    func carregarEventos() {
        
        var listaEventos = [Evento]()
        
        Alamofire.request(.GET, "http://palestrascoletivas.com/events.json")
            .responseJSON { (_, _, JSON, _) in
                println("Carregar JSON Início");
                println(JSON)
                println("Carregar JSON FIM");
                
                if let jsonResult = JSON as? Array<Dictionary<String,String>> {
                    
                    for var index = 1; index < jsonResult.count; ++index {
                        
                        self.evento = Evento()
                        
                        self.evento.name = jsonResult[index]["name"]!;
                        self.evento.edition = jsonResult[index]["edition"]!;
                        self.evento.description = jsonResult[index]["description"]!;
   //                     self.evento.date = jsonResult[index]["date"]!;
//                        self.evento.days = jsonResult[index]["days"];
//                        self.evento.street = jsonResult[index]["street"]!;
//                        self.evento.district = jsonResult[index]["district"]!;
//                        self.evento.state = jsonResult[index]["state"]!;
//                        self.evento.country = jsonResult[index]["country"]!;
                        
                        self.eventos.append(self.evento)
                    }
                    
                    println(self.eventos.count)
                    
                }
                
                self.testarListaEventos();
        }
    }
    
    func testarListaEventos() {
        for evento in eventos {
            println("----- Início Evento ------")
            println("Nome: " + evento.name)
            println("Edição: " + evento.edition)
            
            println("----- FIM Evento ------")
        }
    }
    
    func limparAtributos(){
        eventos = [Evento]()
        self.evento = Evento()
    }

}

