package main

import (
	"embed"
	"io/fs"
	"log"
	"net/http"
)

var (
	name    string = "no-name"
	build   string = "no-build"
	version string = "no-version"
)

//go:embed static
var content embed.FS

func main() {
	log.Printf("%s %s (%s)\n", name, version, build)
	// Embed static files into executable
	fsys, err := fs.Sub(content, "static")
	if err != nil {
		log.Fatal(err)
	}
	// Specify the handlers
	http.HandleFunc("/status", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte(`{"text":"OK"}`))
	})
	http.Handle("/", http.FileServer(http.FS(fsys)))
	// Start listing ...
	log.Println("start listening ...")
	http.ListenAndServe(":3000", nil)
}
