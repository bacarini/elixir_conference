defmodule Parser do
  def parse(file) do
    file
    |> IO.stream(:line)
    |> Enum.map(&Enum.into(resolve(&1), Map.new))
    |> Enum.map(&convert_duration_to_integer(&1))
  end

  defp resolve(line) do
    Regex.named_captures(~r/(?<talk>.*?)\s+(?<duration>(lightning|\d+))/, line)
  end

  defp convert_duration_to_integer(%{"duration"=> "lightning", "talk"=> talk }) do
    convert_duration_to_integer(%{"duration"=> "5", "talk"=> talk })
  end

  defp convert_duration_to_integer(%{"duration"=> duration, "talk"=> talk }) do
    %{ duration: String.to_integer(duration), talk: talk }
  end
end
