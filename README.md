# FiveM-Discord-Bot
Simple Discord Webhook for **FiveM** linux server. (The development of this script **continues**)

### Features
```
Server :
	Start			Send message to discord special channel when server start

Players :
	Connect			Send message to discord when user connected
	Disconnect		Send message to discord when user connected
	Chat			Send message to discord when user send a chat message in game
	Death			Send message to discord when user died
```

---

## Download & Installation
### Using Git
```
cd resources
git clone https://gitlab.com/JL-FiveM-Scripts/Discord-Bot [jalallinux]/jl_discord
```

### Manually
- Download https://gitlab.com/JL-FiveM-Scripts/Discord-Bot/-/archive/master/Discord-Bot-master.zip
- Put it in the `[jalallinux]` directory

---

## Bot Config
In `resources` folder, edit `/[jalallinux]/jl_discord/config.lua` with your settings :

```lua
Config = {}

Config.SteamKey = '- - - - - Your Steam Key Here - - - - -'

Config.SystemAvatar = 'https://jalallinux.ir/favicon.png'

Config.UserAvatar = 'https://i.imgur.com/KIcqSYs.png'

Config.SystemName = 'JL Discord'

Config.WebhooksUrl = {
    System      = '- - - - - Discord Channel Webhook URL Here - - - - -',
    Kill        = '- - - - - Discord Channel Webhook URL Here - - - - -',
    Chat        = '- - - - - Discord Channel Webhook URL Here - - - - -',
}
```
**---** You can get your `SteamKey` from https://steamcommunity.com/dev/apikey but it's optional for temporarily.

## Screenshots

![Connect player](https://cdn.discordapp.com/attachments/684367422165090432/727148504585076746/connect-log.png "Connect player") . ![Disconnect playe](https://cdn.discordapp.com/attachments/684367422165090432/727148505596035092/disconnect-log.png "Disconnect player")
![Chat Log](https://cdn.discordapp.com/attachments/684367422165090432/727148503003955250/chat-log.png "Chat Log") . ![Kill Log](https://cdn.discordapp.com/attachments/684367422165090432/727148508108554330/kill-log.png "Kill Log")
