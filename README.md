# lprng-Server
Setup Print Server via LPRng for Oracle WMS 
<br />
<img src="https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white" />
<img src="https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=Oracle&logoColor=white" /> 
<img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" />

## Introduction
On Oracle WMS or Logfire prefered to make print server to sure print the labels. Unfortunately, On Oracle WMS or Logfire only use port "9100" and "515". In table below, it is showing the diffrent between them and on this script you will install [LPRng](https://lprng.sourceforge.net/).

| Port | Explanation                                                                                                                                         |
|------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| 9100 | The default configuration of some HP Printers and Zebra Sender enables the Remote Firmware Update (RFU) setting. Usually deals with Samba programs. |
| 515  | Printing services, listening for incoming connections. Usually, LPR/LPD (Line Printer Remote/Daemon) use this Port.                                 |

## Requirment

* Debian 12 Distro
* APT Package Manager (Up-to-Date).
* Internet
* Static IP from ISP. 
