//
//  Subject.swift
//  AddieLibros
//
//  Created by cristian regina on 23/11/23.
//

import Foundation
import MapKit

struct Address: Codable{
    var data: [Datum]
    
    init() {
        self.data = [Datum(latitude: 51.50, longitude: -0.1275, name: "start")]
    }
}

struct Datum: Codable {
    internal init(latitude: Double, longitude: Double, name: String? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
    
    let latitude, longitude: Double
    let name: String?
    
    init() {
        self.latitude = 51.50
        self.longitude = -0.1275
        self.name = "pin"
    }
}

struct Location: Identifiable{
    let id: UUID
    let name: String
    let coordinate: CLLocationCoordinate2D

    internal init(name: String, coordinate: CLLocationCoordinate2D) {
        self.id = UUID()
        self.name = name
        self.coordinate = coordinate
    }
    
    init() {
        self.id = UUID()
        self.name = "pin"
        self.coordinate = CLLocationCoordinate2D(latitude: 51.50 , longitude: -0.1275)
    }

}

struct Subject: Identifiable, Decodable {
    
    
    let id: String
    let name: String
    let key: String
    let works: [Book]
    
    internal init(id: String, name: String, key: String, works: [Book]) {
        self.id = id
        self.name = name
        self.key = key
        self.works = works
    }
    
    init(){
        self.id = ""
        self.name = ""
        self.key = ""
        self.works = []
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case key
        case works
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Subject.CodingKeys> = try decoder.container(keyedBy: Subject.CodingKeys.self)
        self.id = NSUUID().uuidString
        self.name = try container.decode(String.self, forKey: Subject.CodingKeys.name)
        self.key = try container.decode(String.self, forKey: Subject.CodingKeys.key)
        self.works = try container.decode([Book].self, forKey: Subject.CodingKeys.works)
    }
}

struct Book: Identifiable, Decodable {
    
    let id: String
    let key: String
    let title: String
    let cover_id: Int
    let cover_url: String
    let authors: [Author]
    let first_publish_year: Int
    let is_readable: Bool
    let available_to_borrow: Bool
    
    internal init(id: String, key: String, title: String, cover_id: Int, authors: [Author], first_publish_year: Int, is_readable: Bool, available_to_borrow: Bool) {
        self.id = id
        self.key = key
        self.title = title
        self.cover_id = cover_id
        self.cover_url = "https://covers.openlibrary.org/b/ID/\(self.cover_id)-L.jpg"
        self.authors = authors
        self.first_publish_year = first_publish_year
        self.is_readable = is_readable
        self.available_to_borrow = available_to_borrow
    }
    
    enum CodingKeys: CodingKey {
        case id
        case key
        case title
        case cover_id
        case cover_url
        case authors
        case first_publish_year
        case is_readable
        case available_to_borrow
        case availability
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Book.CodingKeys> = try decoder.container(keyedBy: Book.CodingKeys.self)
        self.id = NSUUID().uuidString
        self.key = try container.decode(String.self, forKey: Book.CodingKeys.key)
        self.title = try container.decode(String.self, forKey: Book.CodingKeys.title)
        self.cover_id = try container.decode(Int.self, forKey: Book.CodingKeys.cover_id)
        self.cover_url = "https://covers.openlibrary.org/b/ID/\(self.cover_id)-L.jpg"
        self.authors = try container.decode([Author].self, forKey: Book.CodingKeys.authors)
        self.first_publish_year = try container.decode(Int.self, forKey: Book.CodingKeys.first_publish_year)
        
        let availabilityContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .availability)
        self.is_readable = try availabilityContainer.decode(Bool.self, forKey: .is_readable)
        self.available_to_borrow = try availabilityContainer.decode(Bool.self, forKey: .available_to_borrow)
    }
    
}

struct Author: Identifiable, Decodable {
    let id: UUID
    let key: String
    let name: String
    
    internal init(key: String, name: String) {
        self.id = UUID()
        self.key = key
        self.name = name
    }
    
    enum CodingKeys: CodingKey {
        case id
        case key
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Author.CodingKeys> = try decoder.container(keyedBy: Author.CodingKeys.self)
        self.id = UUID()
        self.key = try container.decode(String.self, forKey: Author.CodingKeys.key)
        self.name = try container.decode(String.self, forKey: Author.CodingKeys.name)
    }
}

struct MockData{
    static let author = Author(key: "1234", name: "Cervantes")
    static let authors = [author, author]
    static let book1 = Book(id: "id Book1",key: "book Key1", title: "Book title1", cover_id: 12818862, authors: authors, first_publish_year: 2000, is_readable: true, available_to_borrow: true)
    static let book2 = Book(id: "id Book2",key: "book Key2", title: "Book title2", cover_id: 12818862, authors: authors, first_publish_year: 2000, is_readable: true, available_to_borrow: true)
    static let books = [book1, book2]
    static let subject = Subject(id: "mockSubject", name: "subject name", key: "subject key", works: books)
    
    static let realList = ["arte", "animales", "ficcion", "ciencia", "matematicas", "negocios", "finanzas", "infantil", "historia", "salud", "bienestar", "biografia", "ciencias sociales", "libros de texto", "idioma"]
}


struct AuthorDetailData: Decodable {
    internal init(deathDate: String? = nil, key: String? = nil, birthDate: String? = nil, name: String? = nil, photos: [Int]? = [], personalName: String? = nil, title: String? = nil, links: [Links]? = [], wikipedia: String? = nil, bio: String? = nil) {
        self.deathDate = deathDate
        self.key = key
        self.birthDate = birthDate
        self.name = name
        self.photos = photos
        self.personalName = personalName
        self.title = title
        self.links = links
        self.wikipedia = wikipedia
        self.bio = bio
    }
    
    var deathDate      : String?       = nil
    var key            : String?       = nil
    var birthDate      : String?       = nil
    var name           : String?       = nil
    var photos         : [Int]?        = []
    var personalName   : String?       = nil
    var title          : String?       = nil
    var links          : [Links]?      = []
    var wikipedia      : String?       = nil
    var bio            : String?       = nil
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case deathDate      = "death_date"
        case key            = "key"
        case birthDate      = "birth_date"
        case name           = "name"
        case photos         = "photos"
        case personalName   = "personal_name"
        case title          = "title"
        case links          = "links"
        case wikipedia      = "wikipedia"
        case bio            = "bio"
    }
    
    
    
    init(from decoder: Decoder) throws {
        
        let container: KeyedDecodingContainer<AuthorDetailData.CodingKeys> = try decoder.container(keyedBy: AuthorDetailData.CodingKeys.self)
        
        deathDate      = try container.decodeIfPresent(String.self       , forKey: AuthorDetailData.CodingKeys.deathDate      )
        key            = try container.decodeIfPresent(String.self       , forKey: AuthorDetailData.CodingKeys.key            )
        birthDate      = try container.decodeIfPresent(String.self       , forKey: AuthorDetailData.CodingKeys.birthDate      )
        name           = try container.decodeIfPresent(String.self       , forKey: AuthorDetailData.CodingKeys.name           )
        photos         = try container.decodeIfPresent([Int].self        , forKey: AuthorDetailData.CodingKeys.photos         )
        personalName   = try container.decodeIfPresent(String.self       , forKey: AuthorDetailData.CodingKeys.personalName   )
        title          = try container.decodeIfPresent(String.self       , forKey: AuthorDetailData.CodingKeys.title          )
        links          = try container.decodeIfPresent([Links].self      , forKey: AuthorDetailData.CodingKeys.links          )
        wikipedia      = try container.decodeIfPresent(String.self       , forKey: AuthorDetailData.CodingKeys.wikipedia      )
        bio            = try container.decodeIfPresent(String.self       , forKey: AuthorDetailData.CodingKeys.bio            )
    }
    init() {
    }
}


struct AuthorDetailDataWithBioObject: Decodable {
    var deathDate      : String?       = nil
    var key            : String?       = nil
    var birthDate      : String?       = nil
    var name           : String?       = nil
    var photos         : [Int]?        = []
    var bio            : Bio?          = Bio()
    var personalName   : String?       = nil
    var title          : String?       = nil
    var links          : [Links]?      = []
    var wikipedia      : String?       = nil
    
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case deathDate      = "death_date"
        case key            = "key"
        case birthDate      = "birth_date"
        case name           = "name"
        case photos         = "photos"
        case bio            = "bio"
        case personalName   = "personal_name"
        case title          = "title"
        case links          = "links"
        case wikipedia      = "wikipedia"
    }
    
    
    
    init(from decoder: Decoder) throws {
        
        let container: KeyedDecodingContainer<AuthorDetailDataWithBioObject.CodingKeys> = try decoder.container(keyedBy: AuthorDetailDataWithBioObject.CodingKeys.self)
        
        deathDate      = try container.decodeIfPresent(String.self       , forKey: AuthorDetailDataWithBioObject.CodingKeys.deathDate      )
        key            = try container.decodeIfPresent(String.self       , forKey: AuthorDetailDataWithBioObject.CodingKeys.key            )
        birthDate      = try container.decodeIfPresent(String.self       , forKey: AuthorDetailDataWithBioObject.CodingKeys.birthDate      )
        name           = try container.decodeIfPresent(String.self       , forKey: AuthorDetailDataWithBioObject.CodingKeys.name           )
        photos         = try container.decodeIfPresent([Int].self        , forKey: AuthorDetailDataWithBioObject.CodingKeys.photos         )
        bio            = try container.decodeIfPresent(Bio.self          , forKey: AuthorDetailDataWithBioObject.CodingKeys.bio            )
        personalName   = try container.decodeIfPresent(String.self       , forKey: AuthorDetailDataWithBioObject.CodingKeys.personalName   )
        title          = try container.decodeIfPresent(String.self       , forKey: AuthorDetailDataWithBioObject.CodingKeys.title          )
        links          = try container.decodeIfPresent([Links].self      , forKey: AuthorDetailDataWithBioObject.CodingKeys.links          )
        wikipedia      = try container.decodeIfPresent(String.self       , forKey: AuthorDetailDataWithBioObject.CodingKeys.wikipedia      )
    }
    init() {
    }
}
struct Bio: Decodable {
    var type  : String? = nil
    var value : String? = nil
    
    enum CodingKeys: String, CodingKey {
        case type  = "type"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Bio.CodingKeys> = try decoder.container(keyedBy: Bio.CodingKeys.self)
        type  = try container.decodeIfPresent(String.self , forKey: .type  )
        value = try container.decodeIfPresent(String.self , forKey: .value )
    }
    
    init() {
    }
}

struct Links: Decodable {
    var title : String? = nil
    var url   : String? = nil
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case url   = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self , forKey: .title )
        url   = try values.decodeIfPresent(String.self , forKey: .url   )
    }
    
    init() {
    }
}

struct FavoriteBook: Decodable {
    internal init(title: String? = nil, key: String? = nil, authors: [Authors]? = [], description: String? = nil, covers: [Int]? = [], subjectPlaces: [String]? = []) {
        self.title = title
        self.key = key
        self.authors = authors
        self.description = description
        self.covers = covers
        self.subjectPlaces = subjectPlaces
    }
    
    var title         : String?    = nil
    var key           : String?    = nil
    var authors       : [Authors]? = []
    var description   : String?    = nil
    var covers        : [Int]?     = []
    var subjectPlaces : [String]?  = []
    
    enum CodingKeys: String, CodingKey {
        case title         = "title"
        case key           = "key"
        case authors       = "authors"
        case description   = "description"
        case covers        = "covers"
        case subjectPlaces = "subject_places"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title         = try values.decodeIfPresent(String.self    , forKey: .title         )
        key           = try values.decodeIfPresent(String.self    , forKey: .key           )
        authors       = try values.decodeIfPresent([Authors].self , forKey: .authors       )
        description   = try values.decodeIfPresent(String.self    , forKey: .description   )
        covers        = try values.decodeIfPresent([Int].self     , forKey: .covers        )
        subjectPlaces = try values.decodeIfPresent([String].self  , forKey: .subjectPlaces )
    }
    
    init() {
    }
}

struct FavoriteBookWithDescrObject: Decodable {
    var title         : String?    = nil
    var key           : String?    = nil
    var authors       : [Authors]? = []
    var description   : Description?    = Description()
    var covers        : [Int]?     = []
    var subjectPlaces : [String]?  = []
    
    enum CodingKeys: String, CodingKey {
        case title         = "title"
        case key           = "key"
        case authors       = "authors"
        case description   = "description"
        case covers        = "covers"
        case subjectPlaces = "subject_places"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title         = try values.decodeIfPresent(String.self    , forKey: .title         )
        key           = try values.decodeIfPresent(String.self    , forKey: .key           )
        authors       = try values.decodeIfPresent([Authors].self , forKey: .authors       )
        description   = try values.decodeIfPresent(Description.self    , forKey: .description   )
        covers        = try values.decodeIfPresent([Int].self     , forKey: .covers        )
        subjectPlaces = try values.decodeIfPresent([String].self  , forKey: .subjectPlaces )
    }
    
    init() {
    }
}

struct Description: Codable {
    var type  : String? = nil
    var value : String? = nil
    enum CodingKeys: String, CodingKey {
        case type  = "type"
        case value = "value"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type  = try values.decodeIfPresent(String.self , forKey: .type  )
        value = try values.decodeIfPresent(String.self , forKey: .value )
    }
    init() {
    }
}

struct Authorlittle: Decodable{
    
    var key : String? = nil
    enum CodingKeys: String, CodingKey {
        case key = "key"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self , forKey: .key )
    }
    init() {
    }
}

struct Authors: Identifiable, Decodable {
    var id: UUID? = UUID()
    var author : Authorlittle? = Authorlittle()
    var type   : Type?   = Type()
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case type   = "type"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(Authorlittle.self , forKey: .author )
        type   = try values.decodeIfPresent(Type.self   , forKey: .type   )
    }
    init() {
    }
}

struct Type: Decodable{
    var key : String? = nil
    enum CodingKeys: String, CodingKey {
        case key = "key"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self , forKey: .key )
    }
    init() {
    }
}

struct SearchResult: Decodable {
    var numFound : Int?    = nil
    var docs     : [Docs]? = []
    var q        : String? = nil
    
    enum CodingKeys: String, CodingKey {
        case numFound = "numFound"
        case docs     = "docs"
        case q        = "q"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        numFound = try values.decodeIfPresent(Int.self    , forKey: .numFound )
        docs     = try values.decodeIfPresent([Docs].self , forKey: .docs     )
        q        = try values.decodeIfPresent(String.self , forKey: .q        )
    }
    
    init() {
    }
}

struct Docs: Decodable {
    var key                 : String?   = nil
    var type                : String?   = nil
    var title               : String?   = nil
    var titleSuggest        : String?   = nil
    var titleSort           : String?   = nil
    var subtitle            : String?   = nil
    var editionCount        : Int?      = nil
    var editionKey          : [String]? = []
    var publishDate         : [String]? = []
    var publishYear         : [Int]?    = []
    var firstPublishYear    : Int?      = nil
    var numberOfPagesMedian : Int?      = nil
    var ebookCountI         : Int?      = nil
    var ebookAccess         : String?   = nil
    var hasFulltext         : Bool?     = nil
    var coverEditionKey     : String?   = nil
    var coverI              : Int?      = nil
    var publisher           : [String]? = []
    var language            : [String]? = []
    var authorKey           : [String]? = []
    var authorName          : [String]? = []
    var publisherFacet      : [String]? = []
    var authorFacet         : [String]? = []
    var subjectKey          : [String]? = []
    
    enum CodingKeys: String, CodingKey {
        case key                 = "key"
        case type                = "type"
        case title               = "title"
        case titleSuggest        = "title_suggest"
        case titleSort           = "title_sort"
        case subtitle            = "subtitle"
        case editionCount        = "edition_count"
        case editionKey          = "edition_key"
        case publishDate         = "publish_date"
        case publishYear         = "publish_year"
        case firstPublishYear    = "first_publish_year"
        case numberOfPagesMedian = "number_of_pages_median"
        case ebookCountI         = "ebook_count_i"
        case ebookAccess         = "ebook_access"
        case hasFulltext         = "has_fulltext"
        case coverEditionKey     = "cover_edition_key"
        case coverI              = "cover_i"
        case publisher           = "publisher"
        case language            = "language"
        case authorKey           = "author_key"
        case authorName          = "author_name"
        case publisherFacet      = "publisher_facet"
        case authorFacet         = "author_facet"
        case subjectKey          = "subject_key"
    }
    
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key                 = try values.decodeIfPresent(String.self   , forKey: .key                 )
        type                = try values.decodeIfPresent(String.self   , forKey: .type                )
        title               = try values.decodeIfPresent(String.self   , forKey: .title               )
        titleSuggest        = try values.decodeIfPresent(String.self   , forKey: .titleSuggest        )
        titleSort           = try values.decodeIfPresent(String.self   , forKey: .titleSort           )
        subtitle            = try values.decodeIfPresent(String.self   , forKey: .subtitle            )
        editionCount        = try values.decodeIfPresent(Int.self      , forKey: .editionCount        )
        editionKey          = try values.decodeIfPresent([String].self , forKey: .editionKey          )
        publishDate         = try values.decodeIfPresent([String].self , forKey: .publishDate         )
        publishYear         = try values.decodeIfPresent([Int].self    , forKey: .publishYear         )
        firstPublishYear    = try values.decodeIfPresent(Int.self      , forKey: .firstPublishYear    )
        numberOfPagesMedian = try values.decodeIfPresent(Int.self      , forKey: .numberOfPagesMedian )
        ebookCountI         = try values.decodeIfPresent(Int.self      , forKey: .ebookCountI         )
        ebookAccess         = try values.decodeIfPresent(String.self   , forKey: .ebookAccess         )
        hasFulltext         = try values.decodeIfPresent(Bool.self     , forKey: .hasFulltext         )
        coverEditionKey     = try values.decodeIfPresent(String.self   , forKey: .coverEditionKey     )
        coverI              = try values.decodeIfPresent(Int.self      , forKey: .coverI              )
        publisher           = try values.decodeIfPresent([String].self , forKey: .publisher           )
        language            = try values.decodeIfPresent([String].self , forKey: .language            )
        authorKey           = try values.decodeIfPresent([String].self , forKey: .authorKey           )
        authorName          = try values.decodeIfPresent([String].self , forKey: .authorName          )
        publisherFacet      = try values.decodeIfPresent([String].self , forKey: .publisherFacet      )
        authorFacet         = try values.decodeIfPresent([String].self , forKey: .authorFacet         )
        subjectKey          = try values.decodeIfPresent([String].self , forKey: .subjectKey          )
    }
    init() {
    }
}
