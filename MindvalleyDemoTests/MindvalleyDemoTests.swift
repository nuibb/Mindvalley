//
//  MindvalleyDemoTests.swift
//  MindvalleyDemoTests
//
//  Created by Nurul Islam on 6/2/24.
//

import XCTest
@testable import MindvalleyDemo

final class MindvalleyDemoTests: XCTestCase {
    var mockDataProvider: MockDataProvider!
    
    override func setUpWithError() throws {
        mockDataProvider = MockDataProvider()
    }
    
    override func tearDownWithError() throws {
        mockDataProvider = nil
    }

    func test_ChannelsListViewModel_when_network_is_unavailable() async {
        // ARRANGE
        let expectation = XCTestExpectation(description: "Network error expectation")
        mockDataProvider.networkMonitor.isConnected = false // Set the network to be unavailable
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response = await mockDataProvider.fetchChannels()
            if case .success(_) = response {
                XCTFail("Expected network to be unavailable")
            } else if case .failure(let error) = response {
                XCTAssertEqual(error.description, RequestError.networkNotAvailable.description)
                expectation.fulfill()
            } else {
                XCTFail("Expected network to be unavailable")
            }
        }
        
        // ASSERT
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func test_ChannelsListViewModel_fetching_channels_successful() async {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch all the Channels")
        mockDataProvider.networkMonitor.isConnected = true
        
        do {
            /// Ensure network connectivity for real API call
            try XCTSkipUnless(mockDataProvider.networkMonitor.isConnected, "Network connectivity needed for this test.")
        } catch {
            XCTFail("Skipping test due to lack of network connectivity: \(error)")
            return
        }
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response = await mockDataProvider.fetchChannels()
            if case .success(let result) = response {
                if let channels = result.rawData?.channels {
                    XCTAssertFalse(channels.isEmpty, "Fetching channels is successful!")
                    XCTAssertGreaterThan(channels.count, 0)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetching channels failed")
                }
            } else if case .failure(let error) = response {
                XCTFail("Fetching channels failed: \(error.localizedDescription)")
            } else {
                XCTFail("Fetching channels failed")
            }
        }
        
        // ASSERT
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func test_ChannelsListViewModel_fetching_channels_empty() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch channels: response is empty")
        let dummyUrl = "https://pastebin.com/raw/Xt12uVhM"
        let json = """
        {
            "data": {
                "channels": []
            }
        }
        """
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response: Swift.Result<ChannelsData, RequestError> = self.fakeApiRequest(
                for: dummyUrl,
                statusCode: 200,
                responseData: json.data(using: .utf8)!)
            if case .success(let result) = response {
                if let channels = result.rawData?.channels {
                    XCTAssertTrue(channels.isEmpty, "Fetching channels is empty!")
                    XCTAssertEqual(channels.count, 0)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetch channels: response isn't empty")
                }
            } else if case .failure(let error) = response {
                XCTFail("Fetch channels: response isn't empty: \(error.localizedDescription)")
            } else {
                XCTFail("Fetch channels: response isn't empty")
            }
        }
        
        // ASSERT
        wait(for: [expectation], timeout: 5)
    }
    
    func test_ChannelsListViewModel_fetching_channels_successful_or_unsuccessful_by_random() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch channels: unauthorised response")
        let dummyUrl = "https://pastebin.com/raw/Xt12uVhM"
        let delay = Int.random(in: 1...2)
        
        // ACT
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(delay)) {
            let shouldFail = Bool.random()
            
            if shouldFail {
                let response: Swift.Result<ChannelsData, RequestError> = self.fakeApiRequest(
                    for: dummyUrl,
                    statusCode: 401)
                if case .success(let data) = response {
                    XCTFail("Fetching channels should be failed!")
                } else if case .failure(let error) = response {
                    XCTAssertEqual(error.description, RequestError.unauthorized.description)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetching channels should be failed!")
                }
            } else {
                XCTFail("Fetching channels should be failed!")
            }
        }
        
        // ASSERT
        wait(for: [expectation], timeout: 5)
    }
    
    // Fake API REQUEST to test
    private func fakeApiRequest<T: Decodable>(
        for url: String,
        statusCode: Int,
        responseData: Data? = nil) -> Swift.Result<T, RequestError> {
            guard let response = HTTPURLResponse(
                url: URL(string: url)!,
                statusCode: statusCode,
                httpVersion: "HTTP/1.1",
                headerFields: nil) else { return .failure(.noResponse) }
            
            switch response.statusCode {
            case 200...299:
                if let data = responseData {
                    guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                        return .failure(.decode)
                    }
                    return .success(decodedResponse)
                } else {
                    return .failure(.custom("No data available to parse!"))
                }
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unknown)
            }
        }
    
    func test_ChannelsListViewModel_fetching_Episodes_successful() async {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch all the Episodes")
        mockDataProvider.networkMonitor.isConnected = true
        
        do {
            /// Ensure network connectivity for real API call
            try XCTSkipUnless(mockDataProvider.networkMonitor.isConnected, "Network connectivity needed for this test.")
        } catch {
            XCTFail("Skipping test due to lack of network connectivity: \(error)")
            return
        }
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response = await mockDataProvider.fetchNewEpisodes()
            if case .success(let result) = response {
                if let episodes = result.data?.mediaItems {
                    XCTAssertFalse(episodes.isEmpty, "Fetching episodes is successful!")
                    XCTAssertGreaterThan(episodes.count, 0)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetching episodes failed")
                }
            } else if case .failure(let error) = response {
                XCTFail("Fetching episodes failed: \(error.localizedDescription)")
            } else {
                XCTFail("Fetching episodes failed")
            }
        }
        
        // ASSERT
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func test_ChannelsListViewModel_fetching_episodes_empty() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch channels: response is empty")
        let dummyUrl = "https://pastebin.com/raw/z5AExTtw"
        let json = """
        {
            "data": {
                "media": []
            }
        }
        """
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response: Swift.Result<Episodes, RequestError> = self.fakeApiRequest(
                for: dummyUrl,
                statusCode: 200,
                responseData: json.data(using: .utf8)!)
            if case .success(let result) = response {
                if let episodes = result.data?.mediaItems {
                    XCTAssertTrue(episodes.isEmpty, "Fetching episodes is empty!")
                    XCTAssertEqual(episodes.count, 0)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetch episodes: response isn't empty")
                }
            } else if case .failure(let error) = response {
                XCTFail("Fetch episodes: response isn't empty: \(error.localizedDescription)")
            } else {
                XCTFail("Fetch episodes: response isn't empty")
            }
        }
        
        // ASSERT
        wait(for: [expectation], timeout: 5)
    }
    
    func test_ChannelsListViewModel_fetching_categories_successful() async {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch all the Categories")
        mockDataProvider.networkMonitor.isConnected = true
        
        do {
            /// Ensure network connectivity for real API call
            try XCTSkipUnless(mockDataProvider.networkMonitor.isConnected, "Network connectivity needed for this test.")
        } catch {
            XCTFail("Skipping test due to lack of network connectivity: \(error)")
            return
        }
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response = await mockDataProvider.fetchCategories()
            if case .success(let result) = response {
                if let categories = result.rawData?.categories {
                    XCTAssertFalse(categories.isEmpty, "Fetching categories is successful!")
                    XCTAssertGreaterThan(categories.count, 0)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetching categories failed")
                }
            } else if case .failure(let error) = response {
                XCTFail("Fetching categories failed: \(error.localizedDescription)")
            } else {
                XCTFail("Fetching categories failed")
            }
        }
        
        // ASSERT
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func test_ChannelsListViewModel_fetching_categories_empty() {
        // Arrange
        let expectation = XCTestExpectation(description: "Fetch categories: response is empty")
        let dummyUrl = "https://pastebin.com/raw/A0CgArX3"
        let json = """
        {
            "data": {
                "categories": []
            }
        }
        """
        
        // ACT
        Task { [weak self] in
            guard let self = self else { return }
            let response: Swift.Result<Episodes, RequestError> = self.fakeApiRequest(
                for: dummyUrl,
                statusCode: 200,
                responseData: json.data(using: .utf8)!)
            if case .success(let result) = response {
                if let episodes = result.data?.mediaItems {
                    XCTAssertTrue(episodes.isEmpty, "Fetching categories is empty!")
                    XCTAssertEqual(episodes.count, 0)
                    expectation.fulfill()
                } else {
                    XCTFail("Fetch categories: response isn't empty")
                }
            } else if case .failure(let error) = response {
                XCTFail("Fetch categories: response isn't empty: \(error.localizedDescription)")
            } else {
                XCTFail("Fetch categories: response isn't empty")
            }
        }
        
        // ASSERT
        wait(for: [expectation], timeout: 5)
    }

}
