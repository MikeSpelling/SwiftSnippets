import Foundation

class DateFormats {
    func test() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        df.locale = Locale(identifier: "en-GB")
        df.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = df.date(from: "2021-04-20T20:04:00.123Z")
        print(df.string(from: date!)) // 2021-04-20T20:04:01.123+0000
    }
}
