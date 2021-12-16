//
//  ContentView.swift
//  CoreDataBasics
//
//  Created by Américo MQ on 16/12/21.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    
    @State private var movieName: String = ""
    @State private var movies: [Movie] = [Movie]()
    @State private var needsRefresh: Bool = false
    
    private func populateMovies() {
        movies = coreDM.getMovies()
    }
    
    var body: some View {
        NavigationView {
        VStack {
            TextField("Enter movie name", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save") {
                coreDM.saveMovie(title: movieName)
                movies = coreDM.getMovies()
            }
            List {
                ForEach(movies, id: \.self) { movie in
                    NavigationLink(
                        destination: MovieDetail(movie: movie, coreDm: coreDM, needsRefresh: $needsRefresh),
                        label: {
                            Text(movie.title ?? "")
                        })
                }.onDelete { indexSet in
                    indexSet.forEach { index in
                        let movie = movies[index]
                        coreDM.deleteMovie(movie: movie)
                        populateMovies()
                    }
                }
            }.listStyle(PlainListStyle())
                .accentColor(needsRefresh ? .white : .black)
            Spacer()
            
        }.padding()
            .onAppear(perform: {
                populateMovies()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
