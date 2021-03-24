@       IN      SOA     test.example.com.       admin.test.example.com. (
100             ; Serial
604800          ; Refresh
86400           ; Retry
2419200         ; Expire
604800 )        ; Negative Cache TTL

                IN      NS      ns1.test.example.com.

ns1             IN      A       192.168.56.101
site1           IN      A       192.168.56.101


