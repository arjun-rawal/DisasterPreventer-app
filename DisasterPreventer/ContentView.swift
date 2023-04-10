//
//  ContentView.swift
//  DisasterPreventer
//
//  Created by Arjun Rawal on 4/6/23.
//

import SwiftUI



struct ContentView: View {
    @State private var selection = 0

    var body: some View {


        
        VStack(spacing: 0) {
                    switch self.selection {
                    case 0:
                        protocolScreen()
                    case 1:
                        numberScreen()
                    default:
                        protocolScreen()
                    }

                    CustomNavBar(selection: $selection)
                        .background(Color.red)
                        .frame(height: 80)
                        .zIndex(1)
                }
                .edgesIgnoringSafeArea(.bottom)

    }
}

struct CustomNavBar: View {
    @Binding var selection: Int
    var body: some View {
        HStack(spacing: 0) {
            Button(action: { self.selection = 0 }) {
                VStack {
                    Image(systemName: "book")
                    Text("What To Do")
                }
            }
            .frame(maxWidth: .infinity)
            
            Button(action: { self.selection = 1 }) {
                VStack {
                    Image(systemName: "phone")
                    Text("Who To Call")
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 8)
        .background(Color.white)
    }
}

struct protocolScreen: View {
    @State private var isShowingPopup = false
    @State private var popupContent = ""
    @State private var filterText = ""
    
    let situations = [("Stranded on an Island", "If you find yourself stranded on a deserted island, the first priority is to ensure your own safety and that of any others who may be with you. Find or create a source of potable water, such as by collecting rainwater or distilling seawater. Locate or build a shelter to protect yourself from the elements. Use any available resources to start a fire, which can help keep you warm, cook food, and ward off animals. Create a signal to attract attention from rescuers or passing boats."),
                       ("Lost in the Wilderness", "If you are lost in the wilderness, stay put and avoid wandering aimlessly. Use any available resources to create a shelter and build a fire. Make yourself visible to rescuers by creating a signal, such as by lighting a fire or using a mirror to reflect sunlight. If you have food and water, ration it carefully. If you are not rescued within a few days, consider walking downhill, as civilization is more likely to be found at lower elevations."),
                       ("Car Breakdown", "If your car breaks down, try to pull off the road and out of the way of traffic. Turn on your hazard lights to signal to other drivers that you are in distress. Call for roadside assistance or attempt to fix the problem yourself, if you are able to do so safely. If you are unable to fix the problem and are in a remote location, stay with your car and wait for help to arrive. Make yourself visible to passing cars by tying a bright cloth to your antenna or hanging a distress signal from a window."),
                       ("Earthquake", "If you are indoors during an earthquake, seek shelter under a sturdy piece of furniture, such as a desk or table. If you are unable to find shelter, crouch down and cover your head and neck with your hands. Stay away from windows and exterior walls. If you are outside, move to an open area away from buildings, trees, and power lines. If you are driving, pull over to the side of the road and stop as quickly as possible, avoiding overpasses, bridges, and power lines."),
                       ("House Fire", "If you are in a house that is on fire, evacuate immediately and call 911. Alert anyone else in the building and help them evacuate, if possible. If you are unable to leave the building, close all doors between you and the fire and stuff towels or clothing under the doors to prevent smoke from entering. Call 911 to report your location and stay near a window to make yourself visible to firefighters."),
                       ("Mugging", "If you are being mugged, try to remain calm and comply with the attacker's demands. Your safety is the most important thing. Do not resist or try to fight back, as this could escalate the situation and put you in more danger. If the attacker demands your purse or wallet, give it to them without hesitation. After the attack, report the incident to the police and provide as much information as possible about the attacker."),
                       ("Gas Leak", "If you suspect a gas leak, evacuate the building immediately and call 911 or your local gas company. Do not use any electrical devices, as this could create a spark that could ignite the gas. Do not turn any lights on or off, as this could also create a spark. Do not light matches or use any open flames. If you are unable to evacuate the building, open windows and doors to allow fresh air to circulate and call for help."),
                      ("Severe Weather", "If severe weather is approaching, stay informed through local media and take appropriate precautions. If you're instructed to evacuate, do so immediately. If you need to stay indoors, stay away from windows and exterior doors, and seek shelter in an interior room or basement."),
                      ("Robbery", "If you're the victim of a robbery, comply with the robber's demands and try to stay calm. Remember any details you can about the robber's appearance and behavior, and call the police as soon as it's safe to do so. Take steps to prevent future incidents, such as improving the security of your home or business."),
                      ("Medical Emergency", "If you or someone else experiences a medical emergency, call for emergency medical services immediately. Administer first aid if you're trained to do so, and stay with the person until help arrives. Provide any relevant medical history or information to the emergency responders."),
                      ("Active Shooter", "If you encounter an active shooter, run if you can, hide if you can't run, and fight if necessary as a last resort. If you're able to escape, leave belongings behind and keep your hands visible. If you're hiding, lock or barricade the door and silence your phone. If you're fighting, act aggressively and try to incapacitate the shooter."),
                      ("Car Accident", "If you're involved in a car accident, stay calm and check yourself and any passengers for injuries. Call for emergency medical services if necessary, and exchange contact and insurance information with the other driver. Take pictures of the scene and contact your insurance provider as soon as possible.")
                      ]


    
    var filteredSituations: [(String, String)] {
        if filterText.isEmpty {
            return situations.sorted(by: { $0.0 < $1.0 })
        } else {
            return situations.filter { $0.0.lowercased().contains(filterText.lowercased()) }
                .sorted(by: { $0.0 < $1.0 })
        }
    }
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
   

        ZStack {
            Text("Disaster Preventer").font(.largeTitle).multilineTextAlignment(.center).bold().frame(width: nil).position(.init(x: UIScreen.main.bounds.width/2, y: 20)).zIndex(20)
            VStack {
                TextField("Search", text: $filterText)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .position(.init(x: screenWidth/2,y:screenHeight*0.1))
                
                ScrollView(){
                ForEach(filteredSituations, id: \.0) { situation in
                    Button(action: {
                        self.popupContent = situation.1
                        withAnimation(.easeOut) {
                            self.isShowingPopup = true
                        }
                    }) {
                        Text(situation.0)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                }
                .frame(width: screenWidth,height: screenHeight*0.8)
            .blur(radius: isShowingPopup ? 10 : 0)
            .disabled(isShowingPopup)
            .position(.init(x:screenWidth/2,y:screenHeight*0.1))
        }
            if isShowingPopup {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.easeOut) {
                                self.isShowingPopup = false
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)

                    Text(self.popupContent)
                        .padding()

                    Spacer()

                    Button(action: {
                        withAnimation(.easeOut) {
                            self.isShowingPopup = false
                        }
                    }) {
                        Text("Close")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 16)
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
                .transition(.move(edge: .bottom))
                .zIndex(1) // Bring the popup to the front
            }
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.2), value: isShowingPopup) // Fade in and out the background
        .navigationTitle("Situations")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct numberScreen: View {
    
    let countries = [
        "United States": "911",
        "Canada": "911",
        "Mexico": "911",
        "Argentina": "911",
        "Brazil": "190",
        "Chile": "131",
        "Colombia": "123",
        "Costa Rica": "911",
        "Cuba": "106",
        "Dominican Republic": "911",
        "Ecuador": "911",
        "El Salvador": "911",
        "Guatemala": "110",
        "Haiti": "114",
        "Honduras": "911",
        "Jamaica": "119",
        "Nicaragua": "118",
        "Panama": "911",
        "Paraguay": "911",
        "Peru": "105",
        "Puerto Rico": "911",
        "Trinidad and Tobago": "999",
        "Uruguay": "911",
        "Venezuela": "171",
        "United Kingdom": "999",
        "Australia": "000",
        "New Zealand": "111",
        "China": "110",
        "India": "112",
        "Japan": "110",
        "South Korea": "112",
        "Indonesia": "110",
        "Malaysia": "999",
        "Philippines": "911",
        "Singapore": "999",
        "Thailand": "191",
        "Vietnam": "113",
        "France": "112",
        "Germany": "112",
        "Italy": "112",
        "Netherlands": "112",
        "Spain": "112",
        "Sweden": "112",
        "Switzerland": "112",
        "Greece": "112",
        "Turkey": "112",
        "Russia": "112",
        "South Africa": "10111",
        "Egypt": "122",
        "Nigeria": "112",
        "Kenya": "112",
        "Ghana": "112",
        "Morocco": "190",
        "Tanzania": "112",
        "Uganda": "112",
        "Algeria": "14",
        "Sudan": "999",
        "Mozambique": "112",
        "Cameroon": "112",
        "Madagascar": "117",
        "Ivory Coast": "185",
        "North Korea": "119",
        "Taiwan": "110",
        "Hong Kong": "999",
        "Macau": "999"
    ]

    
    @State private var selectedCountry = "United States"
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Emergency Number")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            Divider()
            VStack {
                SearchBar(text: $searchText, placeholder: "Search countries")
                ScrollView {
                    ForEach(countries.filter { searchText.isEmpty || $0.key.localizedCaseInsensitiveContains(searchText) }, id: \.key) { country in
                        Button(action: {
                            selectedCountry = country.key
                            if let phoneNumber = countries[selectedCountry] {
                                if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                                    UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                                }
                                print(phoneNumber)
                            }
                        }, label: {
                            HStack {
                                Text(country.key)
                                Spacer()
                                Text(countries[country.key]!)
                            }
                            .padding(.horizontal)
                        })
                    }
                }
                .frame(height: 400)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                .padding(.horizontal)
            }
            Divider()
            HStack {
                Spacer()
                Text("Emergency number for \(selectedCountry): ")
                    .fontWeight(.bold)
                Text(countries[selectedCountry]!)
                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .zIndex(1)
    }
}

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField(placeholder, text: $text)
        }
        .padding(.all, 10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
