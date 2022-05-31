//
//  VoyagerFrameworkTests.swift
//  VoyagerFrameworkTests
//
//  Created by James Folk on 5/31/22.
//

import XCTest
import Combine
@testable import VoyagerFramework

class VoyagerFrameworkTests: XCTestCase {

    private var cancellable: AnyCancellable?
    private var cryptoCoins: CryptoCoins = []
    
    override func setUp() {
        super.setUp()
    }

    func testCryptoCoinViewModel_getCryptoCoinsPrice() throws {
        
        let viewModel = CryptoCoinViewModel()
        let expectation = self.expectation(description: "CryptoCoinStatistic.get(.price)")
        let myError = viewModel.getCryptoCoinsPrice(onCompletion: { expectation.fulfill()})
        
        waitForExpectations(timeout: 10)

        // Asserting that our Combine pipeline yielded the
        // correct output:
        XCTAssertNil(myError)
        XCTAssertNotEqual(viewModel.cryptoCoins.count, 0)
    }
    
    func testCryptoCoinViewModel_search() throws {
        
        let viewModel = CryptoCoinViewModel()
        let expectation1 = self.expectation(description: "CryptoCoinStatistic.get(.price)")
        let myError = viewModel.getCryptoCoinsPrice(onCompletion: { expectation1.fulfill()})
        waitForExpectations(timeout: 10)
        
        let expectation2 = self.expectation(description: "search(\"AAVE\")")
        viewModel.search("A", onCompletion: { expectation2.fulfill()})
        waitForExpectations(timeout: 10)
        
        

        // Asserting that our Combine pipeline yielded the
        // correct output:
        XCTAssertNil(myError)
        XCTAssertNotEqual(viewModel.cryptoCoins.count, 1)
    }

    func testExtension_String_ParseSlash() throws {
        let benchmark1 = "CHZ/USD"
        let benchmark2 = "chz/usd"
        let benchmark3 = "CHZ"
        let benchmark4 = "CHZ/"
        let benchmark5 = "/"
        let benchmark6 = ""
        
        XCTAssertEqual(benchmark1.cryptoSymbol, "CHZ")
        XCTAssertEqual(benchmark2.cryptoSymbol, "CHZ")
        XCTAssertEqual(benchmark3.cryptoSymbol, "CHZ")
        XCTAssertEqual(benchmark4.cryptoSymbol, "CHZ")
        XCTAssertEqual(benchmark5.cryptoSymbol, "")
        XCTAssertEqual(benchmark6.cryptoSymbol, "")
    }
    
    func testExtension_String_PercentNumber() throws {
        let benchmark1 = "-1.1"
        let benchmark2 = "1.1"
        let benchmark3 = "1.1.1"
        let benchmark4 = "1"
        let benchmark5 = "-1.1.1.1"
        let benchmark6 = ""
        
        XCTAssertEqual(benchmark1.percent, "-1.100%")
        XCTAssertEqual(benchmark2.percent, "+1.100%")
        XCTAssertEqual(benchmark3.percent, "+0.000%")
        XCTAssertEqual(benchmark4.percent, "+1.000%")
        XCTAssertEqual(benchmark5.percent, "+0.000%")
        XCTAssertEqual(benchmark6.percent, "+0.000%")
    }
    
    func testExtension_String_CurrencyNumber() throws {
        // Change locales
        let benchmark1 = "-1.1"
        let benchmark2 = "1.1"
        let benchmark3 = "1.1.1"
        let benchmark4 = "1"
        let benchmark5 = "-1.1.1.1"
        let benchmark6 = ""
        
        XCTAssertEqual(benchmark1.currency, "-$1.10")
        XCTAssertEqual(benchmark2.currency, "$1.10")
        XCTAssertEqual(benchmark3.currency, "$0.00")
        XCTAssertEqual(benchmark4.currency, "$1.00")
        XCTAssertEqual(benchmark5.currency, "$0.00")
        XCTAssertEqual(benchmark6.currency, "$0.00")
    }
    
    func testExtension_String_DecimalNumber() throws {
        let benchmark1 = "1"
        let benchmark2 = "1000"
        let benchmark3 = "1000000"
        let benchmark4 = "1000000000"
        let benchmark5 = "1000000000.0000"
        let benchmark6 = ""
        
        XCTAssertEqual(benchmark1.decimalNumber, "1")
        XCTAssertEqual(benchmark2.decimalNumber, "1,000")
        XCTAssertEqual(benchmark3.decimalNumber, "1,000,000")
        XCTAssertEqual(benchmark4.decimalNumber, "1,000,000,000")
        XCTAssertEqual(benchmark5.decimalNumber, "1,000,000,000")
        XCTAssertEqual(benchmark6.decimalNumber, "0")
    }
    
    func testCryptoCoinElement_CalculatedProperties() throws {
        let element: CryptoCoin = CryptoCoin(id: UUID(),
                                             pairSymbol: "AAVE/USD",
                                             price: "91.98",
                                             ask: "93.14",
                                             bid: "90.81",
                                             volume24Hr: "43117904.34",
                                             changeAmt24Hr: "0.76",
                                             changePct24Hr: "0.83",
                                             high24Hr: "96.82",
                                             low24Hr: "89.65",
                                             high52W: "456.72",
                                             low52W: "61.76",
                                             circulation: "16000000",
                                             marketCap: "1471705252.00",
                                             time: 1653253632, stats: [
                                                Stat(period: 1, price: "91.86"),
                                                Stat(period: 24, price: "91.22"),
                                                Stat(period: 168, price: "89.06"),
                                                Stat(period: 720, price: "176.36"),
                                                Stat(period: 8760, price: "374.08"),
                                             ])
        
        XCTAssertEqual(element.cryptoSymbol, "AAVE")
        XCTAssertEqual(element.timeStamp, "May 22, 2022 9:7:12 GMT")
        XCTAssertEqual(element.hourChange, "$91.86")
        XCTAssertEqual(element.dayChange, "$91.22")
        XCTAssertEqual(element.weekChange, "$89.06")
        XCTAssertEqual(element.thirtyDayChange, "$176.36")
        XCTAssertEqual(element.yearChange, "$374.08")
        
    }

}
