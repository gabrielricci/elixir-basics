defmodule ElixirBasics do
  @moduledoc """
  Documentation for ElixirBasics.
  """

  def start(_type, _args) do
    dispatch_config = build_dispatch_config()
    {:ok, _} = :cowboy.start_clear(:my_http_listener,
                                   [{:port, 8080}],
                                   %{:env => %{:dispatch => dispatch_config}})

    ElixirBasics.Supervisor.start_link()
  end

  def build_dispatch_config do
    :cowboy_router.compile(
      [{:_, [{"/flash-cards", ElixirBasics.Handlers.FlashCardList, []},
             {"/flash-cards/:id", ElixirBasics.Handlers.FlashCard, []}]}]
    )
  end
end
