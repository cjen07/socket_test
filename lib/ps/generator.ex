defmodule Ps.Generator do
  use GenServer

  data = Enum.reduce(1..2_000_000, "", fn _, acc -> acc <> "a" end)

  def start_link() do
    GenServer.start_link(__MODULE__, {1, load()}, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def terminate(reason, state) do
    IO.inspect reason
    IO.inspect state
    :ok
  end

  def generate() do
    GenServer.cast(__MODULE__, :generate)
  end

  def stop() do
    GenServer.cast(__MODULE__, :stop)
  end

  def handle_info(:timeout, {n, d}) do
    case n do
      -1 -> {:noreply, {0, d}, :hibernate}
      _ ->
        # {time, _} = :timer.tc(fn ->
        #   PsWeb.Endpoint.broadcast! "room:lobby", "new_msg", %{ body: n, data: d }
        # end)
        # IO.inspect time
        t = DateTime.utc_now |> DateTime.to_unix(:millisecond)
        PsWeb.Endpoint.broadcast! "room:lobby", "new_msg", %{ body: n, data: d, time: t}
        # IO.inspect n
        {:noreply, {n + 1, d}, 40}
    end
  end

  def handle_cast(:generate, state) do
    {:noreply, state, 0}
  end

  def handle_cast(:stop, {_n, d}) do
    {:noreply, {-1, d}, 0}
  end

  def load(), do: unquote(Macro.escape(data))
end