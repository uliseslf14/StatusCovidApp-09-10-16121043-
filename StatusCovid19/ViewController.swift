//
//  ViewController.swift
//  StatusCovid19
//
//  Created by Mac1 on 16/12/20.
//

import UIKit
class ViewController: UIViewController, StatusCovidDelegate {
    func findError(whichError: Error) {
        DispatchQueue.main.async {
            if whichError.localizedDescription == "The data couldn’t be read because it is missing."{
                self.mensaje(msj: "No se esncontraron datos.\nRevisa que el nombre del país sea correcto.")
            }
            if whichError.localizedDescription == "A server with the specified hostname could not be found."{
                self.mensaje(msj: "No se tiene conexión al servidor.")
            }
        }
    }
    
    func updateStatus(status: statusModel) {
        DispatchQueue.main.async {
            let imgurl = URL(string: status.bandera)
            let imgData = NSData(contentsOf : imgurl!)
            let image = UIImage(data : imgData as! Data)
            self.flsgImsgeView.image = image
            self.confirmedLabel.text = "\(status.casos)"
            self.deadsLabel.text = "\(status.muertes)"
            self.countryLabel.text = "\(status.pais)"
            self.recoverLabel.text="\(status.recuperados)"
            
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var confirmedLabel: UILabel!

    @IBOutlet weak var recoverLabel: UILabel!
    @IBOutlet weak var deadsLabel: UILabel!
    @IBOutlet weak var flsgImsgeView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    var StatusManager = statusManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.attributedPlaceholder =
            NSAttributedString(string: "Ingresa Un País", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        // Do any additional setup after loading the view.
        StatusManager.delegado = self
    }

    @IBAction func searchButton(_ sender: UIButton) {
        countryLabel.text = searchTextField.text
        StatusManager.getData(namePais: searchTextField.text!)
        

    }
    func mensaje(msj: String){
        countryLabel.text="--"
        recoverLabel.text="--"
        deadsLabel.text="--"
        confirmedLabel.text="--"
        flsgImsgeView.image=#imageLiteral(resourceName: "loading")
        let alerta = UIAlertController(title: "Error", message: msj, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alerta, animated: true)
    }
}

