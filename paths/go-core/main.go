package main

import (
	"fmt"
	"go-webservice/models"
)

func main() {
	u := models.User{
		ID: 2,
		FirstName: "Tricia",
		LastName: "McMillan",
	}
	fmt.Println(u)
}