defmodule Ld2lDataScrapper do
  alias Parsers.Dotabuff

  def main(_) do
    HTTPoison.start

    IO.puts Dotabuff.get_players
  end

end
