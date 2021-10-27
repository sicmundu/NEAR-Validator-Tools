import telebot, requests, time, threading, os
from telebot import types
from telebot.types import InlineKeyboardMarkup, InlineKeyboardButton, InputMediaPhoto

bot = telebot.TeleBot('API_TOKEN')
node = "YOUR_POOL"
account = "YOUR_ACCOUNT"
network = "NETWORK"


@bot.message_handler(commands=['start'])
def get_text_messages(message):
     bot.send_message(message.from_user.id, "Welcome to NEAR Validator bot!", reply_markup=server())

def server():
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    markup.add(InlineKeyboardButton("Status server: "+node+" "+checkOnline(), callback_data="status"),
        InlineKeyboardButton("Make ping", callback_data="ping"),
        InlineKeyboardButton("Restart Node", callback_data="restart"),
        InlineKeyboardButton("Stop Node", callback_data="stop"),
        InlineKeyboardButton("Run Node", callback_data="run"),
         InlineKeyboardButton("Get logs", callback_data="logs"))

    return markup

def checkOnline():
    os.system("export NODE_ENV="+network+"")
    val = os.system("o=$(near validators current | grep "+node+") && echo $o")
    if val == 0:
        status = '🟢'
    else:
        status = '🔴'


    return status

def makePing():
    os.system("export NODE_ENV="+network+"")
    val = os.system("near call "+node+" ping '{}' --accountId "+account+" --gas 300000000000000")
    return val

def makeRestart():
    os.system("export NODE_ENV="+network+"")
    val = os.system("nearup restart "+network+"")
    return val

def makeRun():
     os.system("export NODE_ENV="+network+"")
     val = os.system("nearup run "+network+"")
     return val

def makeStop():
     os.system("export NODE_ENV="+network+"")
     val = os.system("nearup stop")
     return val
def getLogs():
    f = open("/root/.nearup/logs/"+network+".log","rb")
    return f

@bot.callback_query_handler(func=lambda call: True)
def callback_query(call):
    data = call.data
    cid = call.message.chat.id
    mid = call.message.message_id
    if data == "status":
        #bot.send_message(chat_id=call.message.chat.id, text=("Miner"), reply_markup=server())
        bot.edit_message_text("Node: "+node, cid, mid, reply_markup=server())
    elif data == 'ping':
        statusPing = makePing()
        if statusPing == 0:
            bot.send_message(chat_id=call.message.chat.id, text=("Ping successful!"), reply_markup=server())
        else:
            bot.send_message(chat_id=call.message.chat.id, text=("Ping error!"), reply_markup=server())
    elif data == 'restart':
        statusNode = makeRestart()
        if statusNode == 0:
            bot.send_message(chat_id=call.message.chat.id, text=("Restart successful!"), reply_markup=server())
        else:
            bot.send_message(chat_id=call.message.chat.id, text=("Restart error!"), reply_markup=server())
    elif data == 'stop':
        statusNode = makeStop()
        if statusNode == 0:
            bot.send_message(chat_id=call.message.chat.id, text=("Stop Node successful!"), reply_markup=server())
        else:
            bot.send_message(chat_id=call.message.chat.id, text=("Restart error!"), reply_markup=server())
    elif data == 'run':
        statusNode = makeRun()
        if statusNode == 0:
            bot.send_message(chat_id=call.message.chat.id, text=("Run Node successful!"), reply_markup=server())
        else:
            bot.send_message(chat_id=call.message.chat.id, text=("Restart error!"), reply_markup=server())
    elif data == 'logs':
        logs = getLogs()
        file_to_send = open('/root/.nearup/logs/'+network+'.log', 'rb')
        bot.send_document(chat_id=call.message.chat.id, data=file_to_send)
        file_to_send.close()
bot.polling(none_stop=True, interval=0)