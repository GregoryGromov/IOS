//
//  MorzeCode0swift
//  MorseMessanger_demo1
//
//  Created by Григорий Громов on 13012020230
//

import Foundation

class MorzeService {
    
    private var separatorCharacter = "/"
    
    
    private var morseAlphabet = [
        "0": "11111",
        "1": "01111",
        "2": "00111",
        "3": "00011",
        "4": "00001",
        "5": "00000",
        "6": "10000",
        "7": "11000",
        "8": "11100",
        "9": "11110",
        "a": "01",
        "b": "1000",
        "c": "1010",
        "d": "100",
        "e": "0",
        "f": "0010",
        "g": "110",
        "h": "0000",
        "i": "00",
        "j": "0111",
        "k": "101",
        "l": "0100",
        "m": "11",
        "n": "10",
        "o": "111",
        "p": "0110",
        "q": "1101",
        "r": "010",
        "s": "000",
        "t": "1",
        "u": "001",
        "v": "0001",
        "w": "011",
        "x": "1001",
        "y": "1011",
        "z": "1100",
        ".": "010101",
        ",": "110011",
        "?": "001100",
        "!": "101011",
        "-": "100001",
        "/": "10010",
        "@": "011010",
        "(": "10110",
        ")": "101101",
        " ": "111111"
    ]

    private var morseAlphabetInverse = [
        "11111": "0",
        "01111": "1",
        "00111": "2",
        "00011": "3",
        "00001": "4",
        "00000": "5",
        "10000": "6",
        "11000": "7",
        "11100": "8",
        "11110": "9",
        "01": "a",
        "1000": "b",
        "1010": "c",
        "100": "d",
        "0": "e",
        "0010": "f",
        "110": "g",
        "0000": "h",
        "00": "i",
        "0111": "j",
        "101": "k",
        "0100": "l",
        "11": "m",
        "10": "n",
        "111": "o",
        "0110": "p",
        "1101": "q",
        "010": "r",
        "000": "s",
        "1": "t",
        "001": "u",
        "0001": "v",
        "011": "w",
        "1001": "x",
        "1011": "y",
        "1100": "z",
        "010101": ".",
        "110011": ",",
        "001100": "?",
        "101011": "!",
        "100001": "-",
        "10010": "/",
        "011010": "@",
        "10110": "(",
        "101101": ")",
        "111111": " "
    ]
    
    
    func morzeEncoder(message: String) -> String {
        
        var encodedMessage = ""
        
        for letter in message {
            
            if let code = morseAlphabet[String(letter)] {
                encodedMessage += String(code)
                encodedMessage += separatorCharacter
            } else {
                print("DEBUG: There is not symbol '\(letter)' in alphabet")
            }
        }
        
        return encodedMessage
    }

    func morzeDecoder(message2: String) -> String {
        
        var message = message2
        
        guard let lastCharacter = message.last else { return "" }
        if lastCharacter != separatorCharacter.first {
            message.append(separatorCharacter)
        }
        
       
        
      
        
        print("Функция запущена c входными данным: \(message)")
        
        var decodedMessage = ""
        var buffer = ""
        
        for symbol in message {
            
            
            if String(symbol) == separatorCharacter {
                if let code = morseAlphabetInverse[buffer] {
                    decodedMessage += code
                    buffer = ""
                }
            } else {
                buffer += String(symbol)
            }
            
            
        }
        print("Возвращена строка: \(decodedMessage)")
        return decodedMessage
    }
}
