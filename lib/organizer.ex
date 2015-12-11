require IEx
require Logger

defmodule Organizer do
  @morning 180
  @afternoon 240

  def execute(talks, number_of_tracks) do
    total_tracks = find_total_tracks(talks)
    IO.puts "Total of tracks: #{total_tracks}"
    IO.puts "Number of tracks: #{number_of_tracks}"
    for _ <- 1..number_of_tracks do
      find_tracks(@morning, talks)
    end
  end

  defp find_tracks(time, talks) do
   # Logger.info "talks: #{talks}"
    minutes = 0
    for %{talk: talk, duration: duration} <- talks do
IO.puts "min: #{minutes}"
      tmp = minutes + duration
      if tmp > time, do: :exit
      minutes = minutes + duration

      IO.puts "talk: #{talk} - Duration: #{duration} - Time: #{time}"
    end
  end

  defp find_session(%{talk: talk, duration: duration}, time) do
    IO.puts "talk: #{talk} - Duration: #{duration} - Time: #{time}"
    minutes = 0
    tmp = minutes + duration
    return if tmp > time

    { talk, minutes } = { duration, tmp }
  end

  defp test(%{duration: duration, talk: talk}) do
    available_time = @morning
    if duration < available_time do
      IO.puts "talk: #{talk} - Duration: #{duration}"
      available_time = available_time - duration
    end
  end

  defp find_total_tracks(talks) do
    total_time = Enum.reduce(talks, 0, fn (%{talk: _, duration: duration}, acc) -> duration + acc end)
    round Float.ceil(total_time / (@morning + @afternoon))
  end
end
