defmodule Errors do
  def generic_error(filename, reason) do
    IO.puts "Error reading '#{filename}': #{reason}"
  end
end

defmodule DataParser do
  def parse(filename) do
    IO.puts "Read file"

    case File.read(filename) do
      {:ok, file} -> read_file_contents(file)
      {:error, reason} -> Errors.generic_error(filename, reason)
    end
  end

  defp read_file_contents(file_contents) do
    String.split(file_contents, "\n")
    |> Enum.filter(fn(line) -> !String.match?(line, ~r/[:#]/) end)
    |> Enum.map(&line_to_record/1)
    |> Enum.each(&IO.puts/1)
  end

  defp line_to_record(line) do
    # 2014 11 24  2223   56985   80580    0    -4.5     2.4     1.6     5.3    17.1   151.4
    #{year, month, day, time, julian_day, day_seconds, s, bx, by, bz, bt, lat, lon} = String.split(line, ~r/\ +/)
    String.split(line, ~r/\ +/)
  end

end

filename = "sample_data/ace_mag_1m.txt"

DataParser.parse(filename)

