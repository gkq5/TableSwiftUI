//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Morales, Raegan E on 4/1/24.
//

import SwiftUI
import MapKit

let data = [
Item(name: "Ivar's River Pub", neighborhood: "Rio Vista", desc: "Casual indoor-outdoor restaurant overlooking the river with authentic Texas comfort food and drinks.", food: "American" , lat: 29.87889355018527, long: -97.93198220253186, imageName: "Ivars"),
Item(name: "Railyard Bar & Grill", neighborhood: "Downtown Association", desc: "Chill meeting spot for drinking, sports, and American pub grill, with food, beer, and bar games.", food: "American" , lat: 29.881457007886922, long: -97.93891992951565, imageName: "Railyard"),
Item(name: "Industry", neighborhood: "Downtown Association", desc: "An industrial looking indoor-outdoor bar/restuarant with American cuisine along with beers & cocktails.", food: "American" , lat: 29.8802, long: -97.94045, imageName: "Industry"),
Item(name: "Bull Daddies", neighborhood: "Downtown Association", desc: "Local downtown indoor-outdoor bar with picnic tables, good for sports watching, and drinking with friends.", food: "American" , lat: 29.884638473425937, long: -97.9409419, imageName: "BullDaddies"),
Item(name: "Taquitos Mi Rancho", neighborhood: "Rio Vista", desc: "Enjoy riverside vibes and generous portions at the local budget-friendly taco truck. Indulge in savory tacos while soaking up the sun in the inviting outdoor seating area.", food: "Mexican" , lat: 29.87884681661158, long: -97.930612775548, imageName: "Taquitos")
]
struct Item: Identifiable {
    let id = UUID()
    let name: String
    let neighborhood: String
    let desc: String
    let food: String
    let lat: Double
    let long: Double
    let imageName: String
}



struct ContentView: View {
    // add this at the top of the ContentView struct. In this case, you can choose the coordinates for the center of the map and Zoom levels
             @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.88180, longitude: -97.93576), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        NavigationView {
        VStack {
            List(data, id: \.name) { item in
                NavigationLink(destination: DetailView(item: item)) {
                HStack {
                    Image(item.imageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.neighborhood)
                            .font(.subheadline)
                    } // end internal VStack
                } // end HStack
                } // end NavigationLink
            } // end List
            //add this code in the ContentView within the main VStack.
                   Map(coordinateRegion: $region, annotationItems: data) { item in
                       MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                           Image(systemName: "mappin.circle.fill")
                               .foregroundColor(.red)
                               .font(.title)
                               .overlay(
                                   Text(item.name)
                                       .font(.subheadline)
                                       .foregroundColor(.black)
                                       .fixedSize(horizontal: true, vertical: false)
                                       .offset(y: 25)
                               )
                       }
                   } // end map
                   .frame(height: 300)
                   .padding(.bottom, -30)
                   
                       
        } // end VStack
        .listStyle(PlainListStyle())
                    .navigationTitle("San Marcos Eats!")
                } // end NavigationView
    } // end body
}

struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
       @State private var region: MKCoordinateRegion
       
       init(item: Item) {
           self.item = item
           _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
       }
       let item: Item
               
       var body: some View {
           VStack {
               Image(item.imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: 200)
               Text("Neighborhood: \(item.neighborhood)")
                   .font(.subheadline)
               Text("Description: \(item.desc)")
                   .font(.subheadline)
                   .padding(10)
               Text("Type: \(item.food)")
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(10)
               // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

                    Map(coordinateRegion: $region, annotationItems: [item]) { item in
                      MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                          Image(systemName: "mappin.circle.fill")
                              .foregroundColor(.red)
                              .font(.title)
                              .overlay(
                                  Text(item.name)
                                      .font(.subheadline)
                                      .foregroundColor(.black)
                                      .fixedSize(horizontal: true, vertical: false)
                                      .offset(y: 25)
                              )
                      }
                  } // end Map
                      .frame(height: 300)
                      .padding(.bottom, -30)
                    
                        
                   } // end VStack
                    .navigationTitle(item.name)
                    Spacer()
        } // end body
     } // end DetailView
   

#Preview {
    ContentView()
}
