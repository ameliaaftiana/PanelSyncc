//
//  Webtoon.swift
//  PanelSyncc
//
//  Created by Amelia Putri Aftiana on 18/06/26.
//


import Foundation
import Combine

// MARK: - Webtoon Model
struct Webtoon: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let author: String
    let genre: String
    let thumbnail: String
    let summary: String
    let episodes: Int
    let view: String
    let like: String
    let subscribe: String
    let rating: Double
    let status: WebtoonStatus
    
    var thumbnailURL: URL? {
        URL(string: thumbnail)
    }
    
    var ratingFormatted: String {
        String(format: "%.2f", rating)
    }
}

// MARK: - Status Enum
enum WebtoonStatus: String, Codable, CaseIterable {
    case ongoing = "Ongoing"
    case completed = "Completed"
    
    var displayName: String { rawValue }
    
    var icon: String {
        switch self {
        case .ongoing:   return "play.circle.fill"
        case .completed: return "checkmark.circle.fill"
        }
    }
    
    var color: String {
        switch self {
        case .ongoing:   return "green"
        case .completed: return "blue"
        }
    }
}

// MARK: - Sample Data (first 20 entries from combined dataset)
extension Webtoon {
    static let sampleData: [Webtoon] = [
        Webtoon(
            id: 1193,
            title: "#Blessed",
            author: "M. Victoria Robado",
            genre: "Drama",
            thumbnail: "https://picsum.photos/seed/webtoon1193/300/420",
            summary: "Joanna is a mid-twenties office girl who likes social media and watered down coffee. While griping about her love life, she accidentally swiped right on a whole Pantheon of Gods and Goddesses! Looking...",
            episodes: 64,
            view: "20M",
            like: "1.7M",
            subscribe: "423,249",
            rating: 9.19,
            status: .ongoing
        ),
        Webtoon(
            id: 1971,
            title: "#Killstagram",
            author: "Ryoung",
            genre: "Thriller",
            thumbnail: "https://picsum.photos/seed/webtoon1971/300/420",
            summary: "Remi Do has everything -- she's super pretty, has the best brand sponsorships on social media, and gets 10,000 likes within seconds of posting a selfie. Oh, and she also has a serial-killing stalker f...",
            episodes: 44,
            view: "39.5M",
            like: "3.5M",
            subscribe: "873,551",
            rating: 9.32,
            status: .ongoing
        ),
        Webtoon(
            id: 3115,
            title: "'Til Debt Do Us Part",
            author: "flowbee",
            genre: "Romance",
            thumbnail: "https://picsum.photos/seed/webtoon3115/300/420",
            summary: "Subin's mom routinely pays for matchmakers to set her up on dates. Subin turns them all down, one after another. One day she runs into an old friend from school, and things start to get complicated wh...",
            episodes: 9,
            view: "8.6M",
            like: "841,545",
            subscribe: "298,612",
            rating: 9.69,
            status: .ongoing
        ),
        Webtoon(
            id: 3766,
            title: "100",
            author: "Hyeong Eun",
            genre: "Action",
            thumbnail: "https://picsum.photos/seed/webtoon3766/300/420",
            summary: "Armed only with a gun and a frying pan, Hoyoung Cheon must survive Battlegrounds: a battle-royale style game with 100 participants, where there’s only one way to win: kill the 99 other players, all of...",
            episodes: 16,
            view: "1M",
            like: "100,849",
            subscribe: "110,736",
            rating: 9.19,
            status: .ongoing
        ),
        Webtoon(
            id: 1217,
            title: "1000",
            author: "Chuck Brown",
            genre: "Action",
            thumbnail: "https://picsum.photos/seed/webtoon1217/300/420",
            summary: "Set in a modern world of aliens, warlocks, zombies, and ancient beasts, \"1000\" follows Dragon Son - a supreme entity who’s abandoned all creation as he struggles to return to his true Dragon form by...",
            episodes: 20,
            view: "1.4M",
            like: "80,230",
            subscribe: "104,922",
            rating: 8.99,
            status: .completed
        ),
        Webtoon(
            id: 71,
            title: "10th Dimension Boys",
            author: "Cutbu",
            genre: "Comedy",
            thumbnail: "https://picsum.photos/seed/webtoon71/300/420",
            summary: "In another dimension, anything can happen in your daily life. Absurdly funny, the boys from the 10th dimension are up to no good again....",
            episodes: 119,
            view: "28.2M",
            like: "807,700",
            subscribe: "93,812",
            rating: 9.34,
            status: .completed
        ),
        Webtoon(
            id: 3235,
            title: "11 of Me",
            author: "Jiae Go",
            genre: "Supernatural",
            thumbnail: "https://picsum.photos/seed/webtoon3235/300/420",
            summary: "To Gibeom’s surprise, the mechanical calculator he bought working at a junkyard turns out to be a time machine! With the time machine, he sets out to find and bring together his past selves. Currently...",
            episodes: 7,
            view: "1.4M",
            like: "197,270",
            subscribe: "102,261",
            rating: 8.84,
            status: .completed
        ),
        Webtoon(
            id: 437,
            title: "1111 Animals",
            author: "1111",
            genre: "Comedy",
            thumbnail: "https://picsum.photos/seed/webtoon437/300/420",
            summary: "The secret lives of animals...",
            episodes: 110,
            view: "6.9M",
            like: "256,687",
            subscribe: "48,496",
            rating: 8.9,
            status: .completed
        ),
        Webtoon(
            id: 2960,
            title: "1HP Club",
            author: "elfboi",
            genre: "Fantasy",
            thumbnail: "https://picsum.photos/seed/webtoon2960/300/420",
            summary: "A comic about the daily life of dungeon boys. Slaying the city, saving the dragons... or something like that....",
            episodes: 37,
            view: "15.8M",
            like: "1.6M",
            subscribe: "405,635",
            rating: 9.62,
            status: .ongoing
        ),
        Webtoon(
            id: 391,
            title: "2015: Space Series",
            author: "Various Artists",
            genre: "Sci-fi",
            thumbnail: "https://picsum.photos/seed/webtoon391/300/420",
            summary: "Collective Comic Essays on the Universe and Beyond...",
            episodes: 14,
            view: "1.1M",
            like: "65,046",
            subscribe: "58,006",
            rating: 9.27,
            status: .completed
        ),
        Webtoon(
            id: 2718,
            title: "21st Century Knights",
            author: "Plastic Bottru",
            genre: "Fantasy",
            thumbnail: "https://picsum.photos/seed/webtoon2718/300/420",
            summary: "Not all knights wield armor and swords; some are capable of summoning ethereal weapons known as \"Animas\". And if you are strong enough, you might be able to join the legendary Knight's Order. As par...",
            episodes: 11,
            view: "1.8M",
            like: "209,922",
            subscribe: "162,250",
            rating: 9.4,
            status: .ongoing
        ),
        Webtoon(
            id: 380,
            title: "3-Second Strip",
            author: "Bae Jin-Soo",
            genre: "Comedy",
            thumbnail: "https://picsum.photos/seed/webtoon380/300/420",
            summary: "Just spend three seconds of your day on this three-panel comic!...",
            episodes: 503,
            view: "16.1M",
            like: "809,731",
            subscribe: "61,546",
            rating: 8.52,
            status: .completed
        ),
        Webtoon(
            id: 3441,
            title: "66,666 Years:Advent of the Dark Mage",
            author: "PASA",
            genre: "Fantasy",
            thumbnail: "https://picsum.photos/seed/webtoon3441/300/420",
            summary: "Diablo Volpir, a powerful dark mage, was defeated and sealed away in a battle against the 12 gods. He finally wakes up from his sleep 66,666 years later, however, in the body of a newborn baby, Jamie ...",
            episodes: 33,
            view: "8.1M",
            like: "1M",
            subscribe: "368,980",
            rating: 9.75,
            status: .ongoing
        ),
        Webtoon(
            id: 3784,
            title: "7FATES: CHAKHO",
            author: "HYBE",
            genre: "Fantasy",
            thumbnail: "https://picsum.photos/seed/webtoon3784/300/420",
            summary: "In the corrupt city of Sin-si, Zeha suddenly wakes up in a hospital, unable to recall anything that happened after speaking with a mysterious man one night. He soon learns that strange beings called b...",
            episodes: 13,
            view: "24.5M",
            like: "1.7M",
            subscribe: "1.5M",
            rating: 9.87,
            status: .ongoing
        ),
        Webtoon(
            id: 294,
            title: "A Bittersweet Life",
            author: "Donggeon Lee",
            genre: "Slice of life",
            thumbnail: "https://picsum.photos/seed/webtoon294/300/420",
            summary: "A collection of sweet stories about couples and singles, office workers and unemployed people. But be warned: there’s more than a touch of bitterness here....",
            episodes: 161,
            view: "6.5M",
            like: "430,390",
            subscribe: "91,033",
            rating: 9.32,
            status: .completed
        ),
        Webtoon(
            id: 985,
            title: "A Budgie's Life",
            author: "Muffin Girl",
            genre: "Slice of life",
            thumbnail: "https://picsum.photos/seed/webtoon985/300/420",
            summary: "When it comes to birds we think they are just fluttering little creatures who have no contact with humans whatsoever. But bird owners know that's not true! Like pet dogs and cats, birds have a persona...",
            episodes: 401,
            view: "66.8M",
            like: "7.3M",
            subscribe: "342,445",
            rating: 9.79,
            status: .completed
        ),
        Webtoon(
            id: 3909,
            title: "A Chance At Last",
            author: "Dindon",
            genre: "Romance",
            thumbnail: "https://picsum.photos/seed/webtoon3909/300/420",
            summary: "Sisters Ju-eun and Hyejin grew up in absolute poverty. After their mother’s death, Hyejin accepts the offer to join their estranged father’s wealthy family. But when Hyejin turns out dead just three y...",
            episodes: 15,
            view: "2M",
            like: "247,377",
            subscribe: "167,054",
            rating: 9.82,
            status: .ongoing
        ),
        Webtoon(
            id: 3910,
            title: "A DeadbEAT's Meal",
            author: "CHEESE",
            genre: "Slice of life",
            thumbnail: "https://picsum.photos/seed/webtoon3910/300/420",
            summary: "Now a major (K-Drama) adaptation.                                                                                                                                                                       ...",
            episodes: 15,
            view: "1.2M",
            like: "157,040",
            subscribe: "106,241",
            rating: 9.18,
            status: .completed
        ),
        Webtoon(
            id: 2276,
            title: "A Fake Affair",
            author: "Akiko Higashimura",
            genre: "Romance",
            thumbnail: "https://picsum.photos/seed/webtoon2276/300/420",
            summary: "After searching and failing to find a husband for 3 years, Shoko Hama is ready to give up. Tired from work and marriage-less future prospects, she quits her job and travels on a solo trip to Korea. On...",
            episodes: 6,
            view: "1.2M",
            like: "181,822",
            subscribe: "43,617",
            rating: 9.19,
            status: .ongoing
        ),
        Webtoon(
            id: 1390,
            title: "A Good Day to be a Dog",
            author: "Lee Hey",
            genre: "Romance",
            thumbnail: "https://picsum.photos/seed/webtoon1390/300/420",
            summary: "Hana has made every effort to avoid an inevitable family curse... of turning into a dog after her first kiss. Worst of all, the only way for her to break the curse is to get a second kiss. How will th...",
            episodes: 10,
            view: "103.3M",
            like: "10.4M",
            subscribe: "1.3M",
            rating: 9.84,
            status: .completed
        )
    ]
}

// MARK: - Data Loader
class WebtoonDataLoader: ObservableObject {
    @Published var webtoons: [Webtoon] = []
    @Published var comments: [ComicComment] = []
    @Published var chapters: [ComicChapter] = []
    @Published var collections: [ComicCollection] = []
    
    /// Load all webtoons from the bundled JSON file
    func loadFromBundle(filename: String = "webtoon_combined") {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Could not find \(filename).json in bundle")
            webtoons = Webtoon.sampleData
            return
        }
        do {
            webtoons = try JSONDecoder().decode([Webtoon].self, from: data)
        } catch {
            print("Decode error: \(error)")
            webtoons = Webtoon.sampleData
        }
    }
    
    /// Filter helpers
    func filtered(by genre: String? = nil, status: WebtoonStatus? = nil) -> [Webtoon] {
        webtoons.filter { w in
            (genre == nil || w.genre == genre!) &&
            (status == nil || w.status == status!)
        }
    }
    
    func genres() -> [String] {
        Array(Set(webtoons.map(\.genre))).sorted()
    }
    
    func topRated(limit: Int = 10) -> [Webtoon] {
        webtoons.sorted { $0.rating > $1.rating }.prefix(limit).map { $0 }
    }
    
    /// Load comments for a specific comic ID
    func loadComments(for comicId: Int, filename: String = "comments") {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Could not find \(filename).json in bundle")
            return
        }
        
        do {
            // Set up a custom decoder to handle the ISO8601 date strings
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let allComments = try decoder.decode([ComicComment].self, from: data)
            
            // Filter the comments so we only show the ones belonging to the selected comic
            self.comments = allComments.filter { $0.comicId == comicId }
            
        } catch {
            print("Decode error for comments: \(error)")
        }
    }
    /// Load chapters for a specific comic ID
    func loadChapters(for comicId: Int, filename: String = "chapters") {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        do {
            let allChapters = try JSONDecoder().decode([ComicChapter].self, from: data)
            self.chapters = allChapters.filter { $0.comicId == comicId }
        } catch {
            print("Decode error for chapters: \(error)")
        }
    }
    
    /// Load featured collections
    func loadCollections(filename: String = "collections") {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        do {
            self.collections = try JSONDecoder().decode([ComicCollection].self, from: data)
        } catch {
            print("Decode error for collections: \(error)")
        }
    }
    
    // Call this to load everything at once
    func loadAllData(for comicId: Int) {
        loadWebtoons()
        loadComments(for: comicId)
        loadChapters(for: comicId)
        loadCollections()
    }
    
    func loadWebtoons(filename: String = "webtoon_combined") {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        do {
            webtoons = try JSONDecoder().decode([Webtoon].self, from: data)
        } catch {
            print("Decode error webtoons: \(error)")
        }
    }
}

// MARK: - Thumbnail Image View
// Drop-in SwiftUI component for loading webtoon cover images
import SwiftUI

struct WebtoonThumbnailView: View {
    let url: String
    var width: CGFloat = 120
    var height: CGFloat = 168
    var cornerRadius: CGFloat = 10
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color(.systemGray5))
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            case .failure:
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color(.systemGray4))
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                }
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: width, height: height)
    }
}

// MARK: - Ranking Helpers
extension WebtoonDataLoader {
    
    /// Parses "874M", "46.2K", "2,300" → Double for sorting
    func parseCount(_ raw: String) -> Double {
        let clean = raw.trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: ",", with: "")
        if clean.hasSuffix("M"), let n = Double(clean.dropLast()) { return n * 1_000_000 }
        if clean.hasSuffix("K"), let n = Double(clean.dropLast()) { return n * 1_000 }
        return Double(clean) ?? 0
    }
    
    /// Popularity — sorted by subscribers (highest first)
    func popularityRank(limit: Int = 100) -> [Webtoon] {
        webtoons.sorted { parseCount($0.subscribe) > parseCount($1.subscribe) }
            .prefix(limit).map { $0 }
    }
    
    /// Trending — sorted by total views (highest first)
    func trendingRank(limit: Int = 100) -> [Webtoon] {
        webtoons.sorted { parseCount($0.view) > parseCount($1.view) }
            .prefix(limit).map { $0 }
    }
    
    /// New Comer — ongoing webtoons with ≤ 30 episodes, sorted by fewest episodes first
    func newcomerRank(limit: Int = 100) -> [Webtoon] {
        webtoons.filter { $0.status == .ongoing && $0.episodes <= 30 }
            .sorted { $0.episodes < $1.episodes }
            .prefix(limit).map { $0 }
    }
    
    /// Genre Rank — top-rated webtoons for a specific genre
    func genreRank(genre: String, limit: Int = 100) -> [Webtoon] {
        webtoons.filter { $0.genre == genre }
            .sorted { $0.rating > $1.rating }
            .prefix(limit).map { $0 }
    }
    
    /// All unique genres available
    func allGenres() -> [String] {
        Array(Set(webtoons.map(\.genre))).sorted()
    }
}
