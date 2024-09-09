package main

import (
	"booking-app/helper"
	"fmt"
	"time"
)

const conferenceTickets uint = 50

var conferenceName = "Go conference"
var remainingTickets = conferenceTickets
var bookings []UserData

type UserData struct {
	firstName string
	lastName string
	email string
	numberOfTickets uint
}

func main(){

	greetUser()


	for {
		
		firstName, lastName, email, userTickets := getUserInput()

		isValidName, isValidEmail, isValidUserTickets := helper.ValidateUserInput(firstName, lastName, email, userTickets, remainingTickets)
		
		if isValidEmail && isValidName && isValidUserTickets {
			
			bookTicket(remainingTickets, conferenceName, firstName, lastName, email, userTickets)
			go sendTicket(userTickets, firstName, lastName, email)

		} else {

			if !isValidName {
				fmt.Println("Your first or last name is too short")
			}

			if !isValidEmail {
				fmt.Println("Your email does not contain the @ sign")
			}

			if !isValidUserTickets {
				fmt.Println("Number of tickets is invalid")
			}

		}

		if remainingTickets == 0 {
			fmt.Println("Our conference is sold out, come back next year!")

			break
		}

	}
	
}

func greetUser(){
	fmt.Printf("Welcome to %v booking application!\n", conferenceName)

	fmt.Printf("We have total of %v tickets and %v are still available\n",conferenceTickets, remainingTickets)

}

func printFirstNames() []string{
	firstNames := []string{}

	for _, booking := range bookings {

		firstNames = append(firstNames, booking.firstName)
	}
	return firstNames

}



func getUserInput() (string, string, string, uint){
	var firstName string
	var lastName string
	var email string
	var userTickets uint
	
	fmt.Println("Enter your first name:")
	fmt.Scan(&firstName)
	
	fmt.Println("Enter your last name:")
	fmt.Scan(&lastName)
	
	fmt.Println("Enter your email:")
	fmt.Scan(&email)
	
	fmt.Println("Enter how many tickets you want to book:")
	fmt.Scan(&userTickets)

	return firstName, lastName, email, userTickets
}

func bookTicket(remainingTickets uint, confName string, firstName string, lastName string, email string, userTickets uint){
		
	remainingTickets = remainingTickets - userTickets

	//create a map for users

	var userData = UserData {
		firstName: firstName,
		lastName: lastName,
		email: email,
		numberOfTickets: userTickets,
	}
	
	
	fmt.Printf("There are %v tickets remaining for the %v\n", remainingTickets, confName)

	bookings = append(bookings, userData)
	
	firstNames := printFirstNames()

	fmt.Printf("These are all the bookings: %v\n", firstNames)

	fmt.Printf("Thank you, %v %v for booking %v tickets, you'll receive a confirmation in %v\n", firstName, lastName, userTickets, email)

}

func sendTicket(userTickets uint, firstName string, lastName string, email string) {

	time.Sleep(10 * time.Second)

	var ticket = fmt.Sprintf("\n%v tickets fot %v %v\n", userTickets, firstName, lastName)

	fmt.Println("################################################")

	fmt.Printf("Sending tickets\n %v \n to email address: %v\n", ticket, email)

	fmt.Println("################################################")
}