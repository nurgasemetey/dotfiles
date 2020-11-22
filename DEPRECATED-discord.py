
from pypresence import Presence # The simple rich presence client in pypresence
import time

client_id = "747450720613171293"  # Put your Client ID in here
RPC = Presence(client_id)  # Initialize the Presence client

RPC.connect() # Start the handshake loop
test= RPC.update(state="Rich Presence using pypresence!") # Updates our presence
print(test)
