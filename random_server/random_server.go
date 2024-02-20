package main

import (
	"fmt"
	"math/rand"
	"net/http"
	"time"
)

func randomDelayHandler(w http.ResponseWriter, r *http.Request) {
	rand.Seed(time.Now().UnixNano())
	delay := time.Duration(rand.Intn(8)+3) * time.Second
	time.Sleep(delay)
	fmt.Fprintf(w, "Request processed after %s delay", delay)
}

func main() {
	http.HandleFunc("/v1/metrics", randomDelayHandler)
	fmt.Println("Server listening on port 42069")
	http.ListenAndServe(":42069", nil)
}

