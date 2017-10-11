defmodule Ps.Generator do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, 1, name: __MODULE__)
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

  def handle_info(:timeout, state) do
    case state do
      -1 -> {:noreply, 0, :hibernate}
      _ ->
        PsWeb.Endpoint.broadcast! "room:lobby", "new_msg", %{ body: state }
        {:noreply, state + 1, 0}
    end
  end

  def handle_cast(:generate, state) do
    {:noreply, state, 0}
  end

  def handle_cast(:stop, _state) do
    {:noreply, -1, 0}
  end
end