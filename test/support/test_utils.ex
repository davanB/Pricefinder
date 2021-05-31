defmodule TestUtils do
  alias Pricefinder.Airlines.{AirFranceKLM, BritishAirways}

  @british_airways [:BA, BritishAirways]
  @air_france_klm [:AFKL, AirFranceKLM]

  def read_mock_response(:no_data) do
    File.read!("test/support/fixtures/no_data_response.xml")
  end

  def read_mock_response(airline) when airline in @british_airways do
    File.read!("test/support/fixtures/ba_response_sample.xml")
  end

  def read_mock_response(airline) when airline in @air_france_klm do
    File.read!("test/support/fixtures/afklm_response_sample.xml")
  end
end
