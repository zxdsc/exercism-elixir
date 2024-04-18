# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start(fn -> %{plots: [], next_id: 1} end, opts)

  def list_registrations(pid) do
    Agent.get(pid, fn l -> l[:plots] end)
  end

  def register(pid, register_to) do
    id =
      Agent.get_and_update(pid, fn state ->
        {state.next_id, Map.update(state, :next_id, 0, fn v -> v + 1 end)}
      end)

    plot = %Plot{plot_id: id, registered_to: register_to}

    Agent.update(pid, fn state ->
      Map.update(state, :plots, [], fn plots -> [plot | plots] end)
    end)

    plot
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      Map.update(state, :plots, [], fn plots ->
        Enum.filter(plots, fn plot -> plot.plot_id != plot_id end)
      end)
    end)
  end

  def get_registration(pid, plot_id) do
    found =
      Agent.get(pid, fn state ->
        state.plots
        |> Enum.find(nil, fn plot -> plot.plot_id == plot_id end)
      end)

    case found do
      nil -> {:not_found, "plot is unregistered"}
      _ -> found
    end
  end
end
