defmodule Report do
  use Timex

  def publish([], _, _), do: []
  def publish([ %{talk: talk, duration: duration} | tail], initial_hour, time \\ 0) do
    print(talk, initial_hour, duration, time)
    publish(tail, initial_hour, time + duration)
  end

  defp print(talk, initial_hour, duration, acc_time) do
    {:ok, time} = get_data_from(initial_hour, acc_time)
    IO.puts "#{time} - #{talk} - #{duration} min"
  end
  defp print(_talk, _duration, _, _), do: []

  defp get_data_from(initial_hour, duration) do
    Date.from({{2015, 1, 1}, {initial_hour, 0, 0}}, :local)
    |> Date.add(Time.to_timestamp(duration, :mins))
    |> DateFormat.format("%I:%M %p", :strftime)
  end
end
