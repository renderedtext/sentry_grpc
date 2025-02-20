# Sentry.Grpc

Collects exceptions and errors from GRPC servers.

## Installation

```elixir
def deps do
  [
    {:sentry_grpc, github: "renderedtext/sentry_grpc"}
  ]
end
```

## Setup

Inject a `use Sentry.Grpc, service: <service>` into your Grpc services to
capture errors and exceptions.

Example for HelloWorld:

``` elixir
defmodule Helloworld.Greeter.Server do
  use GRPC.Server, service: Helloworld.Greeter.Service
  use Sentry.Grpc, service: Helloworld.Greeter.Service # < --- this line

  @spec say_hello(Helloworld.HelloRequest.t(), GRPC.Server.Stream.t()) ::Helloworld.HelloReply.t()
  def say_hello(request, _stream) do
    Helloworld.HelloReply.new(message: "Hello #{request.name}")
  end
end
```

## License

This software is licensed under [the Apache 2.0 license](LICENSE).