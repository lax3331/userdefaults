//
//  Model.swift
//  userdefaults
//
//  Created by Nikita Kuznetsov on 07.05.2023.
//

import Foundation

class Model {
    static let model = Model()
    
    struct Const {
        static var defaultFont: Double = 17.0
        static var defaultTheme: Bool = false
        static let fileName = "fileName.txt"
        
        enum keys: String {
            case fontKey = "fontKey"
            case themeKey = "themeKey"
            case userData = "userData"
            static var allkeys = [keys.fontKey, keys.themeKey]
        }
    }
    
    struct UserData: Codable { // Имена структур принято писать с заглавной буквы
        var fontData: Double
        var themeData: Bool
    }
    
    var userDataStruct = UserData(fontData: Const.defaultFont, themeData: Const.defaultTheme)
    
    static var stepperValue: Double {
        get {
            return model.get().fontData
        }
        set {
            model.save(element: newValue, with: Const.keys.fontKey.rawValue)
        }
    }
    
    static var themeValue: Bool {
        get {
            return model.get().themeData
        }
        set {
            model.save(element: newValue, with: Const.keys.themeKey.rawValue)
        }
    }
    
    private func save(element: Any?, with key: String) {
        switch key {
        case Const.keys.fontKey.rawValue:
            userDataStruct = UserData(fontData: element as! Double, themeData: userDataStruct.themeData)
        case Const.keys.themeKey.rawValue:
            userDataStruct = UserData(fontData: userDataStruct.fontData, themeData: element as! Bool)
        default:
            break
        }
        if let data = try? JSONEncoder().encode(userDataStruct) {
//            UserDefaults.standard.set(data, forKey: Const.keys.userData.rawValue)
            try! data.write(to: getFile(name: Model.Const.fileName))
            print("File created")
        }
    }
    
    private func get() -> UserData {
//        if let data = UserDefaults.standard.object(forKey: Const.keys.userData.rawValue) as? Data
        if let data = try? Data(contentsOf: getFile(name: Model.Const.fileName)){
            if let dataUD = try? JSONDecoder().decode(UserData.self, from: data) {
                userDataStruct = dataUD
                print("Data read")
            }
        }
        return userDataStruct
    }
    private func getFile(name: String) -> URL {
        var path = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        path.appendPathComponent(name)
        fileDetail(named: path)
        return path
    }
    
    private func fileDetail(named: URL) {
        let keys: Set<URLResourceKey> = [.creationDateKey, .fileSizeKey, .nameKey]
        let resourseValue = try! named.resourceValues(forKeys: keys)
        print(
            "\(resourseValue.creationDate)",
            "\(resourseValue.fileSize)",
            "\(resourseValue.name)"
        )
    }
    
}
