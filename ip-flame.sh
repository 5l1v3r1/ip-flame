#!/bin/bash
# create whitelist (CSV) from whitelist.txt:
# using AWK and SED because QAWK programming is about as ugly as Perl with sigils.
log=$(egrep '^web-log' config-ip-flame.txt|sed -re 's/[^=]+=//')
printf "[ + ] WWW log location: $log\n"
path="$(egrep '^web-path' config-ip-flame.txt|sed -re 's/[^=]+=//')flamed-ips.html"
printf "[ + ] Using web-host path: $path\n"
whitelist=$(awk -vORS='' 'BEGIN {i=0}{if($1 ~ /^[0-9]/) a[$i]=$1 }END{for(j in a){print j"|"}}' whitelist.txt|sed -re 's/\|$//')
printf "[ + ] Generated IP white list: $whitelist\n"
offlines=$(egrep '^offending-lines' config-ip-flame.txt|sed -re 's/[^=]+=//')
printf "[ + ] Matching offending lines: $offlines\n"
# dump in top of HTML page, this initiates and overwrites:
cat templates/top.html > flamed-ips.html
shodan="<a title='Search Shodan for devices hosted by {}' href='https://www.shodan.io/search?query="
shodan2="' target='_blank'>Shodan.io Data</a>"
spamcop="<a title='SpamCop.net - report {} for Spam violation' target='_blank' href='https://www.spamcop.net/w3m?action=checkblock&ip="
spamcop2="'>SpamCop.net Data</a>"
infobyip="<a title='Detailed information for {}' href='http://www.infobyip.com/ip-"
infobyip2=".html' target='_blank'>InfoByIp.com Data</a>"
sophos="<a title='Sophos Security' href='https://www.sophos.com/en-us/threat-center/ip-lookup.aspx?ip="
sophos2="' target='_blank'>Sophos.com Data</a>"
arin="<a title='American Registry for Internet Numbers - {}' target='_blank' href='http://whois.arin.net/rest/nets;q="
arin2="?showDetails=true&showARIN=false&showNonArinTopLevelNet=false&ext=netref2'>ARIN</a>"
apnic="<a title='APNIC JSON Data for {}' target='_blank' href='https://wq.apnic.net/whois-search/query?searchtext="
apnic2="'>APNIC</a>"
# run command:
egrep "$offlines" $log | \
	awk '{print $1}'|egrep -v "($whitelist)"| \
	sort -u|xargs -I {} \
	echo -e "\t\t <tr><td>{}</td><td>$arin{}$arin2</td><td>$apnic{}$apnic2</td><td>$infobyip{}$infobyip2</td><td>$spamcop{}$spamcop2</td><td>$sophos{}$sophos2</td><td>$shodan{}$shodan2</td></tr>" >> flamed-ips.html
# dump in bottom of HTML page:
cat templates/bottom.html >> flamed-ips.html
cp flamed-ips.html $path
printf "[ + ] HTML file generation completed and stored in $path\n"
