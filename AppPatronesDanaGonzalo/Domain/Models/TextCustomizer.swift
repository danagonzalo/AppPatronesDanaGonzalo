import Foundation
import UIKit

class TextCustomizer {
    // Función para poner la mitad de un texto de color rojo (en nuestro caso, la otra mitad es amarilla)
    static private func changeHalfTextColor(_ text: String, mutableString: NSMutableAttributedString) {
        
        let fullTextLength = text.count

        // Como el texto por defecto es amarillo, hacemos que la otra mitad sea rojo
        mutableString.addAttribute(.foregroundColor,
                                     value: UIColor.red,
                                     range: NSMakeRange(fullTextLength-fullTextLength/2, fullTextLength/2))
        
        // Añadimos un borde negro al texto
        mutableString.addAttribute(.strokeColor,
                                     value: UIColor.black,
                                     range: NSMakeRange(0, fullTextLength))
        
        mutableString.addAttribute(.strokeWidth,
                                   value: -5,
                                     range: NSMakeRange(0, fullTextLength))
    }
    
    
    
    // Cambia el color de un substring, en nuestro caso, lo usamos para cambiar de color la letra "O"
    static private func changeCharacterColor(for character: String, fullTextLength: Int, mutableString: NSMutableAttributedString) {
        
        var range = NSRange(location: 0, length: mutableString.length)

        // Empezamos a buscar las letras "O" en el nombre del Hero...
        while (range.location != NSNotFound) {
            
            range = (mutableString.string as NSString).range(of: character, options: [], range: range)
            
            if (range.location != NSNotFound) {
                
                // Hacemos la letra "O" es de color naranja...
                mutableString.addAttribute(.foregroundColor,
                                             value: UIColor.systemOrange,
                                             range: NSRange(location: range.location, length: 1))
                
                // ... con borde amarillo
                mutableString.addAttribute(.strokeColor,
                                             value: UIColor.systemYellow,
                                             range: NSRange(location: range.location, length: 1))
                
                
                // Seguimos buscando letras "O" dentro del string
                range = NSRange(location: range.location + range.length,
                                length: fullTextLength - (range.location + range.length))
            }
        }
    }
    
    // Personalizamos el texto de un UILabel con la fuente y colores de dragon ball
    static func customize(_ label: UILabel) {
        
        // Creamos NSMutableAttributedString con el nombre del Hero
        let mutableString = NSMutableAttributedString(string: label.text!, attributes: [NSAttributedString.Key : Any]())
        
        changeHalfTextColor(label.text!, mutableString: mutableString)
        
        // Vamos a hacer que todas las letras "O" sean de color diferente, para simular las bolas de dragón :)
        changeCharacterColor(for: "o", fullTextLength: label.text!.count, mutableString: mutableString)

        // Añadimos los cambios a nuestra UILabel
        label.attributedText = mutableString
    }
}
