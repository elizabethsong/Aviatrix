//
//  main.swift
//  AviatrixApp
//
//  Created by Amy Holt on 6/10/18.
//  Copyright © 2018 Amy Holt. All rights reserved.
//

import Foundation

func gauges(myPlane : Aviatrix) {
    print("Reading the gauges...")
    print(" ")
    print("| Running:   | ✅")
    print("| Location:  | \(myPlane.location)")
    print("| Distance:  | \(myPlane.distanceTraveled) miles")
    print("| Fuel:      | \(myPlane.fuelLevel) gallons")
    print("| Max Fuel:  | \(myPlane.maxFuel) gallons")
    print("| MPG:       | \(myPlane.milesPerGallon)")
    print("| Fuel Bill: | \(myPlane.fuelCost)")
}

func fly(myPlane : Aviatrix) {
    
    print("Where would you like to fly to? ")
    print(" ")
    var number = AviatrixData()
    let destinations = myPlane.knownDestinations(data: number)
    
    for (index, city) in destinations.enumerated() {
        let distance = myPlane.distanceTo(data: number, target: city)
        print("\(index): \(city), \(distance) miles")
    }
    
    let response = Int(readLine()!)
    var desiredLocation = ""
    
    if response! >= 0 && response! < 4 {
        desiredLocation = myPlane.knownDestinations(data: number)[response!]
        
        
        print("🛫 Preparing for takeoff...")
        print("🛫 Flying...")
        
        if fuelCheck(myPlane: myPlane, destination : desiredLocation) {
            myPlane.flyTo(data: number, destination: desiredLocation)
            print("🛬 You've arrived in \(myPlane.location)!")
            gauges(myPlane: myPlane)
        }
    }
    else {
        print("⚠️Please enter a valid command⚠️")
    }
    
}

func refuel(data: AviatrixData, myPlane : Aviatrix) {
    var prices = AviatrixData()
    
    
    print("Refueling...")
    print("⛽ Here in \(myPlane.location), jet fuel costs $\(data.fuelPrices[myPlane.location]!)")
    print("⛽ You refueled \(myPlane.findNumberofGallons(data: prices)) gallons totaling \(myPlane.findNumberofGallons(data: prices) * prices.fuelPrices[myPlane.location]!)")
    let refuelData = myPlane.refuel(data: prices)
}

func fuelCheck(myPlane : Aviatrix, destination : String) -> Bool {
//    let distanceToTravel =  Double(myPlane.distanceTo(target : destination))
//    if myPlane.fuelLevel < distanceToTravel {
//        print(" ")
//        print("🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥")
//        print("Oh no! You've run out of fuel and crashed on the way to \(myPlane.location)!")
//        print("🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥")
//
//        return false
//    } else {
//        return true
//    }
    return true
}

var author = "Elizabeth"
var plane = Aviatrix()
var numbers = AviatrixData()

print("Welcome to the Aviatrix Flight System by \(author)")
var check = plane.start()

if check == true{
    print("You're currently in \(plane.location)")

    var command = ""

    while command != "q" {
        print(" ")
        print("What would you like to do?")
        print("a) 📊 check the plane gauges")
        print("b) 🛫 fly to a different city")
        print("c) ⛽ refuel")
        print("q) ❌ quit")
        print(" ")
        print("Action: ")
        command = readLine()!
    
        if command == "a" {
            gauges(myPlane: plane)
        }
        else if command == "b" {
            fly(myPlane: plane)
        }
        else if command == "c" {
            refuel(data: numbers, myPlane: plane)
        }
        else if command != "q" {
            print("⚠️Please enter a valid command⚠️")
        }
    }



    print(" ")
    print("Thanks for flying with Singapore airline!")
}
else{
    print("Not able to fly!")
}

