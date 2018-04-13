defmodule ElixirBasics.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  # callbacks
  def init(_args) do
    children = [%{id: Database, start: {ElixirBasics.Database, :start_link, []}}]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
