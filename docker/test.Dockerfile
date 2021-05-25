FROM golang AS builder
ENV GO111MODULES=on

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .
RUN make build-test

# runner image
FROM scratch as runner

COPY --from=builder /app/bin/test /app/bin/

EXPOSE 3000
ENTRYPOINT ["/app/bin/test"]