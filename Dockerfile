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

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép file biên dịch từ builder
COPY --from=builder /app/main .

# Mở cổng mà ứng dụng sẽ lắng nghe
EXPOSE 8080

CMD ["./main"]