# Loading required Hardending configurations
sysctl -p
service suricata start
service ntp start
# Running Lynis Scan
apt-get update
apt-get install --no-install-recommends git make wget htmldoc libxml-writer-perl libarchive-zip-perl libjson-perl jq -y
## Lynis Report Converter
cd /tmp
wget http://search.cpan.org/CPAN/authors/id/M/MF/MFRANKL/HTML-HTMLDoc-0.10.tar.gz
tar xvf HTML-HTMLDoc-0.10.tar.gz
cd HTML-HTMLDoc-0.10 ; perl Makefile.PL ; make && make install ; popd
wget http://search.cpan.org/CPAN/authors/id/J/JM/JMCNAMARA/Excel-Writer-XLSX-0.95.tar.gz
tar xvf Excel-Writer-XLSX-0.95.tar.gz
cd Excel-Writer-XLSX-0.95; perl Makefile.PL ; make && make install ; popd ; popd
cd /
git clone https://github.com/d4t4king/lynis-report-converter.git
git clone -b 3.0.6 https://github.com/CISOfy/lynis.git
cd /lynis ; ./lynis audit system
# Convert lynis .dat report into json format
/lynis-report-converter/lynis-report-converter.pl -j -o /var/log/lynis-report.json -i /var/log/lynis-report.dat
cat /var/log/lynis-report.json | jq -r ".hardening_index" > /tmp/hardening_index
cat /tmp/hardening_index
apt-get purge git  -y
rm -rf /var/lib/apt/lists/*
