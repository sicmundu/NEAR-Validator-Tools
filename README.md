# NEAR Validator Bot
 Telegram bot for NEAR Validators

How to use:
1. Create new Telegram bot and Get API token from https://t.me/BotFather (https://core.telegram.org/bots#botfather)
2. Clone this repo
3. Make sure that you have python3:
<br><code>sudo apt update</code>
<br><code>sudo apt install python3 pip3 pip -y</code>
4. Install Telebot Python package (https://pypi.org/project/pyTelegramBotAPI/):
<code>pip install pyTelegramBotAPI</code>
5. Edit near.py:
<br>bot = telebot.TeleBot('YOUR_API_TOKEN')
<br>node = "YOUR_POOL" //example: p0s.pool.f863973.m0
<br>account = "YOUR_ACCOUNT" //example: p0k.testnet
<br>network = "NETWORK" //example: testnet
6. Run bot:
<br>Link service file:
<br><code>systecmtl link $HOME/NEAR-Validator-Bot/nearbot.service</code>
<br><code>systemctl daemon-reload</code>
<br><code>systemctl start nearbot.service</code>

7. /start in TG Bot to get commands!


<br>Get logs:
<code>journalctl -u nearbot.service</code>

<br>Main features at the moment:
<br>Get the status of a node;
<br>Restart, start and stop the node
<br>Get logs

# Hot to install NEAR Validator PING
1. Download Install Ping script: 
<br><code>wget https://raw.githubusercontent.com/grodstrike/NEAR-Validator-Bot/main/ping_install.sh && chmod +x ping_install.sh</code>
2. Run Install Script:
<br><code>./ping_install.sh</code>
3. Enter your pool, network and account
<br>![image](https://user-images.githubusercontent.com/21222764/139135195-f4cde895-5c97-4c9c-9ccf-f14a470b84cc.png)
