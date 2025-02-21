# Bước 1: Sử dụng image Golang chính thức
FROM golang:1.20 AS builder

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép go.mod và go.sum
COPY go.mod go.sum ./

# Tải các dependency
RUN go mod download

# Sao chép mã nguồn
COPY . .

# Biên dịch ứng dụng
RUN go build -o main .

# Bước 2: Tạo image nhẹ hơn để chạy ứng dụng
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main .

EXPOSE 8080

CMD ["./main"]