package main

import (
	"archive/zip"
	"crypto/sha1"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"io"
	"os"
)

type File struct {
	Name string `json:"name"`
	Size uint64 `json:"size"`
	Sha1 string `json:"sha1"`
}

type Archive struct {
	Name     string  `json:"name"`
	Url      string  `json:"url"`
	Contents []*File `json:"contents"`
}

func calcSha1(zf *zip.File) (*string, error) {
	r, err := zf.Open()
	if err != nil {
		return nil, err
	}
	defer r.Close()

	h := sha1.New()
	_, err = io.Copy(h, r)
	if err != nil {
		return nil, err
	}
	hs := hex.EncodeToString(h.Sum(nil))

	return &hs, nil
}

func newFile(zf *zip.File) (*File, error) {
	name := zf.FileHeader.Name
	size := zf.FileHeader.UncompressedSize64
	sha1, err := calcSha1(zf)
	if err != nil {
		return nil, err
	}
	return &File{name, size, *sha1}, nil
}

func newArchive(path, name, url string) (*Archive, error) {
	r, err := zip.OpenReader(path)
	if err != nil {
		return nil, err
	}
	defer r.Close()

	files := []*File{}
	for _, zf := range r.File {
		if zf.Mode().IsDir() {
			continue
		}
		f, err := newFile(zf)
		if err != nil {
			return nil, err
		}
		files = append(files, f)
	}
	return &Archive{name, url, files}, nil
}

func writeJson(v interface{}, name string) error {
	b, err := json.MarshalIndent(v, "", "  ")
	if err != nil {
		return err
	}

	f, err := os.Create(name)
	if err != nil {
		return err
	}
	defer f.Close()
	f.Write(b)

	return nil
}

func main() {
	if len(os.Args) < 5 {
		fmt.Println("Args: {output} ({path} {name} {url})+")
		return
	}
	out := os.Args[1]

	archives := []*Archive{}
	for i := 2; i+2 < len(os.Args); i += 3 {
		a, err := newArchive(os.Args[i], os.Args[i+1], os.Args[i+2])
		if err != nil {
			fmt.Println("Failed to create Archive:", err, os.Args[i:i+3])
			return
		}
		archives = append(archives, a)
	}

	err := writeJson(archives, out)
	if err != nil {
		fmt.Println("Failed to writeJson:", err)
	}
}
