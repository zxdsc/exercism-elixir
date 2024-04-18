defmodule TakeANumber do
  def start() do
    spawn(fn -> with_state(0) end)
  end

  defp with_state(st) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, st)
        with_state(st)

      {:take_a_number, sender_pid} ->
        send(sender_pid, st + 1)
        with_state(st + 1)

      :stop ->
        nil

      _ ->
        with_state(st)
    end
  end
end
