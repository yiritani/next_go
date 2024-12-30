package lib

import (
	"math/rand"
	"strings"
)

const alphabetNum = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

func CreateRandomString(n int) string {
	var sb strings.Builder
	k := len(alphabetNum)
	for i := 0; i < n; i++ {
		c := alphabetNum[rand.Intn(k)]
		sb.WriteByte(c)
	}
	return sb.String()
}
