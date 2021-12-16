//
//  MovieDetail.swift
//  CoreDataBasics
//
//  Created by Américo MQ on 16/12/21.
//

import SwiftUI

struct MovieDetail: View {
    
    let movie: Movie
    @State private var movieName: String = ""
    let coreDm: CoreDataManager
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update") {
                if !movieName.isEmpty {
                    movie.title = movieName
                    coreDm.updateMovie()
                    needsRefresh.toggle()
                }
            }
        }.padding()
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        let coreDM = CoreDataManager()
        let movie = Movie(context: coreDM.persistentContainer.viewContext)
        MovieDetail(movie: movie, coreDm: coreDM, needsRefresh: .constant(false))
    }
}
