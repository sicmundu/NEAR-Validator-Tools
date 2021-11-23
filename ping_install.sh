#!/bin/bash
echo "
+----------------------------------------------------------------------
| PING NEAR VALIDATOR INSTALL
| Version: 0.8(23/11/2021)
+----------------------------------------------------------------------
| Copyright © 2021 All rights reserved.
+----------------------------------------------------------------------
|
+----------------------------------------------------------------------
";sleep 1

homedir=$HOME

networkSelect()
{
  PS3="Enter a number: "
  options=("Testnet" "Guildnet" "Mainnet")
  select opt in "${options[@]}"
  do
    case $opt in
       "Testnet")
         NETWORK="testnet"
         POOL='.pool.f863973.m0'
         ACCOUNT='.testnet'
         CONTRACT = 'manager_v1.cron.testnet'
         break
         ;;
       "Guildnet")
         NETWORK="guildnet"
         POOL='.stake.guildnet'
         CONTRACT = 'manager_v1.croncat.guildnet'
         ACCOUNT='.guildnet'
         break
         ;;
       "Mainnet")
         NETWORK="mainnet"
         POOL='.poolv1.near'
         ACCOUNT='.near'
         CONTRACT = 'manager_v1.croncat.near'
         break
         ;;

    esac
  done

}

cronTab()
{
rm $homedir/ping.sh
cat >> $homedir/ping.sh << EOF
#!/bin/bash
export NEAR_ENV=$NETWORK
near call $p$POOL ping '{}' --accountId $a$ACCOUNT --gas=300000000000000
EOF
  echo 'Creating Ping.sh ...'
  sleep 0.3
  chmod +x $homedir/ping.sh
  echo 'Adding to crontab..'
  sleep 0.3
  # Adding to Cron
  crontab -l > mycron
  # echo new cron into cron file
  echo "0 */1 * * * $homedir/ping.sh >> $homedir/near.log 2>&1" >> mycron
  # install new cron file
  crontab mycron
  rm -f mycron
}

cronSelect()
{
  PS3="Enter a number: "
  options=("CronCat" "Crontab")
  select opt in "${options[@]}"
  do
    case $opt in
       "CronCat")
        echo 'Creating Croncat task..'
        sleep 0.2
        near call $CONTRACT create_task '{"contract_id": "'$p$POOL'","function_id": "ping","cadence": "0 0 * * * *","recurring": true,"deposit": "0","gas": 9000000000000}' --accountId $a$ACCOUNT --amount 5
        echo -e "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n @@@@@@@@(((((@@@@@(((((((((((((((((((((((((((((((((((((((((((((@@@@@(((((&&#((@@\n @@@@@@&@((((((((((@@%(((((((((((((((((((((((((((((((((((((((@@@((((((((((&&#((@@\n @@@@@@@@&&@@@@@     @@@@@%(((((((((((((((((((((((((((((&&&@@(((((@@@@@&&&&&#((@@\n @@@@@@&&%%@@@@@@@@     ..@@@(((((((((((((((((((((((((&&((((((((@@@@@@@%%%&&#((@@\n @@@@@&&&..&&&@@@@@@@     ...@@@@@@@@@@@@@@@@@@@@@@@@@(((((((@@@@@@@@@@(((&&#((@@\n @@@@@&&&  ###&&@@@@@&&&       ........((((((((((((((((((((@@@@@@@@@@%%(((&&#((@@\n @@@@@&&&     ..,,,//###,.             ((((((((((((((((((((%%###((((((((((%%#((@@\n @@@@@&&&            ...               (((((((((((((((((((((((((((((((((((%%#((@@\n @@@@@&&&                              (((((((((((((((((((((((((((((((((((%%#((@@\n @@@@@&&&                                (((((((((((((((((((((((((((((((((%%#((@@\n @@@@@&&&                                (((((((((((((((((((((((((((((((((##(((@@\n @@@@@&&&                                ((((((((((((((((((((((((((((((((((((((@@\n @@@@&///                                (((((((((((((((((((((((((((((((((((&&&@@\n @@@@&,,,                                   ((((((((((((((((((((((((((((((((&&&@@\n @@@@&                                      ((((((((((((((((((((((((((((((((&%%@@\n @@@&&               @@@@@@@@,,...          ((((((((((@@@@@@@(((((((((((((((&%%@@\n @@@&&             @@        @@...            (((((@@@(((((((@@@((((((((((((%%%@@\n &&&((                                        (((((((((((((((((((((((((((((((((@@\n &&&..                              @@@@@@@@@@   ((((((((((((((((((((((((((((((&&\n &&&..                              ...@@@@@..     ((((((((((((((((((((((((((((@@\n &&&..                                 ,,,,,            (((((((((((((((((((((((@@\n &&&,,...                              .....               ((((((((((((((((((((@@\n &&&&&,,,                         .....@@@@@.....               ((((((((((((&&&@@\n @@@&&@@@..             //%%%.....@@@@@&&&&&@@@@@.....%%///          (((((&&#%%@@\n @@@@@&&&@@...            ,,,@@@@@&&&&&%%%%%&&&&&@@@@@,,             ..@&&%%(((@@\n @@@@@@@@**&&&,,...       ...,,@@@%%%%%##%%%%%%%%@@,,,..          ...&&(%#(((((@@\n @@@@@@@@  ,,,&&,,,..        ..@@@%%%%%((%%%%%%%%@@...       ...,,&&&##%(((((((@@\n @@@@@@@@@@@@@%%&&&%%,,,.....  ...@@   %%%%%  @@@..        ,,%%%&&%%%@@@@@@@@@@@@\n @@@@@@@@@@@@@@@%%%##&&&%%,,,,,...  @@@@@@@@@@.  ..**,((%%%&&%##%%%@@@@@@@@@@@@@@\n @@@@@@@@@@@@@@@@@@@@%%%##&&&&&%%%,,,,,,,,,,,,,,,%%&&&&&%##%%%@@@@@@@@@@@@@@@@@@@\n @@@@@@@@@@@@@@@@@@@@@@@@@&&&%%###&&&&&&&&&&&&&&&##%%%&&&@@@@@@@@@@@@@@@@@@@@@@@@\n"
         break
         ;;
       "Crontab")
        cronTab
         break
         ;;

    esac
  done

}

main()
{
  networkSelect
  sleep 0.5
  echo 'Enter your pool name (example: chester-validator)'
  read p
  sleep 0.5
  echo "Enter account name (example: chester)"
  read a
  sleep 0.5
  echo 'Want to use croncat or crontab?'
  sleep 0.5
  cronSelect




  echo 'Selected network: '$NETWORK
  echo 'Your pool: '$p$POOL
  echo 'Your account: '$a$ACCOUNT
  echo '----------------------------'
  echo 'Do you want install CronCat Agent? Check it out: https://docs.cron.cat/docs/agent-cli/'
    PS3="Enter a number: "
    options=("Yes" "No")
    select opt in "${options[@]}"
    do
      case $opt in
         "Yes")
           createAgent
           break
           ;;
         "No")
           sleep 1
           echo "Ping Installed!"
           break
           ;;


      esac
    done


}

createAgent()
{
  echo 'Installing Croncat..'
  sleep 0.5
  npm i -g croncat
  echo 'Registering Agent..'
  sleep 0.5
  croncat register $a$ACCOUNT $a$ACCOUNT
  echo 'Installing Croncat service..'
  sleep 0.2
  mkdir -p $homedir/.croncat
  wget -P $homedir/.croncat https://raw.githubusercontent.com/sicmundu/NEAR-Validator-Tools/main/croncat.service
  sed 's/ACCOUNT/'$a$ACCOUNT'/g' $homedir/.croncat/croncat.service | sudo tee $homedir/.croncat/croncat.service
  sudo systemctl link $homedir/.croncat/croncat.service
  sudo systemctl daemon-reload
  echo 'CronCat Agent installed! Starting..'
  sleep 0.5
  sudo systemctl start croncat.service
}
if [ $(id -u) != "0" ]; then
    echo "Error: You need root"
    exit 1
fi

main