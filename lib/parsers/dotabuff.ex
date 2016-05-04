defmodule Parsers.Dotabuff do
  import Utils
  import SweetXml

  def get_players do
    dotabuff_page = Application.get_env(:ld2l_data_scrapper, :dotabuff_page)
    %{body: players_data} = fetch_url(dotabuff_page)
    IO.puts parse_data(players_data)
  end

  def parse_data(data) do
    data
    |> xpath(~x"//section[@class='most-successful-players']//table/tbody/tr"l)
    |> Enum.map(fn(player_info) ->
      player_id = player_info |> xpath(~x".//td[@class='player-name-small']/a/@href"s)
      %{
        name: player_info |> xpath(~x".//td[@class='player-name-small']/a/text()"s),
        team_name: player_info |> xpath(~x".//td[@class='player-name-small']/small/text()"s),
        player_id: List.last(String.split(player_id, "/")),
        wins: player_info |> xpath(~x".//td[contains(@class, 'r-group-1')]//span[@class='wins']/text()"i),
        losses: player_info |> xpath(~x".//td[contains(@class, 'r-group-1')]//span[@class='losses']/text()"i),
        kda: player_info |> xpath(~x".//td[contains(@class, 'r-group-2') and contains(@class, 'cell-divider')]/text()"f)
      }
    end)
  end

end
