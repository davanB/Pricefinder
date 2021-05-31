ExUnit.start()

Mox.defmock(Pricefinder.Clients.MockAirFranceKLM, for: Pricefinder.Clients.Client)
Mox.defmock(Pricefinder.Clients.MockBritishAirways, for: Pricefinder.Clients.Client)

import TestUtils
