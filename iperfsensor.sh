
outputdownload=$(iperf3 -c 127.0.0.1 -p 5200 -P 10 -4 -R)
outputupload=$(iperf3 -c 127.0.0.1 -p 5200 -P 10 -4) 
error=$?

resultsdownload=$(echo -e "$outputdownload" | tail -n3)
resultsupload=$(echo -e "$outputupload" | tail -n3)

echo $resultsdownload
echo $resultsupload
downloadtransferred=$(echo $resultsdownload | awk '{printf "%.0f", $4 }')
echo $downloadtransferred
downloadspeed=$(  echo $resultsdownload | awk '{printf "%.0f", $6 *125000}')
echo $downloadspeed



uploadtransferred=$(echo $resultsupload | awk '{printf "%.0f", $4 }')
echo $uploadtransferred
uploadspeed=$(  echo $resultsupload | awk '{printf "%.0f", $6 *125000}')
echo $uploadspeed
echo "<prtg>"
echo "  <result>"
echo "    <channel>Download</channel>"
echo "    <value>$downloadspeed</value>"
echo "    <float>1</float>"
echo "    <unit>SpeedNet</unit>"
echo "    <volumeSize>MegaBit</volumeSize>"
echo "    <decimalMode>2</decimalMode>"
echo "    <showChart>1</showChart>"
echo "    <limitMinWarning>100</limitMinWarning>"
echo "    <limitWarningMsg>Downloads are below 100 Mbit/s</limitWarningMsg>"
echo "  </result>"
echo "  <result>"
echo "    <channel>Upload</channel>"
echo "    <value>$uploadspeed</value>"
echo "    <float>1</float>"
echo "    <unit>SpeedNet</unit>"
echo "    <volumeSize>MegaBit</volumeSize>"
echo "    <decimalMode>2</decimalMode>"
echo "    <showChart>1</showChart>"
echo "    <limitMinWarning>50</limitMinWarning>"
echo "    <limitWarningMsg>Uploads are below 50 Mbit/s</limitWarningMsg>"
echo "  </result>"
echo "  <result>"
echo "    <channel>Transferred Download</channel>"
echo "    <value>$downloadtransferred</value>"
echo "    <float>1</float>"
#echo "    <unit>BytesBandwidth</unit>"
echo "    <unit>Custom</unit>"
echo "    <customUnit>MB</customUnit>"
#echo "    <volumeSize>MegaByte</volumeSize>"
echo "    <decimalMode>1</decimalMode>"
echo "    <showChart>1</showChart>"
echo "  </result>"
echo "  <result>"
echo "    <channel>Transferred Upload</channel>"
echo "    <value>$uploadtransferred</value>"
echo "    <float>1</float>"
#echo "    <unit>BytesBandwidth</unit>"
echo "    <unit>Custom</unit>"
echo "    <customUnit>MB</customUnit>"
#echo "    <volumeSize>MegaByte</volumeSize>"
echo "    <decimalMode>1</decimalMode>"
echo "    <showChart>1</showChart>"
echo "  </result>"

echo "  <text>"
if [ $error -ne 0 ]; then
  echo -e "$output" | sed -e 's~&~\&amp;~g' -e 's~<~\&lt;~g' -e 's~>~\&gt;~g' # | sed -e ':a;N;$!ba;s~\n~\&#xD;\&#xA;\n~g'
fi
echo "  </text>"
echo "  <error>$error</error>"
echo "</prtg>"
