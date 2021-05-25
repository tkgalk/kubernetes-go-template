package main

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"net/http"
)

func main() {
	e := echo.New()
	e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
		Format: "method=${method}, uri=${uri}, status=${status}\n",
	}))

	e.GET("/user/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, user!")
	})

	e.Logger.Fatal(e.Start(":3000"))
}
