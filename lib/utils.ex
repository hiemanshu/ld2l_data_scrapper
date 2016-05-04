defmodule Utils do

  def fetch_url(url) do
    HTTPoison.get!(url)
  end
  
end
