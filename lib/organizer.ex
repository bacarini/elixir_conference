require IEx

defmodule Organizer do
  @morning 180
  @afternoon 240

  def execute(talks) do
    total_tracks = find_total_tracks(talks)
    IO.puts "Total of tracks: #{total_tracks}"
    Enum.map(talks, &test(&1))
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
