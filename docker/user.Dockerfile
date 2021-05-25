FROM golang AS builder
ENV GO111MODULES=on

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .
RUN make build-user

# runner image
FROM scratch as runner

COPY --from=builder /app/bin/user /app/bin/

EXPOSE 3000
ENTRYPOINT ["/app/bin/user"]