//
//  DetalhesSnapViewController.swift
//  SnapchatCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 26/12/24.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DetalhesSnapViewController: UIViewController {
    
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var detalhes: UILabel!
    @IBOutlet weak var contador: UILabel!
    
    var snap = Snap()
    var tempo = 11

    override func viewDidLoad() {
        super.viewDidLoad()

        detalhes.text = "Carregando..,"
        
        let url = URL(string: snap.urlImagem )
        imagem.sd_setImage(with: url) { (imagem, erro, cache, url) in
            
            if erro == nil {
                
                self.detalhes.text = self.snap.descricao
                
                //Inicializar o timer
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                    
                    //decrementar o timer
                    self.tempo = self.tempo - 1
                    
                    //Exiber timer na tela
                    self.contador.text = String(self.tempo)
                    
                    //caso o timer execute até o zero, invalida
                    if self.tempo == 0 {
                        timer.invalidate()
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                })
                
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let autenticacao = Auth.auth()
        
        if let idUsuarioLogado = autenticacao.currentUser?.uid {
            
            //Remove nós do database
            let database = Database.database().reference()
            let usuarios = database.child("usuarios")
            let snaps = usuarios.child(idUsuarioLogado).child("snaps")
            
            snaps.child(snap.identificador).removeValue()
            
            //Remove imagem do Snap
            let storage = Storage.storage().reference()
            let imagens = storage.child("imagens")
            
            
            imagens.child( "\(snap.idImagem).jpg" ).delete(completion: { (erro) in
                
                if erro == nil {
                    print("Sucesso ao excluir a imagem")
                }else{
                    print("Erro ao excluir a imagem")
                }
                
            })
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
