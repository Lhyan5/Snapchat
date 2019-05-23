import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class iniciarSesionViewController: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error)
            return
        }

        GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil{
                print ("Fallando el inicio de esta funcion:", err)
                return
            }
            print (result)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Quitando cuenta de facebook")
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func btnRegistrar(_ sender: Any) {
        self.performSegue(withIdentifier: "registrar", sender: nil)
    }
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in print ("Intentando Iniciar Sesion")
            if error != nil{
                print("se presento el siguiente error: \(error)")
                self.mostrarAlerta(titulo: "Error", mensaje: "No se encontro al usuario ¿Desea crear uno?", acciona: "Crear Usuario", accionn: "Cancelar")
            }else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
        emailTextField.text! = ""
        passwordTextField.text! = ""
    }
    func mostrarAlerta(titulo: String, mensaje: String, acciona: String, accionn: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnOk = UIAlertAction(title: acciona, style: .default, handler: {(action) in self.registrar() } )
        let btnCancel = UIAlertAction(title: accionn, style: .default, handler: nil)
        alerta.addAction(btnOk)
        alerta.addAction(btnCancel)
        present(alerta, animated: true, completion: nil)
    }
    
    func registrar(){
        self.performSegue(withIdentifier: "registrar", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        -------------------------FACEBOOK---------------------------------------------------
        
        let loginButton = FBLoginButton()
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 100, y: 600, width: view.frame.width - 200, height: 30)
        loginButton.delegate = self
        
//        -----------------------------------------------------------------------------------------
    }
    
}

