//
//  ViewController.swift
//  SnapchatCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 24/12/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let autenticacao = Auth.auth()
        
        /*do {
            try autenticacao.signOut()
        } catch {
            print("Erro ao deslogar usuario")
        }*/
        
        autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
            
            if let usuarioLogado = usuario {
                self.performSegue(withIdentifier: "loginAutomaticoSegue", sender: nil)
            }
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
