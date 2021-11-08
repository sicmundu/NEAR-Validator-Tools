#!/bin/bash
echo "
+----------------------------------------------------------------------
| PING NEAR VALIDATOR INSTALL
| Version: 0.2 (08/11/2021)
+----------------------------------------------------------------------
| Copyright © 2015-2021 All rights reserved.
+----------------------------------------------------------------------
| 
+----------------------------------------------------------------------
";sleep 5

homedir=$HOME

read -p "Select NEAR Network [a - c] " network
case $network in
   a) echo "Testnet"
      NETWORK="testnet"
      ;;