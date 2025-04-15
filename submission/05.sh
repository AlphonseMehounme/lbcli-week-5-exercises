# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# publicKey
publickey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

# Block height or time
BLOCKHEIGHT=150
#echo $BLOCKHEIGHT

# Hex of blockheight
hexBH=$(printf '%08x\n' $BLOCKHEIGHT | sed 's/^\(00\)*//')
hexfirst=$(echo $hexBH | cut -c1)
[[ 0x$hexfirst -gt 0x7 ]] && hexBH="00"$hexBH
#echo $hexBH

# Get the little endian format of the hex
lehexBH=$(echo "$hexBH" | sed 's/../& /g' | awk '{for(i=NF;i>0;i--) printf "%s", $i; print ""}')
#echo $lehexBH

# Blockheight size
SizeBH=$(echo -n $lehexBH | wc -c | awk '{print $1/2}')
#echo $SizeBH

# Get pubkey
pubkeyhash=$(echo $publickey | xxd -r -p | openssl sha256 -binary | openssl rmd160 | cut -d' ' -f2)
#echo $pubkeyhash

# Script format : OP_PUSHDATA <SIZE> <time> OP_CHECKSEQUENCEVERIFY OP_DROP OP_DUP OP_HASH160 OP_PUSHDATA 20bytes <pubKeyHash> OP_EQUALVERIFY OP_CHECKSIG
CSV_Script="0$SizeBH"$lehexBH"b27576a914"$pubkeyhash"88ac"
echo $CSV_Script
