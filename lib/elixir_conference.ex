defmodule ElixirConference do
  def main(file_name) do
   File.open(file_name)
   |> process_file
  end

  defp process_file({:ok, file}) do
    file
    |> Parser.parse
    |> Organizer.execute
  end

  defp process_file({:error, reason}, _), do: IO.puts "ERROR: #{:file.format_error(reason)}"
end
