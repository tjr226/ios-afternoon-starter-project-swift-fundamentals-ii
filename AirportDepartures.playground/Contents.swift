import UIKit


//: ## 1. Create custom types to represent an Airport Departures display
//: ![Airport Departures](matthew-smith-5934-unsplash.jpg)
//: Look at data from [Departures at JFK Airport in NYC](https://www.airport-jfk.com/departures.php) for reference.
//:
//: a. Use an `enum` type for the FlightStatus (En Route, Scheduled, Canceled, Delayed, etc.)
//:
//: b. Use a struct to represent an `Airport` (Destination or Arrival)
//:
//: c. Use a struct to represent a `Flight`.
//:
//: d. Use a `Date?` for the departure time since it may be canceled.
//:
//: e. Use a `String?` for the Terminal, since it may not be set yet (i.e.: waiting to arrive on time)
//:
//: f. Use a class to represent a `DepartureBoard` with a list of departure flights, and the current airport
//print("something")

enum FlightStatus: String {
    case enRoute, scheduled, canceled, delayed, boarding
}

struct Airport {
    let name: String
    let airportCode: String
    let city: String
}

struct Flight {
    let departure: Airport
    let arrival: Airport
    let date: Date?
    let terminal: String?
    let status: FlightStatus
}

class DepartureBoard {
    let airport: Airport
    var departures: [Flight]
    
    init(airport: Airport, departures: [Flight]) {
        self.airport = airport
        self.departures = departures
    }
    
    func alertPassengers() {
        for departure in self.departures {
            var departureTerminal = "TBD"
            var departureTime = "TBD"
            
            if let terminal = departure.terminal {
                departureTerminal = terminal
            } else {
                departureTerminal = "TBD. Please see the nearest information desk for more details"
            }
            
            if let time = departure.date {
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .short
                departureTime = dateFormatter.string(from: time)
            }
            
            switch departure.status {
            case .enRoute:
                print("Your flight to \(departure.arrival.name) has left and is en route.")
            case .scheduled:
                print("Your flight to \(departure.arrival.name) is scheduled to depart at \(departureTime) from Terminal \(departureTerminal).")
            case .canceled:
                print("We're sorry your flight to \(departure.arrival.name) was canceled, here is a $500 voucher.")
            case .delayed:
                print("Your flight to \(departure.arrival.name) is delayed. It is rescheduled to depart at \(departureTime) from Terminal \(departureTerminal).")
            case .boarding:
                print("Your flight to \(departure.arrival.name) is boarding, please head to Terminal \(departureTerminal) immediately. The doors are closing soon.")
            }
        }
    }
}


//: ## 2. Create 3 flights and add them to a departure board
//: a. For the departure time, use `Date()` for the current time
//:
//: b. Use the Array `append()` method to add `Flight`'s
//:
//: c. Make one of the flights `.canceled` with a `nil` departure time
//:
//: d. Make one of the flights have a `nil` terminal because it has not been decided yet.
//:
//: e. Stretch: Look at the API for [`DateComponents`](https://developer.apple.com/documentation/foundation/datecomponents?language=objc) for creating a specific time
let jfk = Airport(name: "John Francis Kennedy", airportCode: "JFK", city: "New York City")
let lga = Airport(name: "LaGuardia", airportCode: "LGA", city: "New York City")
let iad = Airport(name: "Dulles", airportCode: "IAD", city: "Washington DC")
let bos = Airport(name: "Logan", airportCode: "BOS", city: "Boston")
let ord = Airport(name: "O'hare", airportCode: "ORD", city: "Chicago")

let inOneDay = Calendar.current.date(byAdding: .day, value: 1, to: Date())
let inThreeHours = Calendar.current.date(byAdding: .hour, value: 3, to: Date())
let inFifteenMinutes = Calendar.current.date(byAdding: .minute, value: 15, to: Date())

let flightOne = Flight(departure: jfk, arrival: iad, date: Date(), terminal: "2", status: .enRoute)

let flightTwo = Flight(departure: jfk, arrival: bos, date: inThreeHours, terminal: nil, status: .scheduled)

let flightThree = Flight(departure: jfk, arrival: ord, date: nil, terminal: nil, status: .canceled)

let flightFour = Flight(departure: jfk, arrival: lga, date: inOneDay, terminal: "2", status: .delayed)

let flightFive = Flight(departure: jfk, arrival: lga, date: inFifteenMinutes, terminal: "1", status: .boarding)

let departureArray = [flightOne, flightTwo, flightThree, flightFour, flightFive]

let jfkDepartures = DepartureBoard(airport: jfk, departures: departureArray)


//: ## 3. Create a free-standing function that can print the flight information from the `DepartureBoard`
//: a. Use the function signature: `printDepartures(departureBoard:)`
//:
//: b. Use a `for in` loop to iterate over each departure
//:
//: c. Make your `FlightStatus` enum conform to `String` so you can print the `rawValue` String values from the `enum`. See the [enum documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html).
//:
//: d. Print out the current DepartureBoard you created using the function
func printDepartures(departureBoard: DepartureBoard) {
    print("Departure Board for \(departureBoard.airport.airportCode):")
    for flight in departureBoard.departures {
        print("The flight from \(flight.departure.airportCode) to \(flight.arrival.airportCode) is \(flight.status).")
    }
}

//printDepartures(departureBoard: jfkDepartures)




//: ## 4. Make a second function to print print an empty string if the `departureTime` is nil
//: a. Createa new `printDepartures2(departureBoard:)` or modify the previous function
//:
//: b. Use optional binding to unwrap any optional values, use string interpolation to turn a non-optional date into a String
//:
//: c. Call the new or udpated function. It should not print `Optional(2019-05-30 17:09:20 +0000)` for departureTime or for the Terminal.
//:
//: d. Stretch: Format the time string so it displays only the time using a [`DateFormatter`](https://developer.apple.com/documentation/foundation/dateformatter) look at the `dateStyle` (none), `timeStyle` (short) and the `string(from:)` method
//:
//: e. Your output should look like:
//:
//:     Destination: Los Angeles Airline: Delta Air Lines Flight: KL 6966 Departure Time:  Terminal: 4 Status: Canceled
//:     Destination: Rochester Airline: Jet Blue Airways Flight: B6 586 Departure Time: 1:26 PM Terminal:  Status: Scheduled
//:     Destination: Boston Airline: KLM Flight: KL 6966 Departure Time: 1:26 PM Terminal: 4 Status: Scheduled
func printDeparturesTwo(departureBoard: DepartureBoard) {
    print("Extended Departure Board for \(departureBoard.airport.airportCode):")
    
    for flight in departureBoard.departures {
        // initialize Optional vars to empty strings
        var flightTime = ""
        var flightTerminal = ""
        
        if let flightDate = flight.date {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            flightTime = dateFormatter.string(from: flightDate)
        }
    
        if let departureTerminal = flight.terminal {
            flightTerminal = departureTerminal
        }
        print("Destination: \(flight.arrival.name) Time: \(flightTime) Terminal: \(flightTerminal) Status: \(flight.status)")
    }
}

printDeparturesTwo(departureBoard: jfkDepartures)


//: ## 5. Add an instance method to your `DepatureBoard` class (above) that can send an alert message to all passengers about their upcoming flight. Loop through the flights and use a `switch` on the flight status variable.
//: a. If the flight is canceled print out: "We're sorry your flight to \(city) was canceled, here is a $500 voucher"
//:
//: b. If the flight is scheduled print out: "Your flight to \(city) is scheduled to depart at \(time) from terminal: \(terminal)"
//:
//: c. If their flight is boarding print out: "Your flight is boarding, please head to terminal: \(terminal) immediately. The doors are closing soon."
//:
//: d. If the `departureTime` or `terminal` are optional, use "TBD" instead of a blank String
//:
//: e. If you have any other cases to handle please print out appropriate messages
//:
//: d. Call the `alertPassengers()` function on your `DepartureBoard` object below
//:
//: f. Stretch: Display a custom message if the `terminal` is `nil`, tell the traveler to see the nearest information desk for more details.

jfkDepartures.alertPassengers()


//: ## 6. Create a free-standing function to calculate your total airfair for checked bags and destination
//: Use the method signature, and return the airfare as a `Double`
//:
//:     func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
//:     }
//:
//: a. Each bag costs $25
//:
//: b. Each mile costs $0.10
//:
//: c. Multiply the ticket cost by the number of travelers
//:
//: d. Call the function with a variety of inputs (2 bags, 2000 miles, 3 travelers = $750)
//:
//: e. Make sure to cast the numbers to the appropriate types so you calculate the correct airfare
//:
//: f. Stretch: Use a [`NumberFormatter`](https://developer.apple.com/documentation/foundation/numberformatter) with the `currencyStyle` to format the amount in US dollars.
func calculateAirfare(checkedBags: Int, distance: Int, travelers: Int) -> Double {
    // assumptions: checkedBags is total for all travelers
    let bagCost = checkedBags * 25
    let distanceCost = Double(distance) * 0.1
    let travelerCost = Double(travelers) * distanceCost
    let totalCost = Double(bagCost) + travelerCost
    return totalCost
}

let airfare = calculateAirfare(checkedBags: 2, distance: 1000, travelers: 2)
print(airfare)

func convertDoubleToCurrency(amount: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    
//  bonus approach
//    if let number = numberFormatter.string(from: NSNumber(value: amount)) {
//        return number
//    } else {
//        return ""
//    }
    
    // initial approach
    return numberFormatter.string(from: NSNumber(value: amount))!
}

let currencyAirfare = convertDoubleToCurrency(amount: airfare)
print(currencyAirfare)
