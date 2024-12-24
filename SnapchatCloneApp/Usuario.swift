//
//  Usuario.swift
//  SnapchatCloneApp
//
//  Created by João Ricardo Martins Ribeiro on 24/12/24.
//

import Foundation

class Usuario {
    
    var email: String
    var nome: String
    var uid: String
    
    init(email: String, nome: String, uid: String) {
        self.email = email
        self.nome = nome
        self.uid = uid
    }
    
}
