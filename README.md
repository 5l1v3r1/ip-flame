# ip-flame
Public Wall of Shame Generator for IP Addresses from Apache2 Logs.<br />
<img src="https://weaknetlabs.com/images/ip-flame-dark.png" /><br />
I got his idea from constantly having to blacklist IP addresses that try to add spam to an old wiki that I used to host on C programming. I actually took the wiki down because of the amount of spam that was slamming it and because <a href="https://www.cloudflare.com/">CloudFlare.com</a> only allows you to block and entire country with an expensive subscription. I thought that if there was a simple, pretty way to just check the logs and have a lot of detailed output, I would be a bit happier about the spam.

# Functions
Script generates static HTML
Report includes dynamically generated links to Shodan, SpamCop, ARIN, APNIC, InfoByIp, and Sophos, each by host IP

# Requirements
Linux: bash, sed, awk, egrep<br />
Web Server: log file and hosting of report, Apache2

# Screenshots
<img src="https://weaknetlabs.com/images/ip-flame-screenshot.png"/><br />
Terminal Output:<br />
```
trevelyn@80211:~/repository/ip-flame$ ./ip-flame.sh
[ + ] WWW log location: /path/to/log/apache2/access.log
[ + ] Using web-host path: /path/to/wwwroot/example.com/flamed-ips.html
[ + ] Generated IP white list: 192.168.1.100|192.168.1.101
[ + ] Matching offending lines: /wiki/c
[ + ] HTML file generation completed and stored in /path/to/wwwroot/example.com/flamed-ips.html
trevelyn@80211:~/repository/ip-flame$
```

# Configuration
The file config-ip-flame.txt is the configuration file.<br />
```
# IP-FLAME Configuration File
# 
web-path=/path/to/wwwroot/example.com/
offending-lines=/wiki/c
web-log=/path/to/apache2/access.log
```
1. Web Path is to where you would like to host your report
2. Offending Lines are lines, or requests that resemble hacking attempts (SQLi, XSS, Spam)
3. Web Log is the path to your Apache2 log file

# TODO
1. mobile responsive design
2. write cron job to generate the report automatically
