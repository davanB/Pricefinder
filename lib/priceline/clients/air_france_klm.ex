defmodule Pricefinder.Clients.AirFranceKLM do
  @behaviour Pricefinder.Clients.Client

  @endpoint "https://ndc-rct.airfranceklm.com/passenger/distribmgmt/001448v02/EXT"
  @content_type {"Content-Type", "text/xml"}
  @soap_action {"SOAPAction",
                "\"http://www.af-klm.com/services/passenger/ProvideAirShopping/airShopping\""}
  @api_key {"api_key", System.get_env("AIR_FRANCE_API_KEY")}

  @headers [@content_type, @soap_action, @api_key]

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
    <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"
      xmlns="http://www.iata.org/IATA/2015/00/2018.2/IATA_AirShoppingRQ">
      <S:Header/>
      <S:Body>
        <IATA_AirShoppingRQ>
            <Party>
                <Participant>
                    <Aggregator>
                        <AggregatorID>NDCABT</AggregatorID>
                        <Name>NDCABT</Name>
                    </Aggregator>
                </Participant>
                <Recipient>
                    <ORA>
                        <AirlineDesigCode>AF</AirlineDesigCode>
                    </ORA>
                </Recipient>
                <Sender>
                    <TravelAgency>
                        <AgencyID>12345675</AgencyID>
                        <IATANumber>12345675</IATANumber>
                        <Name>nom</Name>
                        <PseudoCityID>PAR</PseudoCityID>
                    </TravelAgency>
                </Sender>
            </Party>
            <PayloadAttributes>
                <CorrelationID>5</CorrelationID>
                <VersionNumber>18.2</VersionNumber>
            </PayloadAttributes>
            <Request>
                <FlightCriteria>
                    <OriginDestCriteria>
                        <DestArrivalCriteria>
                            <IATALocationCode>#{destination}</IATALocationCode>
                        </DestArrivalCriteria>
                        <OriginDepCriteria>
                            <Date>#{departure_date}</Date>
                            <IATALocationCode>#{origin}</IATALocationCode>
                        </OriginDepCriteria>
                        <PreferredCabinType>
                            <CabinTypeName>ECONOMY</CabinTypeName>
                        </PreferredCabinType>
                    </OriginDestCriteria>
                </FlightCriteria>
                <Paxs>
                    <Pax>
                        <PaxID>PAX1</PaxID>
                        <PTC>ADT</PTC>
                    </Pax>
                </Paxs>
            </Request>
        </IATA_AirShoppingRQ>
      </S:Body>
    </S:Envelope>
    """
  end
end
