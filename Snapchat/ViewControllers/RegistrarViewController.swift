//
//  RegistrarViewController.swift
//  Snapchat
//
//  Created by MAC01 on 20/05/19.
//  Copyright © 2019 Lhyan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistrarViewController: UIViewController {

    @IBOutlet weak var txtContraseña: UITextField!
    @IBOutlet weak var txtUsuario: UITextField!
    @IBAction func btnRegistrar(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.txtUsuario.text!, password: self.txtContraseña.text!, completion: { (user, error) in print("Intentanto crear Usuario")
            if error != nil {
                self.mostrarAlerta(titulo: "Error", mensaje: "Se presento el siguiente error al crear un usuario: \(error!)", accion: "Aceptar")
                self.txtUsuario.text! = ""
                self.txtContraseña.text! = ""
            }else {
                self.mostrarAlerta(titulo: "Operacion Exitosa", mensaje: "Se creo el usuario \(self.txtUsuario.text!) con exito", accion: "Aceptar")
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                self.txtUsuario.text! = ""
                self.txtContraseña.text! = ""
            }
        })
    }
    @IBAction func btnIngresar(_ sender: Any) {
        self.performSegue(withIdentifier: "loguear", sender: nil)
    }
    
    func mostrarAlerta(titulo: String, mensaje: String, accion: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: accion, style: .default, handler: nil )
        alerta.addAction(btnOk)
        present(alerta, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
