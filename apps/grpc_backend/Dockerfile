FROM google/cloud-sdk:slim AS fetch-db

WORKDIR /app
RUN gsutil cp gs://next-go-bucket/db.sqlite /app/db.sqlite

# Stage 1: Build the Go application
FROM golang:1.22 AS build

# Set working directory
WORKDIR /app

# Copy dependency files and download modules
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code
COPY . .

# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Stage 2: Create a lightweight image for running
FROM gcr.io/distroless/base-debian11

# Set working directory
WORKDIR /app

# Copy the built binary
COPY --from=build /app/main .
COPY --from=fetch-db /app/db.sqlite .

# Expose port for Cloud Run
EXPOSE 8080

# Command to run the binary
ENTRYPOINT ["./main"]