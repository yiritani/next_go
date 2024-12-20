package main

import (
	"fmt"
	"github.com/joho/godotenv"
	"io"
	"net/http"
	"os"
)

func main() {
	godotenv.Load(".env.local")
	callSampleFetch()
}

func callSampleFetch() {
	// 環境変数からURLを取得
	url, ok := os.LookupEnv("NEXT_PUBLIC_API_URL")
	if !ok {
		panic("NEXT_PUBLIC_API_URL is not set")
	}

	fmt.Println("Request URL:", url+"/ping")

	// HTTPリクエストを作成
	req, err := http.NewRequest("GET", url+"/ping", nil)
	if err != nil {
		panic(fmt.Errorf("failed to create request: %w", err))
	}

	// HTTPリクエストを送信
	client := &http.Client{}
	res, err := client.Do(req)
	if err != nil {
		panic(fmt.Errorf("failed to send request: %w", err))
	}
	defer res.Body.Close()

	// レスポンスボディを読み取る
	body, err := io.ReadAll(res.Body)
	if err != nil {
		panic(fmt.Errorf("failed to read response body: %w", err))
	}

	// ボディを文字列として表示
	fmt.Println("Response Body:", string(body))
}
