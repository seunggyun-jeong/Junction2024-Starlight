//
//  JsonParser.swift
//  Starlight
//
//  Created by Gyunni on 8/10/24.
//

import Foundation

enum ParsingError: Error {
    case invalidData
    case decodingError(Error)
    case fileNotFound
    case fileReadError(Error)
}

class JSONConverter {
  static func parse<T: Codable>(_ data: Data, to type: T.Type) -> Result<T, ParsingError> {
      do {
          let decoder = JSONDecoder()
          
          // Date 형식 처리를 위한 DateFormatter 설정
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          decoder.dateDecodingStrategy = .formatted(dateFormatter)
          
          // 숫자 형식의 문자열을 자동으로 숫자로 변환
          decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+infinity", negativeInfinity: "-infinity", nan: "nan")
          
          let result = try decoder.decode(T.self, from: data)
          return .success(result)
      } catch {
          return .failure(.decodingError(error))
      }
  }
  
  static func parseFromFile<T: Codable>(_ fileName: String, to type: T.Type) -> Result<T, ParsingError> {
      guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
          return .failure(.fileNotFound)
      }
      
      do {
          let jsonData = try Data(contentsOf: fileURL)
          return parse(jsonData, to: type)
      } catch {
          return .failure(.fileReadError(error))
      }
  }
  
  static func parseArrayFromFile<T: Codable>(_ fileName: String, to type: [T].Type) -> Result<[T], ParsingError> {
      return parseFromFile(fileName, to: type)
  }
}
