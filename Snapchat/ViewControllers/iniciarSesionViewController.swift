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
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in print ("Intentando Iniciar Sesion")
            if error != nil{
                print("se presento el siguiente error: \(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in print("Intentanto crear Usuario")
                    if error != nil {
                        print("Se presento el siguiente error al crear un usuario: \(error)")
                    }else {
                        print("El usuario fue creado exitosamente")
                    Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                        
                        let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario: \(self.emailTextField.text!) se creo correctamente", preferredStyle: .alert)
                        let btnOK = UIAlertAction(title: "aceptar" , style: .default, handler: { (UIAlertAction) in
                            self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                        })
                        alerta.addAction(btnOK)
                        self.present(alerta, animated: true, completion: nil)
                    }
                })
            }else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        -------------------------FACEBOOK---------------------------------------------------
        
        let loginButton = FBLoginButton()
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 100, y: 500, width: view.frame.width - 200, height: 30)
        loginButton.delegate = self
        
//        -----------------------------------------------------------------------------------------
    }
    
}

