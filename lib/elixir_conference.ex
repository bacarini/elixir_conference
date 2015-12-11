defmodule ElixirConference do
  def main(file_name, number_of_tracks \\ 2) do
   File.open(file_name)
   |> process_file(number_of_tracks)
  end

  defp process_file({:ok, file}, number_of_tracks) do
    file
    |> Parser.parse
    |> Organizer.execute(number_of_tracks)
  end

  defp process_file({:error, reason}, _), do: IO.puts "ERROR: #{:file.format_error(reason)}"
end
