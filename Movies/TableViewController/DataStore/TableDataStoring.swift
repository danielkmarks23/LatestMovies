import Foundation

protocol TableDataStoring {
    
    var array: [Codable] { get }
    func load(_ completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void)
}
