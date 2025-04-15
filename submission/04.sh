# Create a CLTV script with a timestamp of 1495584032 and public key below:
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
timestamp=1495584032

# Get the hex of timestamp
hextimestamp=$(printf '%08x\n' $timestamp | sed 's/^\(00\)*//')

# Get the little endian format of the hex
lehex=$(echo "$hextimestamp" | sed 's/../& /g' | awk '{for(i=NF;i>0;i--) printf "%s", $i; print ""}')

# Get pubkey
pubkeyhash=$(echo $publicKey | xxd -r -p | openssl sha256 -binary | openssl rmd160 | cut -d' ' -f2)

# Get serialized script
# Script format : OP_PUSHDATA 4bytes <TIMESTAMP> OP_CHECKLOCKTIMEVERIFY OP_DROP OP_DUP OP_HASH160 OP_PUSHDATA 20bytes <PUBKEY_HASH> OP_EQUALVERIFY OP_CHECKSIG 
serializedScript="04"$lehex"b17576a914"$pubkeyhash"88ac"

# Echo CLTV Script
echo $serializedScript
