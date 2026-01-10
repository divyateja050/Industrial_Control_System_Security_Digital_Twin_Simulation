# ICS/SCADA Security Project - Substation Digital Twin & Intrusion Detection

## 📌 Project Overview
This project involves the development of a functional **Digital Twin** of an electrical substation to analyze vulnerabilities in the **Modbus TCP** protocol. The project demonstrates an end-to-end security lifecycle: from programming industrial logic to executing a remote command injection attack and implementing network-level defenses.


## 🛠️ Tech Stack
* **PLC Runtime:** OpenPLC (IEC 61131-3)
* **HMI/SCADA:** ScadaBR
* **Traffic Analysis:** Wireshark
* **Penetration Testing:** Kali Linux & Python (pyModbusTCP)

## ⚡ Industrial Logic
The substation logic features:
* **Isolator Interlock:** Prevents breaker operation unless safety isolators are closed.
* **Latching Circuit:** A seal-in contact ensures the breaker remains closed after a remote start signal.
* **Variable Mapping:**
    * `%QX0.0`: Breaker Coil (Coil Status)
    * `%QX0.1`: Isolator Status
    * `%QX0.3`: Manual Emergency Stop

## 🛡️ Cybersecurity Research
### 1. Vulnerability Assessment
Using Wireshark, I identified that Modbus TCP lacks encryption, allowing an attacker to sniff "Write Single Coil" (Function Code 5) packets in plain text.

### 2. Exploitation (Command Injection)
I authored a Python script to bypass the HMI and inject unauthorized Modbus packets directly into the PLC, successfully forcing an "Emergency Trip" of the breaker.

### 3. Mitigation & Detection
* **Firewall Hardening:** Implemented `iptables` rules to whitelist only the authorized SCADA IP, successfully neutralizing the Python exploit.
* **IDS Implementation:** Developed a custom Wireshark IDS filter to detect unauthorized Modbus write requests from non-master IPs:
    `modbus.func_code == 5 && ip.src != [SCADA_IP] && tcp.dstport == 502`

## 🚀 How to Run
1. Load `SubstationPLC.st` into OpenPLC Runtime.
2. Configure ScadaBR Data Source with the provided Modbus offsets.
3. Run `attack.py` from a separate VM to test vulnerability.
4. Apply `iptables` rules on the PLC to verify mitigation.
