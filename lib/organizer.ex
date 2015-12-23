require IEx
require Logger

defmodule Organizer do
  @morning 180
  @afternoon 240

  def execute(talks) do
    IO.puts "Track 1:"
    new_talks = find_track(talks)
    IO.puts "Track 2:"
    find_track(talks -- new_talks)
  end

  defp find_session([], _time), do: []
  defp find_session(_, time) when time < 0, do: []
  defp find_session([ %{talk: _talk, duration: duration} | tail], time) when (time - duration) < 0 do
    find_session(tail, time)
  end
  defp find_session([ head = %{talk: _talk, duration: duration} | tail], time) when (time - duration) >= 0 do
    [ head | find_session(tail, time - duration) ]
  end

  defp find_track(talks) do
    talks_morning = find_session(talks, @morning)

    Report.publish(talks_morning, 9)
    IO.puts "12:00 PM - Lunch"
    talks_afternoon = find_session(talks -- talks_morning, @afternoon)

    Report.publish(talks_afternoon, 13)
    IO.puts "05:00 PM - Networking Event"
    IO.puts "----------------------"
    talks_morning ++ talks_afternoon
  end
end
