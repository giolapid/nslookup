##############################################################################
#
# Author: Gio Lapid
# 
# reverseDns.ps1
# 
# Purpose: Takes in a list that is on a text file and does a 
#          reverse DNS check on the websites and returns the 
#          IP addresses on an out.txt file. 
#
#          You can also set a target IP ($target) and it will compare it
#          to each reverse lookups and will return the hosts with that
#          IP address.
#
# Usage: Change $target to the target IP address and change $Servers to the 
#        path of where the list is. Also change the first line of the MAIN function
#        to the desired folder of your out file.
#
#############################################################################

#Global Variables Change to them according to your needs
$target = "69.172.201.208"
$Servers = Get-Content C:\Users\glapi02\Desktop\reverseDNS\check.txt

#Main-Function
function main {
	#CHANGE THIS 
    New-Item C:\Users\glapi02\Desktop\reverseDNS\out.txt  -type file -force
	reverse-dns
}

#Calls the reverse DNS. Need Nested Loops are used since there may be multiple addresses per host

function reverse-dns{
	foreach ($server in $servers) {
		$addresses = [System.Net.Dns]::GetHostAddresses($server)
		foreach($address in $addresses){
            #OUTPUTS to out.txt
			"{0} is {1}"-f $server, $address.IPAddressToString | Add-Content 'out.txt'
		    
		    #Checks if target is the current address in the loop
		    if ($target.equals($address.IPAddressToString)){
		    	  "$server is the target"
		    }    
		}
	}
}

main