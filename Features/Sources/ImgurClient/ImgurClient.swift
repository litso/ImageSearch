import Combine
import Foundation
import Models
import Secrets

public class ImgurClient {
    public init() { }

    public func searchMedia(query: String, page: Int) -> AnyPublisher<SearchResults, Error> {
        let url = URL(string: "https://api.imgur.com/3/gallery/search/\(page)?q=\(query)")!
        var request = URLRequest(url: url)
        request.addValue("Client-ID \(Secrets.imgurKey)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(
                type: SearchResults.self,
                decoder: JSONDecoder()
            )
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
