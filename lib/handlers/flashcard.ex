defmodule ElixirBasics.Handlers.FlashCard do

  # callbacks
  def init(req, state) do
    {:cowboy_rest, req, state}
  end

  def allowed_methods(req, state) do
    {["GET"], req, state}
  end

  def content_types_provided(req, state) do
    {[{"application/json", :get_handler}], req, state}
  end

  # handlers
  def get_handler(req, state) do
    id = :cowboy_req.binding(:id, req)

    {:ok, flashcard} = case id do
      "first" -> ElixirBasics.Database.first();
      _       -> ElixirBasics.Database.get(id)
    end

    {Poison.encode!(flashcard), req, state}
  end
end
