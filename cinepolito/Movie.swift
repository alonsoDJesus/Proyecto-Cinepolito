//
//  User.swift
//  EjemploAPIRest
//
//  Created by IMAC18 on 09/03/23.
//

/**
    Estructura de un Usuario para almacenar datos de usuario.
 */

import Foundation
import Kingfisher

struct Movie: Decodable{ // Decodable permite la decodificacion automàtica de arcivos JSON
    
    // Variables para los datos del usuario
    let id: String?
    let titulo: String?
    let sinopsis: String?
    let genero: String?
    let idioma: String?
    let horarios: String?
    let clasificacion: String?
    let url_portada: String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case titulo
        case sinopsis
        case genero
        case idioma
        case horarios
        case clasificacion
        case url_portada
        //case id = "id"
    }
}

