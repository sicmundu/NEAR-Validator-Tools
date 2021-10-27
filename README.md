# NEAR Validator Bot
 Telegram bot for NEAR Validators

How to use:
1. Create new Telegram bot and Get API token from https://t.me/BotFather (https://core.telegram.org/bots#botfather)
2. Clone this repo
3. Make sure that you have python3:
sudo apt update
sudo apt install python3 pip3 pip -y
4. Install Telebot Python package (https://pypi.org/project/pyTelegramBotAPI/):
pip install pyTelegramBotAPI
5. Edit near.py:
bot = telebot.TeleBot('YOUR_API_TOKEN')
node = "YOUR_POOL" //example: p0s.pool.f863973.m0
account = "YOUR_ACCOUNT" //example: p0k.testnet
network = "NETWORK" //example: testnet
6. Run bot:
python3 near.py
