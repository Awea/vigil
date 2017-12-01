defmodule Vigil do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Exredis, []),
    ]

    opts = [strategy: :one_for_one, name: Vigil.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
