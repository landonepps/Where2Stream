//
//  Show.swift
//  Where2Stream
//
//  Created by Landon Epps on 10/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation

struct UtellyQueryResult: Codable {
    /*
    {
        "results": [{}],
        "updated": "2019-10-02T03:04:56+0100",
        "term": "bojack",
        "status_code": 200,
        "variant": "utelly"
    }
    */
    let results: [Show]
}

struct Show: Codable {
    /*
     "locations": [{}],
     "picture": "https://utellyassets2-10.imgix.net/2/Open/TMDB4_2462/Misc/5u3Y2HpD0wlK697lnpvNn6h5lYK.jpg?fit=crop&auto=compress&crop=faces,top",
     "id": "5995ec06ebb7f96764b6f871",
     "weight": 577,
     "name": "BoJack Horseman"
     */
    let name: String
    let services: [StreamingService]
    let imageURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case name, services = "locations", imageURL = "picture"
    }
}

struct StreamingService: Codable {
    /*
     "display_name": "Netflix",
     "name": "NetflixUS",
     "url": "https://www.netflix.com/title/70300800",
     "id": "58c141a37588d57a9522dd54",
     "icon": "https://utellyassets7.imgix.net/locations_icons/utelly/black_new/NetflixUS.png?w=92&auto=compress&app_version=2d72243e-0e48-4614-8bf9-e54ca7c01719_2019-10-02"
     */
    let name: String
    let iconURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case name = "display_name", iconURL = "icon"
    }
}
