# ip-flame
<img src="https://weaknetlabs.com/images/ip-flame-dark.png" /><br />
IP-Flame is a public wall-of-shame generator for IP addresses from Apache2 Logs. I got his idea from constantly having to blacklist IP addresses that try to add spam to an old wiki that I used to host on C programming. Why would C programmers want knock-off Louis Vuitton purses from .CN anyways? I don't know. I actually took the wiki down because of the amount of spam that was slamming it and because <a href="https://www.cloudflare.com/">CloudFlare.com</a> only allows you to block and entire country with an expensive subscription. I thought that if there was a simple, pretty way to just check the logs and have a lot of detailed output, I would be a bit happier about the spam. My own Wall-Of-Flame can be found here: <a href="http://weaknetlabs.com/flamed-ips.html">WeakNet Labs' IP Flames</a>

# Functions
The main script can be ran with: <code>./ip-flame.sh</code> after the configuration file <code>config-ip-flame.txt</code> file is updated. The script generates a static HTML report that includes dynamically generated links to <a href="https://www.shodan.io/">Shodan</a>, <a href="https://www.spamcop.net/">SpamCop</a>, <a href="http://whois.arin.net/ui">ARIN</a>, <a href="https://www.apnic.net/">APNIC</a>, <a href="http://www.infobyip.com/">InfoByIp</a>, and <a href="https://www.sophos.com/en-us.aspx">Sophos</a>, for each offending IP address found. The script does NOT make any request to these sites, just generates the links for your convenience.

# Requirements
Linux: bash, sed, awk, egrep<br />
Web Server: log file and hosting of report, Apache2

# Screenshots
<img src="https://weaknetlabs.com/images/ip-flame-screenshot0.PNG"/><br />
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

# Configuration / Install
The file config-ip-flame.txt is the configuration file.<br />
```
# IP-FLAME Configuration File
# #
# use fwd slashes at the end of path names! 
# ~Douglas - weaknetlabs@gmail.com
web-path=/path/to/wwwroot/example.com/
offending-lines=/wiki/c
web-log=/path/to/apache2/access.log
temp-path=/tmp/
```
1. Web Path is to where you would like to host your report
2. Offending Lines are lines, or requests that resemble hacking attempts (SQLi, XSS, Spam)
3. Web Log is the path to your Apache2 log file
4. Tmp Path is the temporary working path for file generation

To run the application, simply use <code>./ip-flame.sh</code>. To install IP-Flame, simply copy the executable into one of your <code>$PATH</code> directories to make it readily available. E.G. 
```
trevelyn@80211:~/repository/ip-flame$ cp ip-flame.sh /usr/local/bin
trevelyn@80211:~/repository/ip-flame$ ip-flame.sh
```

# TODO
1. mobile responsive design
2. write cron job to generate the report automatically
3. Add a total (IPs) to the top of the HTML report
