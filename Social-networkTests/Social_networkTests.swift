//
//  Social_networkTests.swift
//  Social-networkTests
//
//  Created by Даша Николаева on 04.03.2025.
//

import XCTest
@testable import Social_network

final class Social_networkTests: XCTestCase {
    
    var viewModel: FeedViewModel!
    var mockRepo: MockFeedRepository!
    
    override func setUp() {
        super.setUp()
        viewModel = FeedViewModel()
        mockRepo = MockFeedRepository()
        viewModel.start(repository: mockRepo)
    }

    func testToggleLike() throws {
        let post = Post(id: 1, title: "title", body: "body", liked: false)
        viewModel.posts = [post]
        viewModel.toggleLike(for: 0)
        XCTAssertTrue(viewModel.posts[0].liked ?? false)
        viewModel.toggleLike(for: 0)
        XCTAssertFalse(viewModel.posts[0].liked ?? true)
    }
    
    func testGetImage() throws {
        let post = Post(id: 1, title: "title", body: "body", liked: false)
        viewModel.posts = [post]
        let image = viewModel.getImage(for: 0)
        XCTAssertNotNil(image)
    }
    
    class MockFeedRepository: FeedRepositoryProtocol {
        func loadPosts(completion: @escaping (Result<[Social_network.Post], any Error>) -> Void) {
        }
        
        func loadRandomPhoto(complition: ((Result<Data, any Error>) -> Void)?) {
            complition?(.success(Data()))
        }
        
        func addToDB(_ posts: [Social_network.Post]) {
        }
        
        func loadPostsFromDB(completion: @escaping (Result<[Social_network.Post], any Error>) -> Void) {
        }
        
    }

}
