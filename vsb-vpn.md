
Create the interface if it doesn't exist

```
sudo ip tuntap add vpn0 mode tun user fpeterek
```

Connect to the VPN

```
openconnect --protocol=anyconnect --useragent=AnyConnect --interface=vpn0 --gnutls-priority="NORMAL:-VERS-ALL:+VERS-TLS1.2:+RSA:+AES-128-CBC:+SHA1" --script='sudo -E /etc/vpnc/vpnc-script' --authgroup="VSB full tunnel, local network" --server=vpn.vsb.cz
```

Pre-2FA
```
nmcli conn add connection.id vsb connection.type vpn vpn.service-type openconnect vpn.data protocol=anyconnect,gateway=vpn.vsb.cz,cookie-flags=2,cert-pass-flags=2,gateway-flags=2,gwcert-flags=2,cookie-flags=2
```
