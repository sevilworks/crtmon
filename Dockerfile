# Build stage
FROM golang:1.22-alpine AS builder

WORKDIR /app
COPY . .

RUN go mod download
RUN go build -o crtmon

# Runtime stage
FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/crtmon .

ENV DOMAIN=example.com

CMD ["sh", "-c", "./crtmon -d $DOMAIN"]
