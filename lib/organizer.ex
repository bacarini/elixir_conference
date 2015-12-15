require IEx
require Logger

defmodule Organizer do
  @morning 180
  @afternoon 240

  def execute(talks, number_of_tracks) do
    for index <- 1..number_of_tracks do
      IO.puts "Track: #{index}"
      new_talks = find_track(talks, @morning)
      IO.puts "00:00:00 - Lunch"
      find_track(talks -- new_talks, @afternoon)
      IO.puts "00:00:00 - Networking Evening"
    end
  end

  defp find_track([], _time), do: []
  defp find_track(_, time) when time <= 0, do: []
  defp find_track([ head = %{talk: talk, duration: duration} | tail], time) when time > 0 do
    IO.puts "00:00:00 - #{talk} - Duration: #{duration}"
    [ head | find_track(tail, time - duration) ]
  end
end
