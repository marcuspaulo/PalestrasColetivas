//
//  EventoViewController.swift
//  PalestrasColetivas
//
//  Created by MARCUS PAULO MELO on 06/01/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

import UIKit
import Alamofire

class EventoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var eventos = [Evento]()
    
    var evento = Evento()
    var dataUtil = DataUtil();
    
    
    var refreshControl:UIRefreshControl!  // An optional variable
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        limparAtributos();
        
        carregarEventos();
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Atualizando...")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject)
    {
        carregarEventos();
        self.refreshControl.endRefreshing();
    }
    
    //Função Responsável por Carregar os Eventos e converter para o Objeto Evento.
    func carregarEventos() {
        
        Alamofire.request(.GET, "http://palestrascoletivas.com/events.json")
            .responseJSON { (_, _, JSON, error) in
                
                println(error?.code)
//                
                if (error?.code == -1009) {
                    SCLAlertView().showError("Falha na Conexão",
                        subTitle:"Não é possível estabelecer uma conexão com o servidor. Tente novamente!", closeButtonTitle:"OK")

                }
                
                if let jsonResult = JSON as? Array<Dictionary<String,String>> {
                    
                    for var index = 1; index < jsonResult.count; ++index {
                        
                        self.evento = Evento()
                        
                        self.evento.name = jsonResult[index]["name"]!;
                        self.evento.district = jsonResult[index]["district"]!;
                        self.evento.street = jsonResult[index]["street"]!;
                        self.evento.country = jsonResult[index]["country"]!;

                        self.evento.start_date = jsonResult[index]["start_date"]!;
                        self.evento.end_date = jsonResult[index]["end_date"]!;
                        self.evento.state = jsonResult[index]["state"]!;
                        self.evento.edition = jsonResult[index]["edition"]!;
                        self.evento.description = jsonResult[index]["description"]!;
                        
                        self.evento.day = self.dataUtil.extrairDia(self.evento.start_date);
                        self.evento.month = self.dataUtil.extrairMes(self.evento.start_date);
                        self.evento.year = self.dataUtil.extrairAno(self.evento.start_date);
                        
                        self.eventos.append(self.evento)
                    }
                    
                    println(self.eventos.count)
                    
                }
                
                self.tableView.reloadData()
        }
    }
    
    func limparAtributos(){
        eventos = [Evento]()
        self.evento = Evento()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(self.eventos.count)
        return self.eventos.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as EventoCustomTableViewCell;

        cell.nomeEventoLabel.text = self.eventos[indexPath.row].name;
        cell.diaEventoLabel.text = self.eventos[indexPath.row].day;
        cell.mesEventoLabel.text = self.eventos[indexPath.row].month;
        cell.anoEventoLabel.text = self.eventos[indexPath.row].year;
        
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "SegueDetalheEvento" {
            let detalheEventoViewController = segue.destinationViewController as DetalheEventoViewController
            let indexPath = self.tableView.indexPathForSelectedRow();
            detalheEventoViewController.evento = self.eventos[indexPath!.row]
            
        }
    }
}
