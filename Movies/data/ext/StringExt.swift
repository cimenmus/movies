//
//  StringExt.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

extension String {
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    // gets 2020 from 2020-12-14 string
    func getYearFromDate() -> String {
        if self.count >= 4 {
            return self.substring(to: 4)
        } else {
            return "-"
        }
    }
}
