package main

import (
    "fmt"
    "math/rand"
    "net/http"
	"strings"
)

type URLShortener struct {
	urls map[string]string
}

func (urls *URLShortener) HandleShorten (w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid HTTP request method", http.StatusMethodNotAllowed)
		return
	}

	originalURL := r.FormValue("url")

	if originalURL == "" {
		http.Error(w, "URL parameter is missing", http.StatusBadRequest)
		return
	}

	// Generate an unique key for the url
	shortKey := generateShortKey()
	urls.urls[shortKey] = originalURL


	// Generate the full shortened url

	shortenedURL := fmt.Sprintf("http://localhost:8080/short/%s", shortKey)

	// Render the HTML response with the sortened url

	w.Header().Set("Content-Type", "text/html")
	responseHTML := fmt.Sprintf(`
        <h2>URL Shortener</h2>
        <p>Original URL: %s</p>
        <p>Shortened URL: <a href="%s">%s</a></p>
        <form method="post" action="/shorten">
            <input type="text" name="url" placeholder="Enter a URL">
            <input type="submit" value="Shorten">
        </form>
    `, originalURL, shortenedURL, shortenedURL)

	fmt.Fprint(w, responseHTML)

}

func (urls *URLShortener) HandleRedirect (w http.ResponseWriter, r *http.Request) {

	shortKey := strings.TrimPrefix(r.URL.Path, "/short/")

	if shortKey == "" {
		http.Error(w, "Shortened key is missing", http.StatusBadRequest)
		return
	}

	// Retrieve the original URL from the map

	originalURL, found := urls.urls[shortKey]

	if !found {
		http.Error(w, "Shortened key not found", http.StatusNotFound)
		return
	}

	//Redirect to the original url

	http.Redirect(w, r, originalURL, http.StatusMovedPermanently)
}

func generateShortKey() string {

	const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

	const keyLength = 6

	//rand.Seed(time.Now().UnixNano())

	shortKey := make([]byte, keyLength)

	for i := range shortKey {
		shortKey[i] = charset[rand.Intn(len(charset))]
	}

	return string(shortKey)
}

func handleForm(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPost {
		http.Redirect(w, r, "/shorten", http.StatusSeeOther)
		return
	}

	// Serve the HTML form
	w.Header().Set("Content-Type", "text/html")
	fmt.Fprint(w, `
		<!DOCTYPE html>
		<html>
		<head>
			<title>URL Shortener</title>
		</head>
		<body>
			<h2>URL Shortener</h2>
			<form method="post" action="/shorten">
				<input type="url" name="url" placeholder="Enter a URL" required>
				<input type="submit" value="Shorten">
			</form>
		</body>
		</html>
	`)
}

func main() {
	shortener := &URLShortener{
		urls: make(map[string]string),
	}

	http.HandleFunc("/", handleForm)
	http.HandleFunc("/shorten", shortener.HandleShorten)
	http.HandleFunc("/short/", shortener.HandleRedirect)

	fmt.Println("URL shortener is running on 8080")
    http.ListenAndServe(":8080", nil)
}