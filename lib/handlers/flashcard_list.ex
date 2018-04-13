defmodule ElixirBasics.Handlers.FlashCardList do

  # callbacks
  def init(req, state) do
    {:cowboy_rest, req, state}
  end

  def allowed_methods(req, state) do
    {["POST"], req, state}
  end

  def content_types_accepted(req, state) do
    {[{{"application", "json", []}, :put_handler}], req, state}
  end

  # handlers
  def put_handler(req, state) do
    {:ok, data, req} = :cowboy_req.read_body(req)
    {:ok, flashcard} = Poison.decode(data, as: %ElixirBasics.Models.Flashcard{})
    :io.format("Received: ~p~n", [flashcard])

    ElixirBasics.Database.put(flashcard)
    {:true, req, state}
  end
end
