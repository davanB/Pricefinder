defmodule Pricefinder.Clients.BritishAirways do
  @behaviour Pricefinder.Clients.Client

  @endpoint "https://test.api.ba.com/selling-distribution/AirShopping/V2"
  @client_key {"Client-Key", "czrzswga6x3gy3uutvfy9um2"}
  @content_type {"Content-Type", "application/xml"}
  @soap_action {"Soapaction", "AirShoppingV01"}

  @headers [@client_key, @content_type, @soap_action]

  def get_prices(origin, destination, departure_date) do
    body = build_body(origin, destination, departure_date)

    HTTPoison.post(@endpoint, body, @headers)
    |> case do
      {:ok, response} ->
        response.body

      {:error, _error} ->
        :client_error
    end
  end

  defp build_body(origin, destination, departure_date) do
    """
    <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
      <s:Body xmlns="http://www.iata.org/IATA/EDIST">
        <AirShoppingRQ Version="3.0"
            xmlns="http://www.iata.org/IATA/EDIST">
            <PointOfSale>
                <Location>
                    <CountryCode>DE</CountryCode>
                </Location>
            </PointOfSale>
            <Document/>
            <Party>
                <Sender>
                    <TravelAgencySender>
                        <Name>test agent</Name>
                        <IATA_Number>00002004</IATA_Number>
                        <AgencyID>test agent</AgencyID>
                    </TravelAgencySender>
                </Sender>
            </Party>
            <Travelers>
                <Traveler>
                    <AnonymousTraveler>
                        <PTC Quantity="1">ADT</PTC>
                    </AnonymousTraveler>
                </Traveler>
            </Travelers>
            <CoreQuery>
                <OriginDestinations>
                    <OriginDestination>
                        <Departure>
                            <AirportCode>#{origin}</AirportCode>
                            <Date>#{departure_date}</Date>
                        </Departure>
                        <Arrival>
                            <AirportCode>#{destination}</AirportCode>
                        </Arrival>
                    </OriginDestination>
                </OriginDestinations>
            </CoreQuery>
        </AirShoppingRQ>
      </s:Body>
    </s:Envelope>
    """
  end
end
