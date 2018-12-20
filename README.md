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

The MIT License (MIT)

Copyright (c) 2018 Rendered Text

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
