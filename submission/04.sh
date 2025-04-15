# Create a CLTV script with a timestamp of 1495584032 and public key below:
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
timestamp=1495584032
hextimestamp=$(printf '%08x\n' $timestamp | sed 's/^\(00\)*//')
lehex=$(echo "$hextimestamp" | sed 's/../& /g' | awk '{for(i=NF;i>0;i--) printf "%s", $i; print ""}')
#echo $lehex
pubkeyhash=$(echo $publickey | xxd -r -p | openssl sha256 -binary | openssl rmd160 | cut -d' ' -f2)
#echo $pubkeyhash
serializedScript="04"$lehex"b17576a914"$pubkeyhash"88ac"
echo $serializedScript
