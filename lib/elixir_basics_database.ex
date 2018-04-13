defmodule ElixirBasics.Database do
  require Record
  use GenServer

  Record.defrecord :state, table: nil

  # api
  def start_link() do
    GenServer.start_link(__MODULE__, [], [{:name, __MODULE__}])
  end

  def first() do
    GenServer.call(__MODULE__, :first)
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def put(value) do
    GenServer.cast(__MODULE__, {:put, value})
  end

  # callbacks
  def init(_) do
    {:ok, state(table: :ets.new(:elixir_basics_table, [:set, :protected]))}

  end

  def handle_call(:first, _from, state(table: table)=s) do
    result = first_key(table)
             |> (fn(key) -> lookup(table, key) end).()
    {:reply, result, s}
  end

  def handle_call({:get, key}, _from, state(table: table)=s) do
    result = lookup(table, key)
    {:reply, result, s}
  end

  def handle_cast({:put, value}, state(table: table)=s) do
    insert(table, value)
    {:noreply, s}
  end

  # business logic
  def first_key(table) do
    :ets.first(table)
  end

  def lookup(table, key) do
    case :ets.lookup(table, key) do
      []              -> {:error, :not_found};
      [{^key, value}] -> {:ok, value}
    end
  end

  def insert(table, value) do
    key = UUID.uuid1()
    :true = :ets.insert(table, {key, value})
  end

end
