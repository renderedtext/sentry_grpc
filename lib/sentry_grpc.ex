defmodule Sentry.Grpc do

  defmacro __using__(opts) do
    quote do
      Module.register_attribute(__MODULE__, :sentry_grpc_opts, [])
      Module.put_attribute(__MODULE__, :sentry_grpc_opts, unquote(opts))

      @before_compile Sentry.Grpc
    end
  end

  defmacro __before_compile__(env) do
    mod = env.module

    opts = Module.get_attribute(mod, :sentry_grpc_opts)
    service = Keyword.get(opts, :service)

    if service do
      service.__rpc_calls__()
      |> Enum.map(fn{fname_camel_atom, _, _} ->
        fname_snake = snake_case(fname_camel_atom)

        quote do
          defoverridable [{unquote(fname_snake), 2}]

          def unquote(fname_snake)(conn, opts) do
            Sentry.Grpc.capture(fn ->
              super(conn, opts)
            end)
          end
        end
      end)
    else
      raise ":service not defined for Sentry.Grpc"
    end
  end

  def snake_case(atom) do
    atom |> Atom.to_string() |> Macro.underscore() |> String.to_atom()
  end

  def capture(fun) do
    fun.()
  rescue
    e ->
      Sentry.capture_exception(e, [
        stacktrace: __STACKTRACE__,
        extra: %{extra: []}
      ])

      Kernel.reraise(e, __STACKTRACE__)
  catch
    kind, reason ->
      stacktrace = __STACKTRACE__
      exception = Exception.normalize(kind, reason, stacktrace)

      Sentry.capture_exception(
        exception,
        stacktrace: stacktrace,
        error_type: kind
      )

      :erlang.raise(kind, reason, stacktrace)
  end

end
