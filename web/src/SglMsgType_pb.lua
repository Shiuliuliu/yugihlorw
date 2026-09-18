local var_0_0 = require("protobuf")

module("SglMsgType_pb")

PROTOMSGTYPE = var_0_0.EnumDescriptor()

local var_0_1 = {
	PB_TYPE_CHALLENGE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_AUTHENTICATION = var_0_0.EnumValueDescriptor(),
	PB_TYPE_HEART_BEAT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_LOGIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_REGISTER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_VISIT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_GUIDE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_NAME = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_AVATAR = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_OPEN_CHEST = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_LOADING_DONE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_NAME_GUIDE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_DEF_TROOP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_COLLECT_GOLD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SPAWN_GOLD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_FINISH_TRAIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_CLAIM_GIFT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_EVENT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_QUERY_GCID = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_CARD_BACK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_AVATAR_FRAME = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_APPLY_VIP_CARD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_CONFIG = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_TECH_UPGRADE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_BAN_CHAT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_ADMIN_LIST = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_GIVE_FUND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_FUND_GIVEN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_VISIT_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_GET_INVITE_CODE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_BIND_INVITE_CODE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_CHECK_INVITE_CODE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_NOTIFY_EVENT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_FACEBOOK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_UPDATE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_CANCEL_BAN_CHAT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_CHARACTER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_UNLOCK_CHARACTER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SET_SKIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_SHARE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_OPPO_VIP_LEVEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_COMMAND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_VOTE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_VOTE_RECORD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_BREAK_OUT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_DYNAMIC_TIMEOUT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_USER_BAN_LOGIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_COLLECT_GOLD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_COLLECT_GRAIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_GUARD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_PICK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_VISIT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_VISIT_REMOVE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_VISIT_RECRUIT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_VISIT_STAY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_PROCEDURE_REMOVE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_PROCEDURE_FINISH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_PROCEDURE_ASSIGN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_PROCEDURE_CANCEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_VISIT_RECRUIT_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_PKG_GUARD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CITY_PKG_PICK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_LOTTERY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARDBOX_INFO = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RESET_CARDBOX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_UPGRADE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_EVOLUTION = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_SELL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_UNLOCK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_COMPOSE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_DECOMPOSE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_EQUIP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_LOTTERY_BOOK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_EXPAND_HERO = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_EXPAND_EQUIP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_EXPAND_BOOK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_EXPAND_HORSE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_LOTTERY_TEN_TOKEN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_LOTTERY_BOOK_JUMP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_RECOVER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_TRANSFORM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_SKILL_SET = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_DECOMPOSE_BATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_RECOVERY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_LEGEND_COMPOSE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_SMELT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_GET_FESTIVAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_LOTTERY_FESTIVAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_RESET_FESTIVAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_LEGEND_TRANSLATE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_LOTTERY_TURNTABLE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_UP_PKG_CARD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_COLLECT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_RUBBING = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_UNRUBBING = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CARD_REMOVERUBBING = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_ATTACK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_FIND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_RETREAT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_CHALLENGE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SWEEP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SCOUT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_RESET_SWEEP_COUNT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_CHALLENGE_ELITE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_CHALLENGE_COMMANDER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_EXPEDITION = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_REFRESH_EXPEDITION = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_GET_EXPEDITION = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_EXPEDITION_OPEN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_FIND_START = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SWEEP_ONCE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_BATTLE_START = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_BATTLE_END = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_BATTLE_JOIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_ROB_GOLD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_ROB_EXP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SWEEP_GOLD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SWEEP_GOLD_ONCE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SWEEP_EXPEDITION = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SWEEP_COPY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SWEEP_COPY_ONCE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SOS = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_RESCUE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_RESCUE_JOIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_RESCUE_END = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_FIND_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_FIND_EX_CANCEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_FIND_RESET = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_GET_OPPONENT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_FIND_NPC = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_RESET_TROOP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_RESET_LADDER_LOSE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_EXPEDITION_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_GET_EXPEDITION_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_EXPEDITION_EX_BOSS = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_LOTTERY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_REFRESH_EXPEDITION_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_BUY_TICKET = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SELECT_CHAR = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SELECT_CARD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_QUIT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_CREATE_MATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_QUERY_MATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_JOIN_MATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_QUIT_MATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_START_MATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_TOGGLE_MATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_GET_MATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_CLOSE_MATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_RECYCLE_MATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_LOTTERY_UNOPEN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_LOTTERY_OPENED = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_UPDATE_LOTTERY_INFO = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_RECOMMEND_TROOP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_DARK_DUEL_DASHBOARD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_DARK_DUEL_RECHEAT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_DAKR_RESET = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SELECT_DARK_TROOP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_BUY_TICKET_SURVIVAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SELECT_CARD_SURVIVAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_QUIT_SURVIVAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_FIND_SURVIVAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_JOIN_SURVIVAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SURVIVAL_HALL_INFO = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SURVIVAL_EXPLORE_START = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SURVIVAL_EXPLORE_END = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SURVIVAL_GAME_OVER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_WORSHIP_LIST = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_WORSHIP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_LOTTERY_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_LEAVE_TEAM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_JOIN_TEAM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_LOTTERY_ACTIVITY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_ROLL_CHAR = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_GEN_ENVELOPE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_QUIT_SURVIVAL_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_FIND_SURVIVAL_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_JOIN_SURVIVAL_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_START = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_END = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SURVIVAL_EX_GAME_OVER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_SURVIVAL_EX_EQUIP_SKILL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_BUY_TICKET_LEGEND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_WORLD_QUIT_LEGEND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_START = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_END = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_USECARD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_OP_USECARD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_LOG = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_REPLAY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_SHARE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_RECOVER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_OP_ONLINE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_OP_OFFLINE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_SYNC = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_CHAT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_SKIP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_OP_SKIP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_TUTORIAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_AGAIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_RETRY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_REPLAY_TUTORIAL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_THUMBS_UP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_THUMBS_UP_CANCEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_REPLAY_SHARE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_SHARE_WATCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_ERROR = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_LOADING_DONE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_LOG_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_REPLAY_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_OP_CHAT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BATTLE_SET_MATCH_HP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_TROOP_RELOAD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_TROOP_MARK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_TROOP_UNLOCK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_SEARCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_RECOMMEND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_INVITE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_ACCEPT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_REMOVE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_LIST = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_ACCEPTED = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_REMOVED = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_BATTLE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_BATTLE_START = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_BATTLE_END = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_BATTLE_JOIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_SEARCH_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_BATTLE_CANCEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FRIEND_BATTLE_UPDATE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MAIL_LIST = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MAIL_SEND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MAIL_RECEIVE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_CHAT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_ACTIVITY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_CLAIM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_ACTIVITY_CLAIM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_RE_CHECK_CLAIM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_ONLINE_CLAIM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_ACTIVITY_EX_CLAIM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_PLAYER_BONUS = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_PLAYER_BONUS_AVAILABLE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_TEACHING_FINISH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_DAILY_TASK_RESET = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_DAILY_TASK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_GIFT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_ENVELOPE_AVAILABLE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_CLAIM_ENVELOPE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BONUS_CHARGE_ENVELOPE_AVAILABLE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_FEEDBACK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_IAP_START = var_0_0.EnumValueDescriptor(),
	PB_TYPE_IAP_FINISH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUY_GOLD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUY_GRAIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUY_DAILY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUY_FUND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUY_DUST = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUY_BADGE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUY_BADGE_LEVEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUY_SPRING_BADGE_LEVEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_BUY_SPRING2_BADGE_LEVEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_BUY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_REFRESH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_EXCHANGE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_BUY_PVP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_OPEN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_REFRESH_PVP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_REFRESH_ALL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_REFRESH_PVP_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_REFRESH_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_BUY_LADDER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_REFRESH_LADDER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_REFRESH_LADDER_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_GIFT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_BUY_GIFT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_MAGICBOX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_UNION = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_SKIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_RARE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_LEGEND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_DIAMOND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_EXCHANGE_PROP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_ANCIENT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_VOTE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_VOTE_COUNT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_RECYCLE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_COLLECTION = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_REVELRY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_RUBBING = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_BADGE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_SHOP_PRIVILEGE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_NEWS = var_0_0.EnumValueDescriptor(),
	PB_TYPE_NEWS_ANNOUNCEMENT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_TROPHY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_LEVEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_STAR = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_BOSS = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_UNION_LEVEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_POWER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_UBOSS_SCORE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_UBOSS_TIME = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_LADDER = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_PRE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_POINT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_CONSUME = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_LADDER_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_PRE_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_CHAR_LEVEL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_UNION_TROPHY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_RESET = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_DARK_PRE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_DARK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_ENVELOPE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_TROPHY_EVENT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_TROPHY_ACTIVITY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_LEGEND_PRE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_RANK_LEGEND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_REGION_LIST = var_0_0.EnumValueDescriptor(),
	PB_TYPE_REGION_GROUP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_REGION_GROUP_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_CREATE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_INVITE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_APPLY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_KICKOUT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_LEAVE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_ACCEPT_INVITE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_ACCEPT_APPLY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_SEARCH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_DETAIL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_JOIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_MESSAGE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_EDIT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_BUY = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_REFRESH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_DONATE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_PROMOTE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_DEMOTE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_UPGRADE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_MINE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_RECOMMEND = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_RESIGN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_LET = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_RENT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_UNLET = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_CLAIM_LET = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_LOG = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WORSHIP = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_BOSS_ATTACK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_BOSS_UNLOCK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_BOSS_DAMAGE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_TECH_UPGRADE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_BOSS_KILL = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_BOSS_FOCUS = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_REFRESH_EX = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_IMPEACH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_UNIMPEACH = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WORLD = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WAR = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WAR_DECLARE = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WAR_DATA = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WAR_BATTLE_START = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WAR_BATTLE_END = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WAR_BATTLE_JOIN = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WAR_BATTLE_SCOUT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WAR_BATTLE_ATTACK = var_0_0.EnumValueDescriptor(),
	PB_TYPE_UNION_WAR_END = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_QUERY_INFO = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_QUIT_INFO = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_CREATE_TEAM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_JOIN_TEAM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_QUIT_TEAM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_KICK_OUT_TEAM = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_LOAD_CARDS = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_START = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_QUIT = var_0_0.EnumValueDescriptor(),
	PB_TYPE_MASSWAR_MULTIPLE_QUIT_TROOP = var_0_0.EnumValueDescriptor()
}

var_0_1.PB_TYPE_CHALLENGE.name = "PB_TYPE_CHALLENGE"
var_0_1.PB_TYPE_CHALLENGE.index = 0
var_0_1.PB_TYPE_CHALLENGE.number = 100
var_0_1.PB_TYPE_AUTHENTICATION.name = "PB_TYPE_AUTHENTICATION"
var_0_1.PB_TYPE_AUTHENTICATION.index = 1
var_0_1.PB_TYPE_AUTHENTICATION.number = 101
var_0_1.PB_TYPE_HEART_BEAT.name = "PB_TYPE_HEART_BEAT"
var_0_1.PB_TYPE_HEART_BEAT.index = 2
var_0_1.PB_TYPE_HEART_BEAT.number = 200
var_0_1.PB_TYPE_USER_LOGIN.name = "PB_TYPE_USER_LOGIN"
var_0_1.PB_TYPE_USER_LOGIN.index = 3
var_0_1.PB_TYPE_USER_LOGIN.number = 300
var_0_1.PB_TYPE_USER_REGISTER.name = "PB_TYPE_USER_REGISTER"
var_0_1.PB_TYPE_USER_REGISTER.index = 4
var_0_1.PB_TYPE_USER_REGISTER.number = 301
var_0_1.PB_TYPE_USER_VISIT.name = "PB_TYPE_USER_VISIT"
var_0_1.PB_TYPE_USER_VISIT.index = 5
var_0_1.PB_TYPE_USER_VISIT.number = 302
var_0_1.PB_TYPE_USER_SET_GUIDE.name = "PB_TYPE_USER_SET_GUIDE"
var_0_1.PB_TYPE_USER_SET_GUIDE.index = 6
var_0_1.PB_TYPE_USER_SET_GUIDE.number = 303
var_0_1.PB_TYPE_USER_SET_NAME.name = "PB_TYPE_USER_SET_NAME"
var_0_1.PB_TYPE_USER_SET_NAME.index = 7
var_0_1.PB_TYPE_USER_SET_NAME.number = 304
var_0_1.PB_TYPE_USER_SET_AVATAR.name = "PB_TYPE_USER_SET_AVATAR"
var_0_1.PB_TYPE_USER_SET_AVATAR.index = 8
var_0_1.PB_TYPE_USER_SET_AVATAR.number = 305
var_0_1.PB_TYPE_USER_OPEN_CHEST.name = "PB_TYPE_USER_OPEN_CHEST"
var_0_1.PB_TYPE_USER_OPEN_CHEST.index = 9
var_0_1.PB_TYPE_USER_OPEN_CHEST.number = 306
var_0_1.PB_TYPE_USER_LOADING_DONE.name = "PB_TYPE_USER_LOADING_DONE"
var_0_1.PB_TYPE_USER_LOADING_DONE.index = 10
var_0_1.PB_TYPE_USER_LOADING_DONE.number = 307
var_0_1.PB_TYPE_USER_SET_NAME_GUIDE.name = "PB_TYPE_USER_SET_NAME_GUIDE"
var_0_1.PB_TYPE_USER_SET_NAME_GUIDE.index = 11
var_0_1.PB_TYPE_USER_SET_NAME_GUIDE.number = 308
var_0_1.PB_TYPE_USER_SET_DEF_TROOP.name = "PB_TYPE_USER_SET_DEF_TROOP"
var_0_1.PB_TYPE_USER_SET_DEF_TROOP.index = 12
var_0_1.PB_TYPE_USER_SET_DEF_TROOP.number = 309
var_0_1.PB_TYPE_USER_COLLECT_GOLD.name = "PB_TYPE_USER_COLLECT_GOLD"
var_0_1.PB_TYPE_USER_COLLECT_GOLD.index = 13
var_0_1.PB_TYPE_USER_COLLECT_GOLD.number = 310
var_0_1.PB_TYPE_USER_SPAWN_GOLD.name = "PB_TYPE_USER_SPAWN_GOLD"
var_0_1.PB_TYPE_USER_SPAWN_GOLD.index = 14
var_0_1.PB_TYPE_USER_SPAWN_GOLD.number = 311
var_0_1.PB_TYPE_USER_FINISH_TRAIN.name = "PB_TYPE_USER_FINISH_TRAIN"
var_0_1.PB_TYPE_USER_FINISH_TRAIN.index = 15
var_0_1.PB_TYPE_USER_FINISH_TRAIN.number = 312
var_0_1.PB_TYPE_USER_CLAIM_GIFT.name = "PB_TYPE_USER_CLAIM_GIFT"
var_0_1.PB_TYPE_USER_CLAIM_GIFT.index = 16
var_0_1.PB_TYPE_USER_CLAIM_GIFT.number = 313
var_0_1.PB_TYPE_USER_SET_EVENT.name = "PB_TYPE_USER_SET_EVENT"
var_0_1.PB_TYPE_USER_SET_EVENT.index = 17
var_0_1.PB_TYPE_USER_SET_EVENT.number = 314
var_0_1.PB_TYPE_USER_QUERY_GCID.name = "PB_TYPE_USER_QUERY_GCID"
var_0_1.PB_TYPE_USER_QUERY_GCID.index = 18
var_0_1.PB_TYPE_USER_QUERY_GCID.number = 315
var_0_1.PB_TYPE_USER_SET_CARD_BACK.name = "PB_TYPE_USER_SET_CARD_BACK"
var_0_1.PB_TYPE_USER_SET_CARD_BACK.index = 19
var_0_1.PB_TYPE_USER_SET_CARD_BACK.number = 316
var_0_1.PB_TYPE_USER_SET_AVATAR_FRAME.name = "PB_TYPE_USER_SET_AVATAR_FRAME"
var_0_1.PB_TYPE_USER_SET_AVATAR_FRAME.index = 20
var_0_1.PB_TYPE_USER_SET_AVATAR_FRAME.number = 317
var_0_1.PB_TYPE_USER_APPLY_VIP_CARD.name = "PB_TYPE_USER_APPLY_VIP_CARD"
var_0_1.PB_TYPE_USER_APPLY_VIP_CARD.index = 21
var_0_1.PB_TYPE_USER_APPLY_VIP_CARD.number = 318
var_0_1.PB_TYPE_USER_SET_CONFIG.name = "PB_TYPE_USER_SET_CONFIG"
var_0_1.PB_TYPE_USER_SET_CONFIG.index = 22
var_0_1.PB_TYPE_USER_SET_CONFIG.number = 319
var_0_1.PB_TYPE_USER_TECH_UPGRADE.name = "PB_TYPE_USER_TECH_UPGRADE"
var_0_1.PB_TYPE_USER_TECH_UPGRADE.index = 23
var_0_1.PB_TYPE_USER_TECH_UPGRADE.number = 320
var_0_1.PB_TYPE_USER_BAN_CHAT.name = "PB_TYPE_USER_BAN_CHAT"
var_0_1.PB_TYPE_USER_BAN_CHAT.index = 24
var_0_1.PB_TYPE_USER_BAN_CHAT.number = 321
var_0_1.PB_TYPE_USER_ADMIN_LIST.name = "PB_TYPE_USER_ADMIN_LIST"
var_0_1.PB_TYPE_USER_ADMIN_LIST.index = 25
var_0_1.PB_TYPE_USER_ADMIN_LIST.number = 322
var_0_1.PB_TYPE_USER_GIVE_FUND.name = "PB_TYPE_USER_GIVE_FUND"
var_0_1.PB_TYPE_USER_GIVE_FUND.index = 26
var_0_1.PB_TYPE_USER_GIVE_FUND.number = 323
var_0_1.PB_TYPE_USER_FUND_GIVEN.name = "PB_TYPE_USER_FUND_GIVEN"
var_0_1.PB_TYPE_USER_FUND_GIVEN.index = 27
var_0_1.PB_TYPE_USER_FUND_GIVEN.number = 324
var_0_1.PB_TYPE_USER_VISIT_EX.name = "PB_TYPE_USER_VISIT_EX"
var_0_1.PB_TYPE_USER_VISIT_EX.index = 28
var_0_1.PB_TYPE_USER_VISIT_EX.number = 325
var_0_1.PB_TYPE_USER_GET_INVITE_CODE.name = "PB_TYPE_USER_GET_INVITE_CODE"
var_0_1.PB_TYPE_USER_GET_INVITE_CODE.index = 29
var_0_1.PB_TYPE_USER_GET_INVITE_CODE.number = 326
var_0_1.PB_TYPE_USER_BIND_INVITE_CODE.name = "PB_TYPE_USER_BIND_INVITE_CODE"
var_0_1.PB_TYPE_USER_BIND_INVITE_CODE.index = 30
var_0_1.PB_TYPE_USER_BIND_INVITE_CODE.number = 327
var_0_1.PB_TYPE_USER_CHECK_INVITE_CODE.name = "PB_TYPE_USER_CHECK_INVITE_CODE"
var_0_1.PB_TYPE_USER_CHECK_INVITE_CODE.index = 31
var_0_1.PB_TYPE_USER_CHECK_INVITE_CODE.number = 328
var_0_1.PB_TYPE_USER_NOTIFY_EVENT.name = "PB_TYPE_USER_NOTIFY_EVENT"
var_0_1.PB_TYPE_USER_NOTIFY_EVENT.index = 32
var_0_1.PB_TYPE_USER_NOTIFY_EVENT.number = 329
var_0_1.PB_TYPE_USER_FACEBOOK.name = "PB_TYPE_USER_FACEBOOK"
var_0_1.PB_TYPE_USER_FACEBOOK.index = 33
var_0_1.PB_TYPE_USER_FACEBOOK.number = 330
var_0_1.PB_TYPE_USER_UPDATE.name = "PB_TYPE_USER_UPDATE"
var_0_1.PB_TYPE_USER_UPDATE.index = 34
var_0_1.PB_TYPE_USER_UPDATE.number = 331
var_0_1.PB_TYPE_USER_CANCEL_BAN_CHAT.name = "PB_TYPE_USER_CANCEL_BAN_CHAT"
var_0_1.PB_TYPE_USER_CANCEL_BAN_CHAT.index = 35
var_0_1.PB_TYPE_USER_CANCEL_BAN_CHAT.number = 332
var_0_1.PB_TYPE_USER_SET_CHARACTER.name = "PB_TYPE_USER_SET_CHARACTER"
var_0_1.PB_TYPE_USER_SET_CHARACTER.index = 36
var_0_1.PB_TYPE_USER_SET_CHARACTER.number = 333
var_0_1.PB_TYPE_USER_UNLOCK_CHARACTER.name = "PB_TYPE_USER_UNLOCK_CHARACTER"
var_0_1.PB_TYPE_USER_UNLOCK_CHARACTER.index = 37
var_0_1.PB_TYPE_USER_UNLOCK_CHARACTER.number = 334
var_0_1.PB_TYPE_USER_SET_SKIN.name = "PB_TYPE_USER_SET_SKIN"
var_0_1.PB_TYPE_USER_SET_SKIN.index = 38
var_0_1.PB_TYPE_USER_SET_SKIN.number = 335
var_0_1.PB_TYPE_USER_SHARE.name = "PB_TYPE_USER_SHARE"
var_0_1.PB_TYPE_USER_SHARE.index = 39
var_0_1.PB_TYPE_USER_SHARE.number = 336
var_0_1.PB_TYPE_USER_OPPO_VIP_LEVEL.name = "PB_TYPE_USER_OPPO_VIP_LEVEL"
var_0_1.PB_TYPE_USER_OPPO_VIP_LEVEL.index = 40
var_0_1.PB_TYPE_USER_OPPO_VIP_LEVEL.number = 337
var_0_1.PB_TYPE_USER_COMMAND.name = "PB_TYPE_USER_COMMAND"
var_0_1.PB_TYPE_USER_COMMAND.index = 41
var_0_1.PB_TYPE_USER_COMMAND.number = 338
var_0_1.PB_TYPE_USER_VOTE.name = "PB_TYPE_USER_VOTE"
var_0_1.PB_TYPE_USER_VOTE.index = 42
var_0_1.PB_TYPE_USER_VOTE.number = 339
var_0_1.PB_TYPE_USER_VOTE_RECORD.name = "PB_TYPE_USER_VOTE_RECORD"
var_0_1.PB_TYPE_USER_VOTE_RECORD.index = 43
var_0_1.PB_TYPE_USER_VOTE_RECORD.number = 340
var_0_1.PB_TYPE_USER_BREAK_OUT.name = "PB_TYPE_USER_BREAK_OUT"
var_0_1.PB_TYPE_USER_BREAK_OUT.index = 44
var_0_1.PB_TYPE_USER_BREAK_OUT.number = 341
var_0_1.PB_TYPE_USER_DYNAMIC_TIMEOUT.name = "PB_TYPE_USER_DYNAMIC_TIMEOUT"
var_0_1.PB_TYPE_USER_DYNAMIC_TIMEOUT.index = 45
var_0_1.PB_TYPE_USER_DYNAMIC_TIMEOUT.number = 342
var_0_1.PB_TYPE_USER_BAN_LOGIN.name = "PB_TYPE_USER_BAN_LOGIN"
var_0_1.PB_TYPE_USER_BAN_LOGIN.index = 46
var_0_1.PB_TYPE_USER_BAN_LOGIN.number = 343
var_0_1.PB_TYPE_CITY_COLLECT_GOLD.name = "PB_TYPE_CITY_COLLECT_GOLD"
var_0_1.PB_TYPE_CITY_COLLECT_GOLD.index = 47
var_0_1.PB_TYPE_CITY_COLLECT_GOLD.number = 400
var_0_1.PB_TYPE_CITY_COLLECT_GRAIN.name = "PB_TYPE_CITY_COLLECT_GRAIN"
var_0_1.PB_TYPE_CITY_COLLECT_GRAIN.index = 48
var_0_1.PB_TYPE_CITY_COLLECT_GRAIN.number = 401
var_0_1.PB_TYPE_CITY_GUARD.name = "PB_TYPE_CITY_GUARD"
var_0_1.PB_TYPE_CITY_GUARD.index = 49
var_0_1.PB_TYPE_CITY_GUARD.number = 402
var_0_1.PB_TYPE_CITY_PICK.name = "PB_TYPE_CITY_PICK"
var_0_1.PB_TYPE_CITY_PICK.index = 50
var_0_1.PB_TYPE_CITY_PICK.number = 403
var_0_1.PB_TYPE_CITY_VISIT.name = "PB_TYPE_CITY_VISIT"
var_0_1.PB_TYPE_CITY_VISIT.index = 51
var_0_1.PB_TYPE_CITY_VISIT.number = 404
var_0_1.PB_TYPE_CITY_VISIT_REMOVE.name = "PB_TYPE_CITY_VISIT_REMOVE"
var_0_1.PB_TYPE_CITY_VISIT_REMOVE.index = 52
var_0_1.PB_TYPE_CITY_VISIT_REMOVE.number = 405
var_0_1.PB_TYPE_CITY_VISIT_RECRUIT.name = "PB_TYPE_CITY_VISIT_RECRUIT"
var_0_1.PB_TYPE_CITY_VISIT_RECRUIT.index = 53
var_0_1.PB_TYPE_CITY_VISIT_RECRUIT.number = 406
var_0_1.PB_TYPE_CITY_VISIT_STAY.name = "PB_TYPE_CITY_VISIT_STAY"
var_0_1.PB_TYPE_CITY_VISIT_STAY.index = 54
var_0_1.PB_TYPE_CITY_VISIT_STAY.number = 407
var_0_1.PB_TYPE_CITY_PROCEDURE_REMOVE.name = "PB_TYPE_CITY_PROCEDURE_REMOVE"
var_0_1.PB_TYPE_CITY_PROCEDURE_REMOVE.index = 55
var_0_1.PB_TYPE_CITY_PROCEDURE_REMOVE.number = 408
var_0_1.PB_TYPE_CITY_PROCEDURE_FINISH.name = "PB_TYPE_CITY_PROCEDURE_FINISH"
var_0_1.PB_TYPE_CITY_PROCEDURE_FINISH.index = 56
var_0_1.PB_TYPE_CITY_PROCEDURE_FINISH.number = 409
var_0_1.PB_TYPE_CITY_PROCEDURE_ASSIGN.name = "PB_TYPE_CITY_PROCEDURE_ASSIGN"
var_0_1.PB_TYPE_CITY_PROCEDURE_ASSIGN.index = 57
var_0_1.PB_TYPE_CITY_PROCEDURE_ASSIGN.number = 410
var_0_1.PB_TYPE_CITY_PROCEDURE_CANCEL.name = "PB_TYPE_CITY_PROCEDURE_CANCEL"
var_0_1.PB_TYPE_CITY_PROCEDURE_CANCEL.index = 58
var_0_1.PB_TYPE_CITY_PROCEDURE_CANCEL.number = 411
var_0_1.PB_TYPE_CITY_VISIT_RECRUIT_EX.name = "PB_TYPE_CITY_VISIT_RECRUIT_EX"
var_0_1.PB_TYPE_CITY_VISIT_RECRUIT_EX.index = 59
var_0_1.PB_TYPE_CITY_VISIT_RECRUIT_EX.number = 412
var_0_1.PB_TYPE_CITY_PKG_GUARD.name = "PB_TYPE_CITY_PKG_GUARD"
var_0_1.PB_TYPE_CITY_PKG_GUARD.index = 60
var_0_1.PB_TYPE_CITY_PKG_GUARD.number = 413
var_0_1.PB_TYPE_CITY_PKG_PICK.name = "PB_TYPE_CITY_PKG_PICK"
var_0_1.PB_TYPE_CITY_PKG_PICK.index = 61
var_0_1.PB_TYPE_CITY_PKG_PICK.number = 414
var_0_1.PB_TYPE_CARD_LOTTERY.name = "PB_TYPE_CARD_LOTTERY"
var_0_1.PB_TYPE_CARD_LOTTERY.index = 62
var_0_1.PB_TYPE_CARD_LOTTERY.number = 500
var_0_1.PB_TYPE_CARDBOX_INFO.name = "PB_TYPE_CARDBOX_INFO"
var_0_1.PB_TYPE_CARDBOX_INFO.index = 63
var_0_1.PB_TYPE_CARDBOX_INFO.number = 501
var_0_1.PB_TYPE_RESET_CARDBOX.name = "PB_TYPE_RESET_CARDBOX"
var_0_1.PB_TYPE_RESET_CARDBOX.index = 64
var_0_1.PB_TYPE_RESET_CARDBOX.number = 502
var_0_1.PB_TYPE_CARD_UPGRADE.name = "PB_TYPE_CARD_UPGRADE"
var_0_1.PB_TYPE_CARD_UPGRADE.index = 65
var_0_1.PB_TYPE_CARD_UPGRADE.number = 507
var_0_1.PB_TYPE_CARD_EVOLUTION.name = "PB_TYPE_CARD_EVOLUTION"
var_0_1.PB_TYPE_CARD_EVOLUTION.index = 66
var_0_1.PB_TYPE_CARD_EVOLUTION.number = 508
var_0_1.PB_TYPE_CARD_SELL.name = "PB_TYPE_CARD_SELL"
var_0_1.PB_TYPE_CARD_SELL.index = 67
var_0_1.PB_TYPE_CARD_SELL.number = 509
var_0_1.PB_TYPE_CARD_UNLOCK.name = "PB_TYPE_CARD_UNLOCK"
var_0_1.PB_TYPE_CARD_UNLOCK.index = 68
var_0_1.PB_TYPE_CARD_UNLOCK.number = 510
var_0_1.PB_TYPE_CARD_COMPOSE.name = "PB_TYPE_CARD_COMPOSE"
var_0_1.PB_TYPE_CARD_COMPOSE.index = 69
var_0_1.PB_TYPE_CARD_COMPOSE.number = 511
var_0_1.PB_TYPE_CARD_DECOMPOSE.name = "PB_TYPE_CARD_DECOMPOSE"
var_0_1.PB_TYPE_CARD_DECOMPOSE.index = 70
var_0_1.PB_TYPE_CARD_DECOMPOSE.number = 512
var_0_1.PB_TYPE_CARD_EQUIP.name = "PB_TYPE_CARD_EQUIP"
var_0_1.PB_TYPE_CARD_EQUIP.index = 71
var_0_1.PB_TYPE_CARD_EQUIP.number = 513
var_0_1.PB_TYPE_CARD_LOTTERY_BOOK.name = "PB_TYPE_CARD_LOTTERY_BOOK"
var_0_1.PB_TYPE_CARD_LOTTERY_BOOK.index = 72
var_0_1.PB_TYPE_CARD_LOTTERY_BOOK.number = 514
var_0_1.PB_TYPE_CARD_EXPAND_HERO.name = "PB_TYPE_CARD_EXPAND_HERO"
var_0_1.PB_TYPE_CARD_EXPAND_HERO.index = 73
var_0_1.PB_TYPE_CARD_EXPAND_HERO.number = 515
var_0_1.PB_TYPE_CARD_EXPAND_EQUIP.name = "PB_TYPE_CARD_EXPAND_EQUIP"
var_0_1.PB_TYPE_CARD_EXPAND_EQUIP.index = 74
var_0_1.PB_TYPE_CARD_EXPAND_EQUIP.number = 516
var_0_1.PB_TYPE_CARD_EXPAND_BOOK.name = "PB_TYPE_CARD_EXPAND_BOOK"
var_0_1.PB_TYPE_CARD_EXPAND_BOOK.index = 75
var_0_1.PB_TYPE_CARD_EXPAND_BOOK.number = 517
var_0_1.PB_TYPE_CARD_EXPAND_HORSE.name = "PB_TYPE_CARD_EXPAND_HORSE"
var_0_1.PB_TYPE_CARD_EXPAND_HORSE.index = 76
var_0_1.PB_TYPE_CARD_EXPAND_HORSE.number = 518
var_0_1.PB_TYPE_CARD_LOTTERY_TEN_TOKEN.name = "PB_TYPE_CARD_LOTTERY_TEN_TOKEN"
var_0_1.PB_TYPE_CARD_LOTTERY_TEN_TOKEN.index = 77
var_0_1.PB_TYPE_CARD_LOTTERY_TEN_TOKEN.number = 519
var_0_1.PB_TYPE_CARD_LOTTERY_BOOK_JUMP.name = "PB_TYPE_CARD_LOTTERY_BOOK_JUMP"
var_0_1.PB_TYPE_CARD_LOTTERY_BOOK_JUMP.index = 78
var_0_1.PB_TYPE_CARD_LOTTERY_BOOK_JUMP.number = 521
var_0_1.PB_TYPE_CARD_RECOVER.name = "PB_TYPE_CARD_RECOVER"
var_0_1.PB_TYPE_CARD_RECOVER.index = 79
var_0_1.PB_TYPE_CARD_RECOVER.number = 522
var_0_1.PB_TYPE_CARD_TRANSFORM.name = "PB_TYPE_CARD_TRANSFORM"
var_0_1.PB_TYPE_CARD_TRANSFORM.index = 80
var_0_1.PB_TYPE_CARD_TRANSFORM.number = 523
var_0_1.PB_TYPE_CARD_SKILL_SET.name = "PB_TYPE_CARD_SKILL_SET"
var_0_1.PB_TYPE_CARD_SKILL_SET.index = 81
var_0_1.PB_TYPE_CARD_SKILL_SET.number = 526
var_0_1.PB_TYPE_CARD_DECOMPOSE_BATCH.name = "PB_TYPE_CARD_DECOMPOSE_BATCH"
var_0_1.PB_TYPE_CARD_DECOMPOSE_BATCH.index = 82
var_0_1.PB_TYPE_CARD_DECOMPOSE_BATCH.number = 527
var_0_1.PB_TYPE_CARD_RECOVERY.name = "PB_TYPE_CARD_RECOVERY"
var_0_1.PB_TYPE_CARD_RECOVERY.index = 83
var_0_1.PB_TYPE_CARD_RECOVERY.number = 528
var_0_1.PB_TYPE_CARD_LEGEND_COMPOSE.name = "PB_TYPE_CARD_LEGEND_COMPOSE"
var_0_1.PB_TYPE_CARD_LEGEND_COMPOSE.index = 84
var_0_1.PB_TYPE_CARD_LEGEND_COMPOSE.number = 529
var_0_1.PB_TYPE_CARD_SMELT.name = "PB_TYPE_CARD_SMELT"
var_0_1.PB_TYPE_CARD_SMELT.index = 85
var_0_1.PB_TYPE_CARD_SMELT.number = 530
var_0_1.PB_TYPE_CARD_GET_FESTIVAL.name = "PB_TYPE_CARD_GET_FESTIVAL"
var_0_1.PB_TYPE_CARD_GET_FESTIVAL.index = 86
var_0_1.PB_TYPE_CARD_GET_FESTIVAL.number = 531
var_0_1.PB_TYPE_CARD_LOTTERY_FESTIVAL.name = "PB_TYPE_CARD_LOTTERY_FESTIVAL"
var_0_1.PB_TYPE_CARD_LOTTERY_FESTIVAL.index = 87
var_0_1.PB_TYPE_CARD_LOTTERY_FESTIVAL.number = 532
var_0_1.PB_TYPE_CARD_RESET_FESTIVAL.name = "PB_TYPE_CARD_RESET_FESTIVAL"
var_0_1.PB_TYPE_CARD_RESET_FESTIVAL.index = 88
var_0_1.PB_TYPE_CARD_RESET_FESTIVAL.number = 533
var_0_1.PB_TYPE_CARD_LEGEND_TRANSLATE.name = "PB_TYPE_CARD_LEGEND_TRANSLATE"
var_0_1.PB_TYPE_CARD_LEGEND_TRANSLATE.index = 89
var_0_1.PB_TYPE_CARD_LEGEND_TRANSLATE.number = 534
var_0_1.PB_TYPE_CARD_LOTTERY_TURNTABLE.name = "PB_TYPE_CARD_LOTTERY_TURNTABLE"
var_0_1.PB_TYPE_CARD_LOTTERY_TURNTABLE.index = 90
var_0_1.PB_TYPE_CARD_LOTTERY_TURNTABLE.number = 535
var_0_1.PB_TYPE_CARD_UP_PKG_CARD.name = "PB_TYPE_CARD_UP_PKG_CARD"
var_0_1.PB_TYPE_CARD_UP_PKG_CARD.index = 91
var_0_1.PB_TYPE_CARD_UP_PKG_CARD.number = 536
var_0_1.PB_TYPE_CARD_COLLECT.name = "PB_TYPE_CARD_COLLECT"
var_0_1.PB_TYPE_CARD_COLLECT.index = 92
var_0_1.PB_TYPE_CARD_COLLECT.number = 537
var_0_1.PB_TYPE_CARD_RUBBING.name = "PB_TYPE_CARD_RUBBING"
var_0_1.PB_TYPE_CARD_RUBBING.index = 93
var_0_1.PB_TYPE_CARD_RUBBING.number = 538
var_0_1.PB_TYPE_CARD_UNRUBBING.name = "PB_TYPE_CARD_UNRUBBING"
var_0_1.PB_TYPE_CARD_UNRUBBING.index = 94
var_0_1.PB_TYPE_CARD_UNRUBBING.number = 539
var_0_1.PB_TYPE_CARD_REMOVERUBBING.name = "PB_TYPE_CARD_REMOVERUBBING"
var_0_1.PB_TYPE_CARD_REMOVERUBBING.index = 95
var_0_1.PB_TYPE_CARD_REMOVERUBBING.number = 540
var_0_1.PB_TYPE_WORLD_ATTACK.name = "PB_TYPE_WORLD_ATTACK"
var_0_1.PB_TYPE_WORLD_ATTACK.index = 96
var_0_1.PB_TYPE_WORLD_ATTACK.number = 600
var_0_1.PB_TYPE_WORLD_FIND.name = "PB_TYPE_WORLD_FIND"
var_0_1.PB_TYPE_WORLD_FIND.index = 97
var_0_1.PB_TYPE_WORLD_FIND.number = 601
var_0_1.PB_TYPE_WORLD_RETREAT.name = "PB_TYPE_WORLD_RETREAT"
var_0_1.PB_TYPE_WORLD_RETREAT.index = 98
var_0_1.PB_TYPE_WORLD_RETREAT.number = 602
var_0_1.PB_TYPE_WORLD_CHALLENGE.name = "PB_TYPE_WORLD_CHALLENGE"
var_0_1.PB_TYPE_WORLD_CHALLENGE.index = 99
var_0_1.PB_TYPE_WORLD_CHALLENGE.number = 603
var_0_1.PB_TYPE_WORLD_SWEEP.name = "PB_TYPE_WORLD_SWEEP"
var_0_1.PB_TYPE_WORLD_SWEEP.index = 100
var_0_1.PB_TYPE_WORLD_SWEEP.number = 604
var_0_1.PB_TYPE_WORLD_SCOUT.name = "PB_TYPE_WORLD_SCOUT"
var_0_1.PB_TYPE_WORLD_SCOUT.index = 101
var_0_1.PB_TYPE_WORLD_SCOUT.number = 607
var_0_1.PB_TYPE_WORLD_RESET_SWEEP_COUNT.name = "PB_TYPE_WORLD_RESET_SWEEP_COUNT"
var_0_1.PB_TYPE_WORLD_RESET_SWEEP_COUNT.index = 102
var_0_1.PB_TYPE_WORLD_RESET_SWEEP_COUNT.number = 609
var_0_1.PB_TYPE_WORLD_CHALLENGE_ELITE.name = "PB_TYPE_WORLD_CHALLENGE_ELITE"
var_0_1.PB_TYPE_WORLD_CHALLENGE_ELITE.index = 103
var_0_1.PB_TYPE_WORLD_CHALLENGE_ELITE.number = 610
var_0_1.PB_TYPE_WORLD_CHALLENGE_COMMANDER.name = "PB_TYPE_WORLD_CHALLENGE_COMMANDER"
var_0_1.PB_TYPE_WORLD_CHALLENGE_COMMANDER.index = 104
var_0_1.PB_TYPE_WORLD_CHALLENGE_COMMANDER.number = 611
var_0_1.PB_TYPE_WORLD_EXPEDITION.name = "PB_TYPE_WORLD_EXPEDITION"
var_0_1.PB_TYPE_WORLD_EXPEDITION.index = 105
var_0_1.PB_TYPE_WORLD_EXPEDITION.number = 613
var_0_1.PB_TYPE_WORLD_REFRESH_EXPEDITION.name = "PB_TYPE_WORLD_REFRESH_EXPEDITION"
var_0_1.PB_TYPE_WORLD_REFRESH_EXPEDITION.index = 106
var_0_1.PB_TYPE_WORLD_REFRESH_EXPEDITION.number = 614
var_0_1.PB_TYPE_WORLD_GET_EXPEDITION.name = "PB_TYPE_WORLD_GET_EXPEDITION"
var_0_1.PB_TYPE_WORLD_GET_EXPEDITION.index = 107
var_0_1.PB_TYPE_WORLD_GET_EXPEDITION.number = 615
var_0_1.PB_TYPE_WORLD_EXPEDITION_OPEN.name = "PB_TYPE_WORLD_EXPEDITION_OPEN"
var_0_1.PB_TYPE_WORLD_EXPEDITION_OPEN.index = 108
var_0_1.PB_TYPE_WORLD_EXPEDITION_OPEN.number = 616
var_0_1.PB_TYPE_WORLD_FIND_START.name = "PB_TYPE_WORLD_FIND_START"
var_0_1.PB_TYPE_WORLD_FIND_START.index = 109
var_0_1.PB_TYPE_WORLD_FIND_START.number = 617
var_0_1.PB_TYPE_WORLD_SWEEP_ONCE.name = "PB_TYPE_WORLD_SWEEP_ONCE"
var_0_1.PB_TYPE_WORLD_SWEEP_ONCE.index = 110
var_0_1.PB_TYPE_WORLD_SWEEP_ONCE.number = 618
var_0_1.PB_TYPE_WORLD_BATTLE_START.name = "PB_TYPE_WORLD_BATTLE_START"
var_0_1.PB_TYPE_WORLD_BATTLE_START.index = 111
var_0_1.PB_TYPE_WORLD_BATTLE_START.number = 619
var_0_1.PB_TYPE_WORLD_BATTLE_END.name = "PB_TYPE_WORLD_BATTLE_END"
var_0_1.PB_TYPE_WORLD_BATTLE_END.index = 112
var_0_1.PB_TYPE_WORLD_BATTLE_END.number = 620
var_0_1.PB_TYPE_WORLD_BATTLE_JOIN.name = "PB_TYPE_WORLD_BATTLE_JOIN"
var_0_1.PB_TYPE_WORLD_BATTLE_JOIN.index = 113
var_0_1.PB_TYPE_WORLD_BATTLE_JOIN.number = 621
var_0_1.PB_TYPE_WORLD_ROB_GOLD.name = "PB_TYPE_WORLD_ROB_GOLD"
var_0_1.PB_TYPE_WORLD_ROB_GOLD.index = 114
var_0_1.PB_TYPE_WORLD_ROB_GOLD.number = 622
var_0_1.PB_TYPE_WORLD_ROB_EXP.name = "PB_TYPE_WORLD_ROB_EXP"
var_0_1.PB_TYPE_WORLD_ROB_EXP.index = 115
var_0_1.PB_TYPE_WORLD_ROB_EXP.number = 623
var_0_1.PB_TYPE_WORLD_SWEEP_GOLD.name = "PB_TYPE_WORLD_SWEEP_GOLD"
var_0_1.PB_TYPE_WORLD_SWEEP_GOLD.index = 116
var_0_1.PB_TYPE_WORLD_SWEEP_GOLD.number = 624
var_0_1.PB_TYPE_WORLD_SWEEP_GOLD_ONCE.name = "PB_TYPE_WORLD_SWEEP_GOLD_ONCE"
var_0_1.PB_TYPE_WORLD_SWEEP_GOLD_ONCE.index = 117
var_0_1.PB_TYPE_WORLD_SWEEP_GOLD_ONCE.number = 625
var_0_1.PB_TYPE_WORLD_SWEEP_EXPEDITION.name = "PB_TYPE_WORLD_SWEEP_EXPEDITION"
var_0_1.PB_TYPE_WORLD_SWEEP_EXPEDITION.index = 118
var_0_1.PB_TYPE_WORLD_SWEEP_EXPEDITION.number = 626
var_0_1.PB_TYPE_WORLD_SWEEP_COPY.name = "PB_TYPE_WORLD_SWEEP_COPY"
var_0_1.PB_TYPE_WORLD_SWEEP_COPY.index = 119
var_0_1.PB_TYPE_WORLD_SWEEP_COPY.number = 627
var_0_1.PB_TYPE_WORLD_SWEEP_COPY_ONCE.name = "PB_TYPE_WORLD_SWEEP_COPY_ONCE"
var_0_1.PB_TYPE_WORLD_SWEEP_COPY_ONCE.index = 120
var_0_1.PB_TYPE_WORLD_SWEEP_COPY_ONCE.number = 628
var_0_1.PB_TYPE_WORLD_SOS.name = "PB_TYPE_WORLD_SOS"
var_0_1.PB_TYPE_WORLD_SOS.index = 121
var_0_1.PB_TYPE_WORLD_SOS.number = 629
var_0_1.PB_TYPE_WORLD_RESCUE.name = "PB_TYPE_WORLD_RESCUE"
var_0_1.PB_TYPE_WORLD_RESCUE.index = 122
var_0_1.PB_TYPE_WORLD_RESCUE.number = 630
var_0_1.PB_TYPE_WORLD_RESCUE_JOIN.name = "PB_TYPE_WORLD_RESCUE_JOIN"
var_0_1.PB_TYPE_WORLD_RESCUE_JOIN.index = 123
var_0_1.PB_TYPE_WORLD_RESCUE_JOIN.number = 631
var_0_1.PB_TYPE_WORLD_RESCUE_END.name = "PB_TYPE_WORLD_RESCUE_END"
var_0_1.PB_TYPE_WORLD_RESCUE_END.index = 124
var_0_1.PB_TYPE_WORLD_RESCUE_END.number = 632
var_0_1.PB_TYPE_WORLD_FIND_EX.name = "PB_TYPE_WORLD_FIND_EX"
var_0_1.PB_TYPE_WORLD_FIND_EX.index = 125
var_0_1.PB_TYPE_WORLD_FIND_EX.number = 633
var_0_1.PB_TYPE_WORLD_FIND_EX_CANCEL.name = "PB_TYPE_WORLD_FIND_EX_CANCEL"
var_0_1.PB_TYPE_WORLD_FIND_EX_CANCEL.index = 126
var_0_1.PB_TYPE_WORLD_FIND_EX_CANCEL.number = 634
var_0_1.PB_TYPE_WORLD_FIND_RESET.name = "PB_TYPE_WORLD_FIND_RESET"
var_0_1.PB_TYPE_WORLD_FIND_RESET.index = 127
var_0_1.PB_TYPE_WORLD_FIND_RESET.number = 635
var_0_1.PB_TYPE_WORLD_GET_OPPONENT.name = "PB_TYPE_WORLD_GET_OPPONENT"
var_0_1.PB_TYPE_WORLD_GET_OPPONENT.index = 128
var_0_1.PB_TYPE_WORLD_GET_OPPONENT.number = 636
var_0_1.PB_TYPE_WORLD_FIND_NPC.name = "PB_TYPE_WORLD_FIND_NPC"
var_0_1.PB_TYPE_WORLD_FIND_NPC.index = 129
var_0_1.PB_TYPE_WORLD_FIND_NPC.number = 637
var_0_1.PB_TYPE_WORLD_RESET_TROOP.name = "PB_TYPE_WORLD_RESET_TROOP"
var_0_1.PB_TYPE_WORLD_RESET_TROOP.index = 130
var_0_1.PB_TYPE_WORLD_RESET_TROOP.number = 638
var_0_1.PB_TYPE_WORLD_RESET_LADDER_LOSE.name = "PB_TYPE_WORLD_RESET_LADDER_LOSE"
var_0_1.PB_TYPE_WORLD_RESET_LADDER_LOSE.index = 131
var_0_1.PB_TYPE_WORLD_RESET_LADDER_LOSE.number = 639
var_0_1.PB_TYPE_WORLD_EXPEDITION_EX.name = "PB_TYPE_WORLD_EXPEDITION_EX"
var_0_1.PB_TYPE_WORLD_EXPEDITION_EX.index = 132
var_0_1.PB_TYPE_WORLD_EXPEDITION_EX.number = 640
var_0_1.PB_TYPE_WORLD_GET_EXPEDITION_EX.name = "PB_TYPE_WORLD_GET_EXPEDITION_EX"
var_0_1.PB_TYPE_WORLD_GET_EXPEDITION_EX.index = 133
var_0_1.PB_TYPE_WORLD_GET_EXPEDITION_EX.number = 641
var_0_1.PB_TYPE_WORLD_EXPEDITION_EX_BOSS.name = "PB_TYPE_WORLD_EXPEDITION_EX_BOSS"
var_0_1.PB_TYPE_WORLD_EXPEDITION_EX_BOSS.index = 134
var_0_1.PB_TYPE_WORLD_EXPEDITION_EX_BOSS.number = 642
var_0_1.PB_TYPE_WORLD_LOTTERY.name = "PB_TYPE_WORLD_LOTTERY"
var_0_1.PB_TYPE_WORLD_LOTTERY.index = 135
var_0_1.PB_TYPE_WORLD_LOTTERY.number = 643
var_0_1.PB_TYPE_WORLD_REFRESH_EXPEDITION_EX.name = "PB_TYPE_WORLD_REFRESH_EXPEDITION_EX"
var_0_1.PB_TYPE_WORLD_REFRESH_EXPEDITION_EX.index = 136
var_0_1.PB_TYPE_WORLD_REFRESH_EXPEDITION_EX.number = 644
var_0_1.PB_TYPE_WORLD_BUY_TICKET.name = "PB_TYPE_WORLD_BUY_TICKET"
var_0_1.PB_TYPE_WORLD_BUY_TICKET.index = 137
var_0_1.PB_TYPE_WORLD_BUY_TICKET.number = 645
var_0_1.PB_TYPE_WORLD_SELECT_CHAR.name = "PB_TYPE_WORLD_SELECT_CHAR"
var_0_1.PB_TYPE_WORLD_SELECT_CHAR.index = 138
var_0_1.PB_TYPE_WORLD_SELECT_CHAR.number = 646
var_0_1.PB_TYPE_WORLD_SELECT_CARD.name = "PB_TYPE_WORLD_SELECT_CARD"
var_0_1.PB_TYPE_WORLD_SELECT_CARD.index = 139
var_0_1.PB_TYPE_WORLD_SELECT_CARD.number = 647
var_0_1.PB_TYPE_WORLD_QUIT.name = "PB_TYPE_WORLD_QUIT"
var_0_1.PB_TYPE_WORLD_QUIT.index = 140
var_0_1.PB_TYPE_WORLD_QUIT.number = 648
var_0_1.PB_TYPE_WORLD_CREATE_MATCH.name = "PB_TYPE_WORLD_CREATE_MATCH"
var_0_1.PB_TYPE_WORLD_CREATE_MATCH.index = 141
var_0_1.PB_TYPE_WORLD_CREATE_MATCH.number = 649
var_0_1.PB_TYPE_WORLD_QUERY_MATCH.name = "PB_TYPE_WORLD_QUERY_MATCH"
var_0_1.PB_TYPE_WORLD_QUERY_MATCH.index = 142
var_0_1.PB_TYPE_WORLD_QUERY_MATCH.number = 650
var_0_1.PB_TYPE_WORLD_JOIN_MATCH.name = "PB_TYPE_WORLD_JOIN_MATCH"
var_0_1.PB_TYPE_WORLD_JOIN_MATCH.index = 143
var_0_1.PB_TYPE_WORLD_JOIN_MATCH.number = 651
var_0_1.PB_TYPE_WORLD_QUIT_MATCH.name = "PB_TYPE_WORLD_QUIT_MATCH"
var_0_1.PB_TYPE_WORLD_QUIT_MATCH.index = 144
var_0_1.PB_TYPE_WORLD_QUIT_MATCH.number = 652
var_0_1.PB_TYPE_WORLD_START_MATCH.name = "PB_TYPE_WORLD_START_MATCH"
var_0_1.PB_TYPE_WORLD_START_MATCH.index = 145
var_0_1.PB_TYPE_WORLD_START_MATCH.number = 653
var_0_1.PB_TYPE_WORLD_TOGGLE_MATCH.name = "PB_TYPE_WORLD_TOGGLE_MATCH"
var_0_1.PB_TYPE_WORLD_TOGGLE_MATCH.index = 146
var_0_1.PB_TYPE_WORLD_TOGGLE_MATCH.number = 654
var_0_1.PB_TYPE_WORLD_GET_MATCH.name = "PB_TYPE_WORLD_GET_MATCH"
var_0_1.PB_TYPE_WORLD_GET_MATCH.index = 147
var_0_1.PB_TYPE_WORLD_GET_MATCH.number = 655
var_0_1.PB_TYPE_WORLD_CLOSE_MATCH.name = "PB_TYPE_WORLD_CLOSE_MATCH"
var_0_1.PB_TYPE_WORLD_CLOSE_MATCH.index = 148
var_0_1.PB_TYPE_WORLD_CLOSE_MATCH.number = 656
var_0_1.PB_TYPE_WORLD_RECYCLE_MATCH.name = "PB_TYPE_WORLD_RECYCLE_MATCH"
var_0_1.PB_TYPE_WORLD_RECYCLE_MATCH.index = 149
var_0_1.PB_TYPE_WORLD_RECYCLE_MATCH.number = 657
var_0_1.PB_TYPE_WORLD_LOTTERY_UNOPEN.name = "PB_TYPE_WORLD_LOTTERY_UNOPEN"
var_0_1.PB_TYPE_WORLD_LOTTERY_UNOPEN.index = 150
var_0_1.PB_TYPE_WORLD_LOTTERY_UNOPEN.number = 658
var_0_1.PB_TYPE_WORLD_LOTTERY_OPENED.name = "PB_TYPE_WORLD_LOTTERY_OPENED"
var_0_1.PB_TYPE_WORLD_LOTTERY_OPENED.index = 151
var_0_1.PB_TYPE_WORLD_LOTTERY_OPENED.number = 659
var_0_1.PB_TYPE_WORLD_UPDATE_LOTTERY_INFO.name = "PB_TYPE_WORLD_UPDATE_LOTTERY_INFO"
var_0_1.PB_TYPE_WORLD_UPDATE_LOTTERY_INFO.index = 152
var_0_1.PB_TYPE_WORLD_UPDATE_LOTTERY_INFO.number = 660
var_0_1.PB_TYPE_WORLD_RECOMMEND_TROOP.name = "PB_TYPE_WORLD_RECOMMEND_TROOP"
var_0_1.PB_TYPE_WORLD_RECOMMEND_TROOP.index = 153
var_0_1.PB_TYPE_WORLD_RECOMMEND_TROOP.number = 661
var_0_1.PB_TYPE_WORLD_DARK_DUEL_DASHBOARD.name = "PB_TYPE_WORLD_DARK_DUEL_DASHBOARD"
var_0_1.PB_TYPE_WORLD_DARK_DUEL_DASHBOARD.index = 154
var_0_1.PB_TYPE_WORLD_DARK_DUEL_DASHBOARD.number = 662
var_0_1.PB_TYPE_WORLD_DARK_DUEL_RECHEAT.name = "PB_TYPE_WORLD_DARK_DUEL_RECHEAT"
var_0_1.PB_TYPE_WORLD_DARK_DUEL_RECHEAT.index = 155
var_0_1.PB_TYPE_WORLD_DARK_DUEL_RECHEAT.number = 663
var_0_1.PB_TYPE_WORLD_DAKR_RESET.name = "PB_TYPE_WORLD_DAKR_RESET"
var_0_1.PB_TYPE_WORLD_DAKR_RESET.index = 156
var_0_1.PB_TYPE_WORLD_DAKR_RESET.number = 664
var_0_1.PB_TYPE_WORLD_SELECT_DARK_TROOP.name = "PB_TYPE_WORLD_SELECT_DARK_TROOP"
var_0_1.PB_TYPE_WORLD_SELECT_DARK_TROOP.index = 157
var_0_1.PB_TYPE_WORLD_SELECT_DARK_TROOP.number = 665
var_0_1.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL.name = "PB_TYPE_WORLD_BUY_TICKET_SURVIVAL"
var_0_1.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL.index = 158
var_0_1.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL.number = 666
var_0_1.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL.name = "PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL"
var_0_1.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL.index = 159
var_0_1.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL.number = 667
var_0_1.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL.name = "PB_TYPE_WORLD_SELECT_CARD_SURVIVAL"
var_0_1.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL.index = 160
var_0_1.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL.number = 668
var_0_1.PB_TYPE_WORLD_QUIT_SURVIVAL.name = "PB_TYPE_WORLD_QUIT_SURVIVAL"
var_0_1.PB_TYPE_WORLD_QUIT_SURVIVAL.index = 161
var_0_1.PB_TYPE_WORLD_QUIT_SURVIVAL.number = 669
var_0_1.PB_TYPE_WORLD_FIND_SURVIVAL.name = "PB_TYPE_WORLD_FIND_SURVIVAL"
var_0_1.PB_TYPE_WORLD_FIND_SURVIVAL.index = 162
var_0_1.PB_TYPE_WORLD_FIND_SURVIVAL.number = 670
var_0_1.PB_TYPE_WORLD_JOIN_SURVIVAL.name = "PB_TYPE_WORLD_JOIN_SURVIVAL"
var_0_1.PB_TYPE_WORLD_JOIN_SURVIVAL.index = 163
var_0_1.PB_TYPE_WORLD_JOIN_SURVIVAL.number = 671
var_0_1.PB_TYPE_WORLD_SURVIVAL_HALL_INFO.name = "PB_TYPE_WORLD_SURVIVAL_HALL_INFO"
var_0_1.PB_TYPE_WORLD_SURVIVAL_HALL_INFO.index = 164
var_0_1.PB_TYPE_WORLD_SURVIVAL_HALL_INFO.number = 672
var_0_1.PB_TYPE_WORLD_SURVIVAL_EXPLORE_START.name = "PB_TYPE_WORLD_SURVIVAL_EXPLORE_START"
var_0_1.PB_TYPE_WORLD_SURVIVAL_EXPLORE_START.index = 165
var_0_1.PB_TYPE_WORLD_SURVIVAL_EXPLORE_START.number = 673
var_0_1.PB_TYPE_WORLD_SURVIVAL_EXPLORE_END.name = "PB_TYPE_WORLD_SURVIVAL_EXPLORE_END"
var_0_1.PB_TYPE_WORLD_SURVIVAL_EXPLORE_END.index = 166
var_0_1.PB_TYPE_WORLD_SURVIVAL_EXPLORE_END.number = 674
var_0_1.PB_TYPE_WORLD_SURVIVAL_GAME_OVER.name = "PB_TYPE_WORLD_SURVIVAL_GAME_OVER"
var_0_1.PB_TYPE_WORLD_SURVIVAL_GAME_OVER.index = 167
var_0_1.PB_TYPE_WORLD_SURVIVAL_GAME_OVER.number = 675
var_0_1.PB_TYPE_WORLD_WORSHIP_LIST.name = "PB_TYPE_WORLD_WORSHIP_LIST"
var_0_1.PB_TYPE_WORLD_WORSHIP_LIST.index = 168
var_0_1.PB_TYPE_WORLD_WORSHIP_LIST.number = 676
var_0_1.PB_TYPE_WORLD_WORSHIP.name = "PB_TYPE_WORLD_WORSHIP"
var_0_1.PB_TYPE_WORLD_WORSHIP.index = 169
var_0_1.PB_TYPE_WORLD_WORSHIP.number = 677
var_0_1.PB_TYPE_WORLD_LOTTERY_EX.name = "PB_TYPE_WORLD_LOTTERY_EX"
var_0_1.PB_TYPE_WORLD_LOTTERY_EX.index = 170
var_0_1.PB_TYPE_WORLD_LOTTERY_EX.number = 678
var_0_1.PB_TYPE_WORLD_LEAVE_TEAM.name = "PB_TYPE_WORLD_LEAVE_TEAM"
var_0_1.PB_TYPE_WORLD_LEAVE_TEAM.index = 171
var_0_1.PB_TYPE_WORLD_LEAVE_TEAM.number = 679
var_0_1.PB_TYPE_WORLD_JOIN_TEAM.name = "PB_TYPE_WORLD_JOIN_TEAM"
var_0_1.PB_TYPE_WORLD_JOIN_TEAM.index = 172
var_0_1.PB_TYPE_WORLD_JOIN_TEAM.number = 680
var_0_1.PB_TYPE_WORLD_LOTTERY_ACTIVITY.name = "PB_TYPE_WORLD_LOTTERY_ACTIVITY"
var_0_1.PB_TYPE_WORLD_LOTTERY_ACTIVITY.index = 173
var_0_1.PB_TYPE_WORLD_LOTTERY_ACTIVITY.number = 681
var_0_1.PB_TYPE_WORLD_ROLL_CHAR.name = "PB_TYPE_WORLD_ROLL_CHAR"
var_0_1.PB_TYPE_WORLD_ROLL_CHAR.index = 174
var_0_1.PB_TYPE_WORLD_ROLL_CHAR.number = 682
var_0_1.PB_TYPE_WORLD_GEN_ENVELOPE.name = "PB_TYPE_WORLD_GEN_ENVELOPE"
var_0_1.PB_TYPE_WORLD_GEN_ENVELOPE.index = 175
var_0_1.PB_TYPE_WORLD_GEN_ENVELOPE.number = 683
var_0_1.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX.name = "PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX"
var_0_1.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX.index = 176
var_0_1.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX.number = 684
var_0_1.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX.name = "PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX"
var_0_1.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX.index = 177
var_0_1.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX.number = 685
var_0_1.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX.name = "PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX"
var_0_1.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX.index = 178
var_0_1.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX.number = 686
var_0_1.PB_TYPE_WORLD_QUIT_SURVIVAL_EX.name = "PB_TYPE_WORLD_QUIT_SURVIVAL_EX"
var_0_1.PB_TYPE_WORLD_QUIT_SURVIVAL_EX.index = 179
var_0_1.PB_TYPE_WORLD_QUIT_SURVIVAL_EX.number = 687
var_0_1.PB_TYPE_WORLD_FIND_SURVIVAL_EX.name = "PB_TYPE_WORLD_FIND_SURVIVAL_EX"
var_0_1.PB_TYPE_WORLD_FIND_SURVIVAL_EX.index = 180
var_0_1.PB_TYPE_WORLD_FIND_SURVIVAL_EX.number = 688
var_0_1.PB_TYPE_WORLD_JOIN_SURVIVAL_EX.name = "PB_TYPE_WORLD_JOIN_SURVIVAL_EX"
var_0_1.PB_TYPE_WORLD_JOIN_SURVIVAL_EX.index = 181
var_0_1.PB_TYPE_WORLD_JOIN_SURVIVAL_EX.number = 689
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO.name = "PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO"
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO.index = 182
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO.number = 690
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_START.name = "PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_START"
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_START.index = 183
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_START.number = 691
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_END.name = "PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_END"
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_END.index = 184
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_END.number = 692
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_GAME_OVER.name = "PB_TYPE_WORLD_SURVIVAL_EX_GAME_OVER"
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_GAME_OVER.index = 185
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_GAME_OVER.number = 693
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EQUIP_SKILL.name = "PB_TYPE_WORLD_SURVIVAL_EX_EQUIP_SKILL"
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EQUIP_SKILL.index = 186
var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EQUIP_SKILL.number = 694
var_0_1.PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX.name = "PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX"
var_0_1.PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX.index = 187
var_0_1.PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX.number = 695
var_0_1.PB_TYPE_WORLD_BUY_TICKET_LEGEND.name = "PB_TYPE_WORLD_BUY_TICKET_LEGEND"
var_0_1.PB_TYPE_WORLD_BUY_TICKET_LEGEND.index = 188
var_0_1.PB_TYPE_WORLD_BUY_TICKET_LEGEND.number = 696
var_0_1.PB_TYPE_WORLD_QUIT_LEGEND.name = "PB_TYPE_WORLD_QUIT_LEGEND"
var_0_1.PB_TYPE_WORLD_QUIT_LEGEND.index = 189
var_0_1.PB_TYPE_WORLD_QUIT_LEGEND.number = 697
var_0_1.PB_TYPE_BATTLE_START.name = "PB_TYPE_BATTLE_START"
var_0_1.PB_TYPE_BATTLE_START.index = 190
var_0_1.PB_TYPE_BATTLE_START.number = 700
var_0_1.PB_TYPE_BATTLE_END.name = "PB_TYPE_BATTLE_END"
var_0_1.PB_TYPE_BATTLE_END.index = 191
var_0_1.PB_TYPE_BATTLE_END.number = 701
var_0_1.PB_TYPE_BATTLE_USECARD.name = "PB_TYPE_BATTLE_USECARD"
var_0_1.PB_TYPE_BATTLE_USECARD.index = 192
var_0_1.PB_TYPE_BATTLE_USECARD.number = 702
var_0_1.PB_TYPE_BATTLE_OP_USECARD.name = "PB_TYPE_BATTLE_OP_USECARD"
var_0_1.PB_TYPE_BATTLE_OP_USECARD.index = 193
var_0_1.PB_TYPE_BATTLE_OP_USECARD.number = 703
var_0_1.PB_TYPE_BATTLE_LOG.name = "PB_TYPE_BATTLE_LOG"
var_0_1.PB_TYPE_BATTLE_LOG.index = 194
var_0_1.PB_TYPE_BATTLE_LOG.number = 704
var_0_1.PB_TYPE_BATTLE_REPLAY.name = "PB_TYPE_BATTLE_REPLAY"
var_0_1.PB_TYPE_BATTLE_REPLAY.index = 195
var_0_1.PB_TYPE_BATTLE_REPLAY.number = 705
var_0_1.PB_TYPE_BATTLE_SHARE.name = "PB_TYPE_BATTLE_SHARE"
var_0_1.PB_TYPE_BATTLE_SHARE.index = 196
var_0_1.PB_TYPE_BATTLE_SHARE.number = 706
var_0_1.PB_TYPE_BATTLE_RECOVER.name = "PB_TYPE_BATTLE_RECOVER"
var_0_1.PB_TYPE_BATTLE_RECOVER.index = 197
var_0_1.PB_TYPE_BATTLE_RECOVER.number = 707
var_0_1.PB_TYPE_BATTLE_OP_ONLINE.name = "PB_TYPE_BATTLE_OP_ONLINE"
var_0_1.PB_TYPE_BATTLE_OP_ONLINE.index = 198
var_0_1.PB_TYPE_BATTLE_OP_ONLINE.number = 708
var_0_1.PB_TYPE_BATTLE_OP_OFFLINE.name = "PB_TYPE_BATTLE_OP_OFFLINE"
var_0_1.PB_TYPE_BATTLE_OP_OFFLINE.index = 199
var_0_1.PB_TYPE_BATTLE_OP_OFFLINE.number = 709
var_0_1.PB_TYPE_BATTLE_SYNC.name = "PB_TYPE_BATTLE_SYNC"
var_0_1.PB_TYPE_BATTLE_SYNC.index = 200
var_0_1.PB_TYPE_BATTLE_SYNC.number = 710
var_0_1.PB_TYPE_BATTLE_CHAT.name = "PB_TYPE_BATTLE_CHAT"
var_0_1.PB_TYPE_BATTLE_CHAT.index = 201
var_0_1.PB_TYPE_BATTLE_CHAT.number = 711
var_0_1.PB_TYPE_BATTLE_SKIP.name = "PB_TYPE_BATTLE_SKIP"
var_0_1.PB_TYPE_BATTLE_SKIP.index = 202
var_0_1.PB_TYPE_BATTLE_SKIP.number = 712
var_0_1.PB_TYPE_BATTLE_OP_SKIP.name = "PB_TYPE_BATTLE_OP_SKIP"
var_0_1.PB_TYPE_BATTLE_OP_SKIP.index = 203
var_0_1.PB_TYPE_BATTLE_OP_SKIP.number = 713
var_0_1.PB_TYPE_BATTLE_TUTORIAL.name = "PB_TYPE_BATTLE_TUTORIAL"
var_0_1.PB_TYPE_BATTLE_TUTORIAL.index = 204
var_0_1.PB_TYPE_BATTLE_TUTORIAL.number = 714
var_0_1.PB_TYPE_BATTLE_AGAIN.name = "PB_TYPE_BATTLE_AGAIN"
var_0_1.PB_TYPE_BATTLE_AGAIN.index = 205
var_0_1.PB_TYPE_BATTLE_AGAIN.number = 715
var_0_1.PB_TYPE_BATTLE_RETRY.name = "PB_TYPE_BATTLE_RETRY"
var_0_1.PB_TYPE_BATTLE_RETRY.index = 206
var_0_1.PB_TYPE_BATTLE_RETRY.number = 716
var_0_1.PB_TYPE_BATTLE_REPLAY_TUTORIAL.name = "PB_TYPE_BATTLE_REPLAY_TUTORIAL"
var_0_1.PB_TYPE_BATTLE_REPLAY_TUTORIAL.index = 207
var_0_1.PB_TYPE_BATTLE_REPLAY_TUTORIAL.number = 717
var_0_1.PB_TYPE_BATTLE_THUMBS_UP.name = "PB_TYPE_BATTLE_THUMBS_UP"
var_0_1.PB_TYPE_BATTLE_THUMBS_UP.index = 208
var_0_1.PB_TYPE_BATTLE_THUMBS_UP.number = 718
var_0_1.PB_TYPE_BATTLE_THUMBS_UP_CANCEL.name = "PB_TYPE_BATTLE_THUMBS_UP_CANCEL"
var_0_1.PB_TYPE_BATTLE_THUMBS_UP_CANCEL.index = 209
var_0_1.PB_TYPE_BATTLE_THUMBS_UP_CANCEL.number = 719
var_0_1.PB_TYPE_BATTLE_REPLAY_SHARE.name = "PB_TYPE_BATTLE_REPLAY_SHARE"
var_0_1.PB_TYPE_BATTLE_REPLAY_SHARE.index = 210
var_0_1.PB_TYPE_BATTLE_REPLAY_SHARE.number = 720
var_0_1.PB_TYPE_BATTLE_SHARE_WATCH.name = "PB_TYPE_BATTLE_SHARE_WATCH"
var_0_1.PB_TYPE_BATTLE_SHARE_WATCH.index = 211
var_0_1.PB_TYPE_BATTLE_SHARE_WATCH.number = 721
var_0_1.PB_TYPE_BATTLE_ERROR.name = "PB_TYPE_BATTLE_ERROR"
var_0_1.PB_TYPE_BATTLE_ERROR.index = 212
var_0_1.PB_TYPE_BATTLE_ERROR.number = 722
var_0_1.PB_TYPE_BATTLE_LOADING_DONE.name = "PB_TYPE_BATTLE_LOADING_DONE"
var_0_1.PB_TYPE_BATTLE_LOADING_DONE.index = 213
var_0_1.PB_TYPE_BATTLE_LOADING_DONE.number = 723
var_0_1.PB_TYPE_BATTLE_LOG_EX.name = "PB_TYPE_BATTLE_LOG_EX"
var_0_1.PB_TYPE_BATTLE_LOG_EX.index = 214
var_0_1.PB_TYPE_BATTLE_LOG_EX.number = 724
var_0_1.PB_TYPE_BATTLE_REPLAY_EX.name = "PB_TYPE_BATTLE_REPLAY_EX"
var_0_1.PB_TYPE_BATTLE_REPLAY_EX.index = 215
var_0_1.PB_TYPE_BATTLE_REPLAY_EX.number = 725
var_0_1.PB_TYPE_BATTLE_OP_CHAT.name = "PB_TYPE_BATTLE_OP_CHAT"
var_0_1.PB_TYPE_BATTLE_OP_CHAT.index = 216
var_0_1.PB_TYPE_BATTLE_OP_CHAT.number = 726
var_0_1.PB_TYPE_BATTLE_SET_MATCH_HP.name = "PB_TYPE_BATTLE_SET_MATCH_HP"
var_0_1.PB_TYPE_BATTLE_SET_MATCH_HP.index = 217
var_0_1.PB_TYPE_BATTLE_SET_MATCH_HP.number = 727
var_0_1.PB_TYPE_TROOP_RELOAD.name = "PB_TYPE_TROOP_RELOAD"
var_0_1.PB_TYPE_TROOP_RELOAD.index = 218
var_0_1.PB_TYPE_TROOP_RELOAD.number = 800
var_0_1.PB_TYPE_TROOP_MARK.name = "PB_TYPE_TROOP_MARK"
var_0_1.PB_TYPE_TROOP_MARK.index = 219
var_0_1.PB_TYPE_TROOP_MARK.number = 801
var_0_1.PB_TYPE_TROOP_UNLOCK.name = "PB_TYPE_TROOP_UNLOCK"
var_0_1.PB_TYPE_TROOP_UNLOCK.index = 220
var_0_1.PB_TYPE_TROOP_UNLOCK.number = 802
var_0_1.PB_TYPE_FRIEND_SEARCH.name = "PB_TYPE_FRIEND_SEARCH"
var_0_1.PB_TYPE_FRIEND_SEARCH.index = 221
var_0_1.PB_TYPE_FRIEND_SEARCH.number = 900
var_0_1.PB_TYPE_FRIEND_RECOMMEND.name = "PB_TYPE_FRIEND_RECOMMEND"
var_0_1.PB_TYPE_FRIEND_RECOMMEND.index = 222
var_0_1.PB_TYPE_FRIEND_RECOMMEND.number = 901
var_0_1.PB_TYPE_FRIEND_INVITE.name = "PB_TYPE_FRIEND_INVITE"
var_0_1.PB_TYPE_FRIEND_INVITE.index = 223
var_0_1.PB_TYPE_FRIEND_INVITE.number = 902
var_0_1.PB_TYPE_FRIEND_ACCEPT.name = "PB_TYPE_FRIEND_ACCEPT"
var_0_1.PB_TYPE_FRIEND_ACCEPT.index = 224
var_0_1.PB_TYPE_FRIEND_ACCEPT.number = 903
var_0_1.PB_TYPE_FRIEND_REMOVE.name = "PB_TYPE_FRIEND_REMOVE"
var_0_1.PB_TYPE_FRIEND_REMOVE.index = 225
var_0_1.PB_TYPE_FRIEND_REMOVE.number = 904
var_0_1.PB_TYPE_FRIEND_LIST.name = "PB_TYPE_FRIEND_LIST"
var_0_1.PB_TYPE_FRIEND_LIST.index = 226
var_0_1.PB_TYPE_FRIEND_LIST.number = 905
var_0_1.PB_TYPE_FRIEND_ACCEPTED.name = "PB_TYPE_FRIEND_ACCEPTED"
var_0_1.PB_TYPE_FRIEND_ACCEPTED.index = 227
var_0_1.PB_TYPE_FRIEND_ACCEPTED.number = 906
var_0_1.PB_TYPE_FRIEND_REMOVED.name = "PB_TYPE_FRIEND_REMOVED"
var_0_1.PB_TYPE_FRIEND_REMOVED.index = 228
var_0_1.PB_TYPE_FRIEND_REMOVED.number = 907
var_0_1.PB_TYPE_FRIEND_BATTLE.name = "PB_TYPE_FRIEND_BATTLE"
var_0_1.PB_TYPE_FRIEND_BATTLE.index = 229
var_0_1.PB_TYPE_FRIEND_BATTLE.number = 908
var_0_1.PB_TYPE_FRIEND_BATTLE_START.name = "PB_TYPE_FRIEND_BATTLE_START"
var_0_1.PB_TYPE_FRIEND_BATTLE_START.index = 230
var_0_1.PB_TYPE_FRIEND_BATTLE_START.number = 909
var_0_1.PB_TYPE_FRIEND_BATTLE_END.name = "PB_TYPE_FRIEND_BATTLE_END"
var_0_1.PB_TYPE_FRIEND_BATTLE_END.index = 231
var_0_1.PB_TYPE_FRIEND_BATTLE_END.number = 910
var_0_1.PB_TYPE_FRIEND_BATTLE_JOIN.name = "PB_TYPE_FRIEND_BATTLE_JOIN"
var_0_1.PB_TYPE_FRIEND_BATTLE_JOIN.index = 232
var_0_1.PB_TYPE_FRIEND_BATTLE_JOIN.number = 911
var_0_1.PB_TYPE_FRIEND_SEARCH_EX.name = "PB_TYPE_FRIEND_SEARCH_EX"
var_0_1.PB_TYPE_FRIEND_SEARCH_EX.index = 233
var_0_1.PB_TYPE_FRIEND_SEARCH_EX.number = 912
var_0_1.PB_TYPE_FRIEND_BATTLE_CANCEL.name = "PB_TYPE_FRIEND_BATTLE_CANCEL"
var_0_1.PB_TYPE_FRIEND_BATTLE_CANCEL.index = 234
var_0_1.PB_TYPE_FRIEND_BATTLE_CANCEL.number = 913
var_0_1.PB_TYPE_FRIEND_BATTLE_UPDATE.name = "PB_TYPE_FRIEND_BATTLE_UPDATE"
var_0_1.PB_TYPE_FRIEND_BATTLE_UPDATE.index = 235
var_0_1.PB_TYPE_FRIEND_BATTLE_UPDATE.number = 914
var_0_1.PB_TYPE_MAIL_LIST.name = "PB_TYPE_MAIL_LIST"
var_0_1.PB_TYPE_MAIL_LIST.index = 236
var_0_1.PB_TYPE_MAIL_LIST.number = 1000
var_0_1.PB_TYPE_MAIL_SEND.name = "PB_TYPE_MAIL_SEND"
var_0_1.PB_TYPE_MAIL_SEND.index = 237
var_0_1.PB_TYPE_MAIL_SEND.number = 1001
var_0_1.PB_TYPE_MAIL_RECEIVE.name = "PB_TYPE_MAIL_RECEIVE"
var_0_1.PB_TYPE_MAIL_RECEIVE.index = 238
var_0_1.PB_TYPE_MAIL_RECEIVE.number = 1002
var_0_1.PB_TYPE_CHAT.name = "PB_TYPE_CHAT"
var_0_1.PB_TYPE_CHAT.index = 239
var_0_1.PB_TYPE_CHAT.number = 1100
var_0_1.PB_TYPE_BONUS_ACTIVITY.name = "PB_TYPE_BONUS_ACTIVITY"
var_0_1.PB_TYPE_BONUS_ACTIVITY.index = 240
var_0_1.PB_TYPE_BONUS_ACTIVITY.number = 1200
var_0_1.PB_TYPE_BONUS_CLAIM.name = "PB_TYPE_BONUS_CLAIM"
var_0_1.PB_TYPE_BONUS_CLAIM.index = 241
var_0_1.PB_TYPE_BONUS_CLAIM.number = 1201
var_0_1.PB_TYPE_BONUS_ACTIVITY_CLAIM.name = "PB_TYPE_BONUS_ACTIVITY_CLAIM"
var_0_1.PB_TYPE_BONUS_ACTIVITY_CLAIM.index = 242
var_0_1.PB_TYPE_BONUS_ACTIVITY_CLAIM.number = 1202
var_0_1.PB_TYPE_BONUS_RE_CHECK_CLAIM.name = "PB_TYPE_BONUS_RE_CHECK_CLAIM"
var_0_1.PB_TYPE_BONUS_RE_CHECK_CLAIM.index = 243
var_0_1.PB_TYPE_BONUS_RE_CHECK_CLAIM.number = 1203
var_0_1.PB_TYPE_BONUS_ONLINE_CLAIM.name = "PB_TYPE_BONUS_ONLINE_CLAIM"
var_0_1.PB_TYPE_BONUS_ONLINE_CLAIM.index = 244
var_0_1.PB_TYPE_BONUS_ONLINE_CLAIM.number = 1204
var_0_1.PB_TYPE_BONUS_ACTIVITY_EX_CLAIM.name = "PB_TYPE_BONUS_ACTIVITY_EX_CLAIM"
var_0_1.PB_TYPE_BONUS_ACTIVITY_EX_CLAIM.index = 245
var_0_1.PB_TYPE_BONUS_ACTIVITY_EX_CLAIM.number = 1205
var_0_1.PB_TYPE_BONUS_PLAYER_BONUS.name = "PB_TYPE_BONUS_PLAYER_BONUS"
var_0_1.PB_TYPE_BONUS_PLAYER_BONUS.index = 246
var_0_1.PB_TYPE_BONUS_PLAYER_BONUS.number = 1206
var_0_1.PB_TYPE_BONUS_PLAYER_BONUS_AVAILABLE.name = "PB_TYPE_BONUS_PLAYER_BONUS_AVAILABLE"
var_0_1.PB_TYPE_BONUS_PLAYER_BONUS_AVAILABLE.index = 247
var_0_1.PB_TYPE_BONUS_PLAYER_BONUS_AVAILABLE.number = 1207
var_0_1.PB_TYPE_BONUS_TEACHING_FINISH.name = "PB_TYPE_BONUS_TEACHING_FINISH"
var_0_1.PB_TYPE_BONUS_TEACHING_FINISH.index = 248
var_0_1.PB_TYPE_BONUS_TEACHING_FINISH.number = 1208
var_0_1.PB_TYPE_BONUS_DAILY_TASK_RESET.name = "PB_TYPE_BONUS_DAILY_TASK_RESET"
var_0_1.PB_TYPE_BONUS_DAILY_TASK_RESET.index = 249
var_0_1.PB_TYPE_BONUS_DAILY_TASK_RESET.number = 1209
var_0_1.PB_TYPE_BONUS_DAILY_TASK.name = "PB_TYPE_BONUS_DAILY_TASK"
var_0_1.PB_TYPE_BONUS_DAILY_TASK.index = 250
var_0_1.PB_TYPE_BONUS_DAILY_TASK.number = 1210
var_0_1.PB_TYPE_BONUS_GIFT.name = "PB_TYPE_BONUS_GIFT"
var_0_1.PB_TYPE_BONUS_GIFT.index = 251
var_0_1.PB_TYPE_BONUS_GIFT.number = 1211
var_0_1.PB_TYPE_BONUS_ENVELOPE_AVAILABLE.name = "PB_TYPE_BONUS_ENVELOPE_AVAILABLE"
var_0_1.PB_TYPE_BONUS_ENVELOPE_AVAILABLE.index = 252
var_0_1.PB_TYPE_BONUS_ENVELOPE_AVAILABLE.number = 1212
var_0_1.PB_TYPE_BONUS_CLAIM_ENVELOPE.name = "PB_TYPE_BONUS_CLAIM_ENVELOPE"
var_0_1.PB_TYPE_BONUS_CLAIM_ENVELOPE.index = 253
var_0_1.PB_TYPE_BONUS_CLAIM_ENVELOPE.number = 1213
var_0_1.PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS.name = "PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS"
var_0_1.PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS.index = 254
var_0_1.PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS.number = 1214
var_0_1.PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE.name = "PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE"
var_0_1.PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE.index = 255
var_0_1.PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE.number = 1215
var_0_1.PB_TYPE_BONUS_CHARGE_ENVELOPE_AVAILABLE.name = "PB_TYPE_BONUS_CHARGE_ENVELOPE_AVAILABLE"
var_0_1.PB_TYPE_BONUS_CHARGE_ENVELOPE_AVAILABLE.index = 256
var_0_1.PB_TYPE_BONUS_CHARGE_ENVELOPE_AVAILABLE.number = 1216
var_0_1.PB_TYPE_FEEDBACK.name = "PB_TYPE_FEEDBACK"
var_0_1.PB_TYPE_FEEDBACK.index = 257
var_0_1.PB_TYPE_FEEDBACK.number = 1300
var_0_1.PB_TYPE_IAP_START.name = "PB_TYPE_IAP_START"
var_0_1.PB_TYPE_IAP_START.index = 258
var_0_1.PB_TYPE_IAP_START.number = 1400
var_0_1.PB_TYPE_IAP_FINISH.name = "PB_TYPE_IAP_FINISH"
var_0_1.PB_TYPE_IAP_FINISH.index = 259
var_0_1.PB_TYPE_IAP_FINISH.number = 1401
var_0_1.PB_TYPE_BUY_GOLD.name = "PB_TYPE_BUY_GOLD"
var_0_1.PB_TYPE_BUY_GOLD.index = 260
var_0_1.PB_TYPE_BUY_GOLD.number = 1402
var_0_1.PB_TYPE_BUY_GRAIN.name = "PB_TYPE_BUY_GRAIN"
var_0_1.PB_TYPE_BUY_GRAIN.index = 261
var_0_1.PB_TYPE_BUY_GRAIN.number = 1403
var_0_1.PB_TYPE_BUY_DAILY.name = "PB_TYPE_BUY_DAILY"
var_0_1.PB_TYPE_BUY_DAILY.index = 262
var_0_1.PB_TYPE_BUY_DAILY.number = 1404
var_0_1.PB_TYPE_BUY_FUND.name = "PB_TYPE_BUY_FUND"
var_0_1.PB_TYPE_BUY_FUND.index = 263
var_0_1.PB_TYPE_BUY_FUND.number = 1405
var_0_1.PB_TYPE_BUY_DUST.name = "PB_TYPE_BUY_DUST"
var_0_1.PB_TYPE_BUY_DUST.index = 264
var_0_1.PB_TYPE_BUY_DUST.number = 1406
var_0_1.PB_TYPE_BUY_BADGE.name = "PB_TYPE_BUY_BADGE"
var_0_1.PB_TYPE_BUY_BADGE.index = 265
var_0_1.PB_TYPE_BUY_BADGE.number = 1407
var_0_1.PB_TYPE_BUY_BADGE_LEVEL.name = "PB_TYPE_BUY_BADGE_LEVEL"
var_0_1.PB_TYPE_BUY_BADGE_LEVEL.index = 266
var_0_1.PB_TYPE_BUY_BADGE_LEVEL.number = 1408
var_0_1.PB_TYPE_BUY_SPRING_BADGE_LEVEL.name = "PB_TYPE_BUY_SPRING_BADGE_LEVEL"
var_0_1.PB_TYPE_BUY_SPRING_BADGE_LEVEL.index = 267
var_0_1.PB_TYPE_BUY_SPRING_BADGE_LEVEL.number = 1409
var_0_1.PB_TYPE_BUY_SPRING2_BADGE_LEVEL.name = "PB_TYPE_BUY_SPRING2_BADGE_LEVEL"
var_0_1.PB_TYPE_BUY_SPRING2_BADGE_LEVEL.index = 268
var_0_1.PB_TYPE_BUY_SPRING2_BADGE_LEVEL.number = 1410
var_0_1.PB_TYPE_SHOP_BUY.name = "PB_TYPE_SHOP_BUY"
var_0_1.PB_TYPE_SHOP_BUY.index = 269
var_0_1.PB_TYPE_SHOP_BUY.number = 1501
var_0_1.PB_TYPE_SHOP_REFRESH.name = "PB_TYPE_SHOP_REFRESH"
var_0_1.PB_TYPE_SHOP_REFRESH.index = 270
var_0_1.PB_TYPE_SHOP_REFRESH.number = 1502
var_0_1.PB_TYPE_SHOP_EXCHANGE.name = "PB_TYPE_SHOP_EXCHANGE"
var_0_1.PB_TYPE_SHOP_EXCHANGE.index = 271
var_0_1.PB_TYPE_SHOP_EXCHANGE.number = 1503
var_0_1.PB_TYPE_SHOP_BUY_PVP.name = "PB_TYPE_SHOP_BUY_PVP"
var_0_1.PB_TYPE_SHOP_BUY_PVP.index = 272
var_0_1.PB_TYPE_SHOP_BUY_PVP.number = 1504
var_0_1.PB_TYPE_SHOP_OPEN.name = "PB_TYPE_SHOP_OPEN"
var_0_1.PB_TYPE_SHOP_OPEN.index = 273
var_0_1.PB_TYPE_SHOP_OPEN.number = 1505
var_0_1.PB_TYPE_SHOP_REFRESH_PVP.name = "PB_TYPE_SHOP_REFRESH_PVP"
var_0_1.PB_TYPE_SHOP_REFRESH_PVP.index = 274
var_0_1.PB_TYPE_SHOP_REFRESH_PVP.number = 1506
var_0_1.PB_TYPE_SHOP_REFRESH_ALL.name = "PB_TYPE_SHOP_REFRESH_ALL"
var_0_1.PB_TYPE_SHOP_REFRESH_ALL.index = 275
var_0_1.PB_TYPE_SHOP_REFRESH_ALL.number = 1507
var_0_1.PB_TYPE_SHOP_REFRESH_PVP_EX.name = "PB_TYPE_SHOP_REFRESH_PVP_EX"
var_0_1.PB_TYPE_SHOP_REFRESH_PVP_EX.index = 276
var_0_1.PB_TYPE_SHOP_REFRESH_PVP_EX.number = 1508
var_0_1.PB_TYPE_SHOP_REFRESH_EX.name = "PB_TYPE_SHOP_REFRESH_EX"
var_0_1.PB_TYPE_SHOP_REFRESH_EX.index = 277
var_0_1.PB_TYPE_SHOP_REFRESH_EX.number = 1509
var_0_1.PB_TYPE_SHOP_BUY_LADDER.name = "PB_TYPE_SHOP_BUY_LADDER"
var_0_1.PB_TYPE_SHOP_BUY_LADDER.index = 278
var_0_1.PB_TYPE_SHOP_BUY_LADDER.number = 1510
var_0_1.PB_TYPE_SHOP_REFRESH_LADDER.name = "PB_TYPE_SHOP_REFRESH_LADDER"
var_0_1.PB_TYPE_SHOP_REFRESH_LADDER.index = 279
var_0_1.PB_TYPE_SHOP_REFRESH_LADDER.number = 1511
var_0_1.PB_TYPE_SHOP_REFRESH_LADDER_EX.name = "PB_TYPE_SHOP_REFRESH_LADDER_EX"
var_0_1.PB_TYPE_SHOP_REFRESH_LADDER_EX.index = 280
var_0_1.PB_TYPE_SHOP_REFRESH_LADDER_EX.number = 1512
var_0_1.PB_TYPE_SHOP_GIFT.name = "PB_TYPE_SHOP_GIFT"
var_0_1.PB_TYPE_SHOP_GIFT.index = 281
var_0_1.PB_TYPE_SHOP_GIFT.number = 1513
var_0_1.PB_TYPE_SHOP_BUY_GIFT.name = "PB_TYPE_SHOP_BUY_GIFT"
var_0_1.PB_TYPE_SHOP_BUY_GIFT.index = 282
var_0_1.PB_TYPE_SHOP_BUY_GIFT.number = 1514
var_0_1.PB_TYPE_SHOP_MAGICBOX.name = "PB_TYPE_SHOP_MAGICBOX"
var_0_1.PB_TYPE_SHOP_MAGICBOX.index = 283
var_0_1.PB_TYPE_SHOP_MAGICBOX.number = 1515
var_0_1.PB_TYPE_SHOP_UNION.name = "PB_TYPE_SHOP_UNION"
var_0_1.PB_TYPE_SHOP_UNION.index = 284
var_0_1.PB_TYPE_SHOP_UNION.number = 1516
var_0_1.PB_TYPE_SHOP_SKIN.name = "PB_TYPE_SHOP_SKIN"
var_0_1.PB_TYPE_SHOP_SKIN.index = 285
var_0_1.PB_TYPE_SHOP_SKIN.number = 1517
var_0_1.PB_TYPE_SHOP_RARE.name = "PB_TYPE_SHOP_RARE"
var_0_1.PB_TYPE_SHOP_RARE.index = 286
var_0_1.PB_TYPE_SHOP_RARE.number = 1518
var_0_1.PB_TYPE_SHOP_LEGEND.name = "PB_TYPE_SHOP_LEGEND"
var_0_1.PB_TYPE_SHOP_LEGEND.index = 287
var_0_1.PB_TYPE_SHOP_LEGEND.number = 1519
var_0_1.PB_TYPE_SHOP_DIAMOND.name = "PB_TYPE_SHOP_DIAMOND"
var_0_1.PB_TYPE_SHOP_DIAMOND.index = 288
var_0_1.PB_TYPE_SHOP_DIAMOND.number = 1520
var_0_1.PB_TYPE_SHOP_EXCHANGE_PROP.name = "PB_TYPE_SHOP_EXCHANGE_PROP"
var_0_1.PB_TYPE_SHOP_EXCHANGE_PROP.index = 289
var_0_1.PB_TYPE_SHOP_EXCHANGE_PROP.number = 1521
var_0_1.PB_TYPE_SHOP_ANCIENT.name = "PB_TYPE_SHOP_ANCIENT"
var_0_1.PB_TYPE_SHOP_ANCIENT.index = 290
var_0_1.PB_TYPE_SHOP_ANCIENT.number = 1522
var_0_1.PB_TYPE_SHOP_VOTE.name = "PB_TYPE_SHOP_VOTE"
var_0_1.PB_TYPE_SHOP_VOTE.index = 291
var_0_1.PB_TYPE_SHOP_VOTE.number = 1523
var_0_1.PB_TYPE_SHOP_VOTE_COUNT.name = "PB_TYPE_SHOP_VOTE_COUNT"
var_0_1.PB_TYPE_SHOP_VOTE_COUNT.index = 292
var_0_1.PB_TYPE_SHOP_VOTE_COUNT.number = 1524
var_0_1.PB_TYPE_SHOP_RECYCLE.name = "PB_TYPE_SHOP_RECYCLE"
var_0_1.PB_TYPE_SHOP_RECYCLE.index = 293
var_0_1.PB_TYPE_SHOP_RECYCLE.number = 1525
var_0_1.PB_TYPE_SHOP_COLLECTION.name = "PB_TYPE_SHOP_COLLECTION"
var_0_1.PB_TYPE_SHOP_COLLECTION.index = 294
var_0_1.PB_TYPE_SHOP_COLLECTION.number = 1526
var_0_1.PB_TYPE_SHOP_REVELRY.name = "PB_TYPE_SHOP_REVELRY"
var_0_1.PB_TYPE_SHOP_REVELRY.index = 295
var_0_1.PB_TYPE_SHOP_REVELRY.number = 1527
var_0_1.PB_TYPE_SHOP_RUBBING.name = "PB_TYPE_SHOP_RUBBING"
var_0_1.PB_TYPE_SHOP_RUBBING.index = 296
var_0_1.PB_TYPE_SHOP_RUBBING.number = 1528
var_0_1.PB_TYPE_SHOP_BADGE.name = "PB_TYPE_SHOP_BADGE"
var_0_1.PB_TYPE_SHOP_BADGE.index = 297
var_0_1.PB_TYPE_SHOP_BADGE.number = 1529
var_0_1.PB_TYPE_SHOP_PRIVILEGE.name = "PB_TYPE_SHOP_PRIVILEGE"
var_0_1.PB_TYPE_SHOP_PRIVILEGE.index = 298
var_0_1.PB_TYPE_SHOP_PRIVILEGE.number = 1530
var_0_1.PB_TYPE_NEWS.name = "PB_TYPE_NEWS"
var_0_1.PB_TYPE_NEWS.index = 299
var_0_1.PB_TYPE_NEWS.number = 1600
var_0_1.PB_TYPE_NEWS_ANNOUNCEMENT.name = "PB_TYPE_NEWS_ANNOUNCEMENT"
var_0_1.PB_TYPE_NEWS_ANNOUNCEMENT.index = 300
var_0_1.PB_TYPE_NEWS_ANNOUNCEMENT.number = 1601
var_0_1.PB_TYPE_RANK_TROPHY.name = "PB_TYPE_RANK_TROPHY"
var_0_1.PB_TYPE_RANK_TROPHY.index = 301
var_0_1.PB_TYPE_RANK_TROPHY.number = 1700
var_0_1.PB_TYPE_RANK_LEVEL.name = "PB_TYPE_RANK_LEVEL"
var_0_1.PB_TYPE_RANK_LEVEL.index = 302
var_0_1.PB_TYPE_RANK_LEVEL.number = 1701
var_0_1.PB_TYPE_RANK_STAR.name = "PB_TYPE_RANK_STAR"
var_0_1.PB_TYPE_RANK_STAR.index = 303
var_0_1.PB_TYPE_RANK_STAR.number = 1702
var_0_1.PB_TYPE_RANK_BOSS.name = "PB_TYPE_RANK_BOSS"
var_0_1.PB_TYPE_RANK_BOSS.index = 304
var_0_1.PB_TYPE_RANK_BOSS.number = 1703
var_0_1.PB_TYPE_RANK_UNION_LEVEL.name = "PB_TYPE_RANK_UNION_LEVEL"
var_0_1.PB_TYPE_RANK_UNION_LEVEL.index = 305
var_0_1.PB_TYPE_RANK_UNION_LEVEL.number = 1704
var_0_1.PB_TYPE_RANK_POWER.name = "PB_TYPE_RANK_POWER"
var_0_1.PB_TYPE_RANK_POWER.index = 306
var_0_1.PB_TYPE_RANK_POWER.number = 1705
var_0_1.PB_TYPE_RANK_UBOSS_SCORE.name = "PB_TYPE_RANK_UBOSS_SCORE"
var_0_1.PB_TYPE_RANK_UBOSS_SCORE.index = 307
var_0_1.PB_TYPE_RANK_UBOSS_SCORE.number = 1706
var_0_1.PB_TYPE_RANK_UBOSS_TIME.name = "PB_TYPE_RANK_UBOSS_TIME"
var_0_1.PB_TYPE_RANK_UBOSS_TIME.index = 308
var_0_1.PB_TYPE_RANK_UBOSS_TIME.number = 1707
var_0_1.PB_TYPE_RANK_LADDER.name = "PB_TYPE_RANK_LADDER"
var_0_1.PB_TYPE_RANK_LADDER.index = 309
var_0_1.PB_TYPE_RANK_LADDER.number = 1708
var_0_1.PB_TYPE_RANK_PRE.name = "PB_TYPE_RANK_PRE"
var_0_1.PB_TYPE_RANK_PRE.index = 310
var_0_1.PB_TYPE_RANK_PRE.number = 1709
var_0_1.PB_TYPE_RANK_POINT.name = "PB_TYPE_RANK_POINT"
var_0_1.PB_TYPE_RANK_POINT.index = 311
var_0_1.PB_TYPE_RANK_POINT.number = 1710
var_0_1.PB_TYPE_RANK_CONSUME.name = "PB_TYPE_RANK_CONSUME"
var_0_1.PB_TYPE_RANK_CONSUME.index = 312
var_0_1.PB_TYPE_RANK_CONSUME.number = 1711
var_0_1.PB_TYPE_RANK_LADDER_EX.name = "PB_TYPE_RANK_LADDER_EX"
var_0_1.PB_TYPE_RANK_LADDER_EX.index = 313
var_0_1.PB_TYPE_RANK_LADDER_EX.number = 1712
var_0_1.PB_TYPE_RANK_PRE_EX.name = "PB_TYPE_RANK_PRE_EX"
var_0_1.PB_TYPE_RANK_PRE_EX.index = 314
var_0_1.PB_TYPE_RANK_PRE_EX.number = 1713
var_0_1.PB_TYPE_RANK_CHAR_LEVEL.name = "PB_TYPE_RANK_CHAR_LEVEL"
var_0_1.PB_TYPE_RANK_CHAR_LEVEL.index = 315
var_0_1.PB_TYPE_RANK_CHAR_LEVEL.number = 1714
var_0_1.PB_TYPE_RANK_UNION_TROPHY.name = "PB_TYPE_RANK_UNION_TROPHY"
var_0_1.PB_TYPE_RANK_UNION_TROPHY.index = 316
var_0_1.PB_TYPE_RANK_UNION_TROPHY.number = 1715
var_0_1.PB_TYPE_RANK_RESET.name = "PB_TYPE_RANK_RESET"
var_0_1.PB_TYPE_RANK_RESET.index = 317
var_0_1.PB_TYPE_RANK_RESET.number = 1716
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP.name = "PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP"
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP.index = 318
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP.number = 1717
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM.name = "PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM"
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM.index = 319
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM.number = 1718
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE.name = "PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE"
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE.index = 320
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE.number = 1719
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP.name = "PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP"
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP.index = 321
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP.number = 1720
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM.name = "PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM"
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM.index = 322
var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM.number = 1721
var_0_1.PB_TYPE_RANK_DARK_PRE.name = "PB_TYPE_RANK_DARK_PRE"
var_0_1.PB_TYPE_RANK_DARK_PRE.index = 323
var_0_1.PB_TYPE_RANK_DARK_PRE.number = 1722
var_0_1.PB_TYPE_RANK_DARK.name = "PB_TYPE_RANK_DARK"
var_0_1.PB_TYPE_RANK_DARK.index = 324
var_0_1.PB_TYPE_RANK_DARK.number = 1723
var_0_1.PB_TYPE_RANK_ENVELOPE.name = "PB_TYPE_RANK_ENVELOPE"
var_0_1.PB_TYPE_RANK_ENVELOPE.index = 325
var_0_1.PB_TYPE_RANK_ENVELOPE.number = 1724
var_0_1.PB_TYPE_RANK_TROPHY_EVENT.name = "PB_TYPE_RANK_TROPHY_EVENT"
var_0_1.PB_TYPE_RANK_TROPHY_EVENT.index = 326
var_0_1.PB_TYPE_RANK_TROPHY_EVENT.number = 1725
var_0_1.PB_TYPE_RANK_TROPHY_ACTIVITY.name = "PB_TYPE_RANK_TROPHY_ACTIVITY"
var_0_1.PB_TYPE_RANK_TROPHY_ACTIVITY.index = 327
var_0_1.PB_TYPE_RANK_TROPHY_ACTIVITY.number = 1727
var_0_1.PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY.name = "PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY"
var_0_1.PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY.index = 328
var_0_1.PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY.number = 1728
var_0_1.PB_TYPE_RANK_LEGEND_PRE.name = "PB_TYPE_RANK_LEGEND_PRE"
var_0_1.PB_TYPE_RANK_LEGEND_PRE.index = 329
var_0_1.PB_TYPE_RANK_LEGEND_PRE.number = 1729
var_0_1.PB_TYPE_RANK_LEGEND.name = "PB_TYPE_RANK_LEGEND"
var_0_1.PB_TYPE_RANK_LEGEND.index = 330
var_0_1.PB_TYPE_RANK_LEGEND.number = 1730
var_0_1.PB_TYPE_REGION_LIST.name = "PB_TYPE_REGION_LIST"
var_0_1.PB_TYPE_REGION_LIST.index = 331
var_0_1.PB_TYPE_REGION_LIST.number = 1900
var_0_1.PB_TYPE_REGION_GROUP.name = "PB_TYPE_REGION_GROUP"
var_0_1.PB_TYPE_REGION_GROUP.index = 332
var_0_1.PB_TYPE_REGION_GROUP.number = 1901
var_0_1.PB_TYPE_REGION_GROUP_EX.name = "PB_TYPE_REGION_GROUP_EX"
var_0_1.PB_TYPE_REGION_GROUP_EX.index = 333
var_0_1.PB_TYPE_REGION_GROUP_EX.number = 1902
var_0_1.PB_TYPE_UNION_CREATE.name = "PB_TYPE_UNION_CREATE"
var_0_1.PB_TYPE_UNION_CREATE.index = 334
var_0_1.PB_TYPE_UNION_CREATE.number = 2000
var_0_1.PB_TYPE_UNION_INVITE.name = "PB_TYPE_UNION_INVITE"
var_0_1.PB_TYPE_UNION_INVITE.index = 335
var_0_1.PB_TYPE_UNION_INVITE.number = 2001
var_0_1.PB_TYPE_UNION_APPLY.name = "PB_TYPE_UNION_APPLY"
var_0_1.PB_TYPE_UNION_APPLY.index = 336
var_0_1.PB_TYPE_UNION_APPLY.number = 2002
var_0_1.PB_TYPE_UNION_KICKOUT.name = "PB_TYPE_UNION_KICKOUT"
var_0_1.PB_TYPE_UNION_KICKOUT.index = 337
var_0_1.PB_TYPE_UNION_KICKOUT.number = 2003
var_0_1.PB_TYPE_UNION_LEAVE.name = "PB_TYPE_UNION_LEAVE"
var_0_1.PB_TYPE_UNION_LEAVE.index = 338
var_0_1.PB_TYPE_UNION_LEAVE.number = 2004
var_0_1.PB_TYPE_UNION_ACCEPT_INVITE.name = "PB_TYPE_UNION_ACCEPT_INVITE"
var_0_1.PB_TYPE_UNION_ACCEPT_INVITE.index = 339
var_0_1.PB_TYPE_UNION_ACCEPT_INVITE.number = 2005
var_0_1.PB_TYPE_UNION_ACCEPT_APPLY.name = "PB_TYPE_UNION_ACCEPT_APPLY"
var_0_1.PB_TYPE_UNION_ACCEPT_APPLY.index = 340
var_0_1.PB_TYPE_UNION_ACCEPT_APPLY.number = 2006
var_0_1.PB_TYPE_UNION_SEARCH.name = "PB_TYPE_UNION_SEARCH"
var_0_1.PB_TYPE_UNION_SEARCH.index = 341
var_0_1.PB_TYPE_UNION_SEARCH.number = 2007
var_0_1.PB_TYPE_UNION_DETAIL.name = "PB_TYPE_UNION_DETAIL"
var_0_1.PB_TYPE_UNION_DETAIL.index = 342
var_0_1.PB_TYPE_UNION_DETAIL.number = 2008
var_0_1.PB_TYPE_UNION_JOIN.name = "PB_TYPE_UNION_JOIN"
var_0_1.PB_TYPE_UNION_JOIN.index = 343
var_0_1.PB_TYPE_UNION_JOIN.number = 2009
var_0_1.PB_TYPE_UNION_MESSAGE.name = "PB_TYPE_UNION_MESSAGE"
var_0_1.PB_TYPE_UNION_MESSAGE.index = 344
var_0_1.PB_TYPE_UNION_MESSAGE.number = 2010
var_0_1.PB_TYPE_UNION_EDIT.name = "PB_TYPE_UNION_EDIT"
var_0_1.PB_TYPE_UNION_EDIT.index = 345
var_0_1.PB_TYPE_UNION_EDIT.number = 2011
var_0_1.PB_TYPE_UNION_BUY.name = "PB_TYPE_UNION_BUY"
var_0_1.PB_TYPE_UNION_BUY.index = 346
var_0_1.PB_TYPE_UNION_BUY.number = 2012
var_0_1.PB_TYPE_UNION_REFRESH.name = "PB_TYPE_UNION_REFRESH"
var_0_1.PB_TYPE_UNION_REFRESH.index = 347
var_0_1.PB_TYPE_UNION_REFRESH.number = 2013
var_0_1.PB_TYPE_UNION_DONATE.name = "PB_TYPE_UNION_DONATE"
var_0_1.PB_TYPE_UNION_DONATE.index = 348
var_0_1.PB_TYPE_UNION_DONATE.number = 2014
var_0_1.PB_TYPE_UNION_PROMOTE.name = "PB_TYPE_UNION_PROMOTE"
var_0_1.PB_TYPE_UNION_PROMOTE.index = 349
var_0_1.PB_TYPE_UNION_PROMOTE.number = 2018
var_0_1.PB_TYPE_UNION_DEMOTE.name = "PB_TYPE_UNION_DEMOTE"
var_0_1.PB_TYPE_UNION_DEMOTE.index = 350
var_0_1.PB_TYPE_UNION_DEMOTE.number = 2019
var_0_1.PB_TYPE_UNION_UPGRADE.name = "PB_TYPE_UNION_UPGRADE"
var_0_1.PB_TYPE_UNION_UPGRADE.index = 351
var_0_1.PB_TYPE_UNION_UPGRADE.number = 2020
var_0_1.PB_TYPE_UNION_MINE.name = "PB_TYPE_UNION_MINE"
var_0_1.PB_TYPE_UNION_MINE.index = 352
var_0_1.PB_TYPE_UNION_MINE.number = 2022
var_0_1.PB_TYPE_UNION_RECOMMEND.name = "PB_TYPE_UNION_RECOMMEND"
var_0_1.PB_TYPE_UNION_RECOMMEND.index = 353
var_0_1.PB_TYPE_UNION_RECOMMEND.number = 2023
var_0_1.PB_TYPE_UNION_RESIGN.name = "PB_TYPE_UNION_RESIGN"
var_0_1.PB_TYPE_UNION_RESIGN.index = 354
var_0_1.PB_TYPE_UNION_RESIGN.number = 2027
var_0_1.PB_TYPE_UNION_LET.name = "PB_TYPE_UNION_LET"
var_0_1.PB_TYPE_UNION_LET.index = 355
var_0_1.PB_TYPE_UNION_LET.number = 2028
var_0_1.PB_TYPE_UNION_RENT.name = "PB_TYPE_UNION_RENT"
var_0_1.PB_TYPE_UNION_RENT.index = 356
var_0_1.PB_TYPE_UNION_RENT.number = 2029
var_0_1.PB_TYPE_UNION_UNLET.name = "PB_TYPE_UNION_UNLET"
var_0_1.PB_TYPE_UNION_UNLET.index = 357
var_0_1.PB_TYPE_UNION_UNLET.number = 2030
var_0_1.PB_TYPE_UNION_CLAIM_LET.name = "PB_TYPE_UNION_CLAIM_LET"
var_0_1.PB_TYPE_UNION_CLAIM_LET.index = 358
var_0_1.PB_TYPE_UNION_CLAIM_LET.number = 2031
var_0_1.PB_TYPE_UNION_LOG.name = "PB_TYPE_UNION_LOG"
var_0_1.PB_TYPE_UNION_LOG.index = 359
var_0_1.PB_TYPE_UNION_LOG.number = 2032
var_0_1.PB_TYPE_UNION_WORSHIP.name = "PB_TYPE_UNION_WORSHIP"
var_0_1.PB_TYPE_UNION_WORSHIP.index = 360
var_0_1.PB_TYPE_UNION_WORSHIP.number = 2033
var_0_1.PB_TYPE_UNION_BOSS_ATTACK.name = "PB_TYPE_UNION_BOSS_ATTACK"
var_0_1.PB_TYPE_UNION_BOSS_ATTACK.index = 361
var_0_1.PB_TYPE_UNION_BOSS_ATTACK.number = 2034
var_0_1.PB_TYPE_UNION_BOSS_UNLOCK.name = "PB_TYPE_UNION_BOSS_UNLOCK"
var_0_1.PB_TYPE_UNION_BOSS_UNLOCK.index = 362
var_0_1.PB_TYPE_UNION_BOSS_UNLOCK.number = 2035
var_0_1.PB_TYPE_UNION_BOSS_DAMAGE.name = "PB_TYPE_UNION_BOSS_DAMAGE"
var_0_1.PB_TYPE_UNION_BOSS_DAMAGE.index = 363
var_0_1.PB_TYPE_UNION_BOSS_DAMAGE.number = 2036
var_0_1.PB_TYPE_UNION_TECH_UPGRADE.name = "PB_TYPE_UNION_TECH_UPGRADE"
var_0_1.PB_TYPE_UNION_TECH_UPGRADE.index = 364
var_0_1.PB_TYPE_UNION_TECH_UPGRADE.number = 2037
var_0_1.PB_TYPE_UNION_BOSS_KILL.name = "PB_TYPE_UNION_BOSS_KILL"
var_0_1.PB_TYPE_UNION_BOSS_KILL.index = 365
var_0_1.PB_TYPE_UNION_BOSS_KILL.number = 2038
var_0_1.PB_TYPE_UNION_BOSS_FOCUS.name = "PB_TYPE_UNION_BOSS_FOCUS"
var_0_1.PB_TYPE_UNION_BOSS_FOCUS.index = 366
var_0_1.PB_TYPE_UNION_BOSS_FOCUS.number = 2039
var_0_1.PB_TYPE_UNION_REFRESH_EX.name = "PB_TYPE_UNION_REFRESH_EX"
var_0_1.PB_TYPE_UNION_REFRESH_EX.index = 367
var_0_1.PB_TYPE_UNION_REFRESH_EX.number = 2040
var_0_1.PB_TYPE_UNION_IMPEACH.name = "PB_TYPE_UNION_IMPEACH"
var_0_1.PB_TYPE_UNION_IMPEACH.index = 368
var_0_1.PB_TYPE_UNION_IMPEACH.number = 2041
var_0_1.PB_TYPE_UNION_UNIMPEACH.name = "PB_TYPE_UNION_UNIMPEACH"
var_0_1.PB_TYPE_UNION_UNIMPEACH.index = 369
var_0_1.PB_TYPE_UNION_UNIMPEACH.number = 2042
var_0_1.PB_TYPE_UNION_WORLD.name = "PB_TYPE_UNION_WORLD"
var_0_1.PB_TYPE_UNION_WORLD.index = 370
var_0_1.PB_TYPE_UNION_WORLD.number = 2100
var_0_1.PB_TYPE_UNION_WAR.name = "PB_TYPE_UNION_WAR"
var_0_1.PB_TYPE_UNION_WAR.index = 371
var_0_1.PB_TYPE_UNION_WAR.number = 2101
var_0_1.PB_TYPE_UNION_WAR_DECLARE.name = "PB_TYPE_UNION_WAR_DECLARE"
var_0_1.PB_TYPE_UNION_WAR_DECLARE.index = 372
var_0_1.PB_TYPE_UNION_WAR_DECLARE.number = 2102
var_0_1.PB_TYPE_UNION_WAR_DATA.name = "PB_TYPE_UNION_WAR_DATA"
var_0_1.PB_TYPE_UNION_WAR_DATA.index = 373
var_0_1.PB_TYPE_UNION_WAR_DATA.number = 2103
var_0_1.PB_TYPE_UNION_WAR_BATTLE_START.name = "PB_TYPE_UNION_WAR_BATTLE_START"
var_0_1.PB_TYPE_UNION_WAR_BATTLE_START.index = 374
var_0_1.PB_TYPE_UNION_WAR_BATTLE_START.number = 2104
var_0_1.PB_TYPE_UNION_WAR_BATTLE_END.name = "PB_TYPE_UNION_WAR_BATTLE_END"
var_0_1.PB_TYPE_UNION_WAR_BATTLE_END.index = 375
var_0_1.PB_TYPE_UNION_WAR_BATTLE_END.number = 2105
var_0_1.PB_TYPE_UNION_WAR_BATTLE_JOIN.name = "PB_TYPE_UNION_WAR_BATTLE_JOIN"
var_0_1.PB_TYPE_UNION_WAR_BATTLE_JOIN.index = 376
var_0_1.PB_TYPE_UNION_WAR_BATTLE_JOIN.number = 2106
var_0_1.PB_TYPE_UNION_WAR_BATTLE_SCOUT.name = "PB_TYPE_UNION_WAR_BATTLE_SCOUT"
var_0_1.PB_TYPE_UNION_WAR_BATTLE_SCOUT.index = 377
var_0_1.PB_TYPE_UNION_WAR_BATTLE_SCOUT.number = 2107
var_0_1.PB_TYPE_UNION_WAR_BATTLE_ATTACK.name = "PB_TYPE_UNION_WAR_BATTLE_ATTACK"
var_0_1.PB_TYPE_UNION_WAR_BATTLE_ATTACK.index = 378
var_0_1.PB_TYPE_UNION_WAR_BATTLE_ATTACK.number = 2108
var_0_1.PB_TYPE_UNION_WAR_END.name = "PB_TYPE_UNION_WAR_END"
var_0_1.PB_TYPE_UNION_WAR_END.index = 379
var_0_1.PB_TYPE_UNION_WAR_END.number = 2109
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUERY_INFO.name = "PB_TYPE_MASSWAR_MULTIPLE_QUERY_INFO"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUERY_INFO.index = 380
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUERY_INFO.number = 2110
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_INFO.name = "PB_TYPE_MASSWAR_MULTIPLE_QUIT_INFO"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_INFO.index = 381
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_INFO.number = 2111
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_CREATE_TEAM.name = "PB_TYPE_MASSWAR_MULTIPLE_CREATE_TEAM"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_CREATE_TEAM.index = 382
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_CREATE_TEAM.number = 2112
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_JOIN_TEAM.name = "PB_TYPE_MASSWAR_MULTIPLE_JOIN_TEAM"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_JOIN_TEAM.index = 383
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_JOIN_TEAM.number = 2113
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TEAM.name = "PB_TYPE_MASSWAR_MULTIPLE_QUIT_TEAM"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TEAM.index = 384
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TEAM.number = 2114
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_KICK_OUT_TEAM.name = "PB_TYPE_MASSWAR_MULTIPLE_KICK_OUT_TEAM"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_KICK_OUT_TEAM.index = 385
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_KICK_OUT_TEAM.number = 2115
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_LOAD_CARDS.name = "PB_TYPE_MASSWAR_MULTIPLE_LOAD_CARDS"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_LOAD_CARDS.index = 386
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_LOAD_CARDS.number = 2116
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_START.name = "PB_TYPE_MASSWAR_MULTIPLE_START"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_START.index = 387
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_START.number = 2117
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT.name = "PB_TYPE_MASSWAR_MULTIPLE_QUIT"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT.index = 388
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT.number = 2118
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TROOP.name = "PB_TYPE_MASSWAR_MULTIPLE_QUIT_TROOP"
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TROOP.index = 389
var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TROOP.number = 2119
PROTOMSGTYPE.name = "ProtoMsgType"
PROTOMSGTYPE.full_name = ".sgland.ProtoMsgType"
PROTOMSGTYPE.values = {
	var_0_1.PB_TYPE_CHALLENGE,
	var_0_1.PB_TYPE_AUTHENTICATION,
	var_0_1.PB_TYPE_HEART_BEAT,
	var_0_1.PB_TYPE_USER_LOGIN,
	var_0_1.PB_TYPE_USER_REGISTER,
	var_0_1.PB_TYPE_USER_VISIT,
	var_0_1.PB_TYPE_USER_SET_GUIDE,
	var_0_1.PB_TYPE_USER_SET_NAME,
	var_0_1.PB_TYPE_USER_SET_AVATAR,
	var_0_1.PB_TYPE_USER_OPEN_CHEST,
	var_0_1.PB_TYPE_USER_LOADING_DONE,
	var_0_1.PB_TYPE_USER_SET_NAME_GUIDE,
	var_0_1.PB_TYPE_USER_SET_DEF_TROOP,
	var_0_1.PB_TYPE_USER_COLLECT_GOLD,
	var_0_1.PB_TYPE_USER_SPAWN_GOLD,
	var_0_1.PB_TYPE_USER_FINISH_TRAIN,
	var_0_1.PB_TYPE_USER_CLAIM_GIFT,
	var_0_1.PB_TYPE_USER_SET_EVENT,
	var_0_1.PB_TYPE_USER_QUERY_GCID,
	var_0_1.PB_TYPE_USER_SET_CARD_BACK,
	var_0_1.PB_TYPE_USER_SET_AVATAR_FRAME,
	var_0_1.PB_TYPE_USER_APPLY_VIP_CARD,
	var_0_1.PB_TYPE_USER_SET_CONFIG,
	var_0_1.PB_TYPE_USER_TECH_UPGRADE,
	var_0_1.PB_TYPE_USER_BAN_CHAT,
	var_0_1.PB_TYPE_USER_ADMIN_LIST,
	var_0_1.PB_TYPE_USER_GIVE_FUND,
	var_0_1.PB_TYPE_USER_FUND_GIVEN,
	var_0_1.PB_TYPE_USER_VISIT_EX,
	var_0_1.PB_TYPE_USER_GET_INVITE_CODE,
	var_0_1.PB_TYPE_USER_BIND_INVITE_CODE,
	var_0_1.PB_TYPE_USER_CHECK_INVITE_CODE,
	var_0_1.PB_TYPE_USER_NOTIFY_EVENT,
	var_0_1.PB_TYPE_USER_FACEBOOK,
	var_0_1.PB_TYPE_USER_UPDATE,
	var_0_1.PB_TYPE_USER_CANCEL_BAN_CHAT,
	var_0_1.PB_TYPE_USER_SET_CHARACTER,
	var_0_1.PB_TYPE_USER_UNLOCK_CHARACTER,
	var_0_1.PB_TYPE_USER_SET_SKIN,
	var_0_1.PB_TYPE_USER_SHARE,
	var_0_1.PB_TYPE_USER_OPPO_VIP_LEVEL,
	var_0_1.PB_TYPE_USER_COMMAND,
	var_0_1.PB_TYPE_USER_VOTE,
	var_0_1.PB_TYPE_USER_VOTE_RECORD,
	var_0_1.PB_TYPE_USER_BREAK_OUT,
	var_0_1.PB_TYPE_USER_DYNAMIC_TIMEOUT,
	var_0_1.PB_TYPE_USER_BAN_LOGIN,
	var_0_1.PB_TYPE_CITY_COLLECT_GOLD,
	var_0_1.PB_TYPE_CITY_COLLECT_GRAIN,
	var_0_1.PB_TYPE_CITY_GUARD,
	var_0_1.PB_TYPE_CITY_PICK,
	var_0_1.PB_TYPE_CITY_VISIT,
	var_0_1.PB_TYPE_CITY_VISIT_REMOVE,
	var_0_1.PB_TYPE_CITY_VISIT_RECRUIT,
	var_0_1.PB_TYPE_CITY_VISIT_STAY,
	var_0_1.PB_TYPE_CITY_PROCEDURE_REMOVE,
	var_0_1.PB_TYPE_CITY_PROCEDURE_FINISH,
	var_0_1.PB_TYPE_CITY_PROCEDURE_ASSIGN,
	var_0_1.PB_TYPE_CITY_PROCEDURE_CANCEL,
	var_0_1.PB_TYPE_CITY_VISIT_RECRUIT_EX,
	var_0_1.PB_TYPE_CITY_PKG_GUARD,
	var_0_1.PB_TYPE_CITY_PKG_PICK,
	var_0_1.PB_TYPE_CARD_LOTTERY,
	var_0_1.PB_TYPE_CARDBOX_INFO,
	var_0_1.PB_TYPE_RESET_CARDBOX,
	var_0_1.PB_TYPE_CARD_UPGRADE,
	var_0_1.PB_TYPE_CARD_EVOLUTION,
	var_0_1.PB_TYPE_CARD_SELL,
	var_0_1.PB_TYPE_CARD_UNLOCK,
	var_0_1.PB_TYPE_CARD_COMPOSE,
	var_0_1.PB_TYPE_CARD_DECOMPOSE,
	var_0_1.PB_TYPE_CARD_EQUIP,
	var_0_1.PB_TYPE_CARD_LOTTERY_BOOK,
	var_0_1.PB_TYPE_CARD_EXPAND_HERO,
	var_0_1.PB_TYPE_CARD_EXPAND_EQUIP,
	var_0_1.PB_TYPE_CARD_EXPAND_BOOK,
	var_0_1.PB_TYPE_CARD_EXPAND_HORSE,
	var_0_1.PB_TYPE_CARD_LOTTERY_TEN_TOKEN,
	var_0_1.PB_TYPE_CARD_LOTTERY_BOOK_JUMP,
	var_0_1.PB_TYPE_CARD_RECOVER,
	var_0_1.PB_TYPE_CARD_TRANSFORM,
	var_0_1.PB_TYPE_CARD_SKILL_SET,
	var_0_1.PB_TYPE_CARD_DECOMPOSE_BATCH,
	var_0_1.PB_TYPE_CARD_RECOVERY,
	var_0_1.PB_TYPE_CARD_LEGEND_COMPOSE,
	var_0_1.PB_TYPE_CARD_SMELT,
	var_0_1.PB_TYPE_CARD_GET_FESTIVAL,
	var_0_1.PB_TYPE_CARD_LOTTERY_FESTIVAL,
	var_0_1.PB_TYPE_CARD_RESET_FESTIVAL,
	var_0_1.PB_TYPE_CARD_LEGEND_TRANSLATE,
	var_0_1.PB_TYPE_CARD_LOTTERY_TURNTABLE,
	var_0_1.PB_TYPE_CARD_UP_PKG_CARD,
	var_0_1.PB_TYPE_CARD_COLLECT,
	var_0_1.PB_TYPE_CARD_RUBBING,
	var_0_1.PB_TYPE_CARD_UNRUBBING,
	var_0_1.PB_TYPE_CARD_REMOVERUBBING,
	var_0_1.PB_TYPE_WORLD_ATTACK,
	var_0_1.PB_TYPE_WORLD_FIND,
	var_0_1.PB_TYPE_WORLD_RETREAT,
	var_0_1.PB_TYPE_WORLD_CHALLENGE,
	var_0_1.PB_TYPE_WORLD_SWEEP,
	var_0_1.PB_TYPE_WORLD_SCOUT,
	var_0_1.PB_TYPE_WORLD_RESET_SWEEP_COUNT,
	var_0_1.PB_TYPE_WORLD_CHALLENGE_ELITE,
	var_0_1.PB_TYPE_WORLD_CHALLENGE_COMMANDER,
	var_0_1.PB_TYPE_WORLD_EXPEDITION,
	var_0_1.PB_TYPE_WORLD_REFRESH_EXPEDITION,
	var_0_1.PB_TYPE_WORLD_GET_EXPEDITION,
	var_0_1.PB_TYPE_WORLD_EXPEDITION_OPEN,
	var_0_1.PB_TYPE_WORLD_FIND_START,
	var_0_1.PB_TYPE_WORLD_SWEEP_ONCE,
	var_0_1.PB_TYPE_WORLD_BATTLE_START,
	var_0_1.PB_TYPE_WORLD_BATTLE_END,
	var_0_1.PB_TYPE_WORLD_BATTLE_JOIN,
	var_0_1.PB_TYPE_WORLD_ROB_GOLD,
	var_0_1.PB_TYPE_WORLD_ROB_EXP,
	var_0_1.PB_TYPE_WORLD_SWEEP_GOLD,
	var_0_1.PB_TYPE_WORLD_SWEEP_GOLD_ONCE,
	var_0_1.PB_TYPE_WORLD_SWEEP_EXPEDITION,
	var_0_1.PB_TYPE_WORLD_SWEEP_COPY,
	var_0_1.PB_TYPE_WORLD_SWEEP_COPY_ONCE,
	var_0_1.PB_TYPE_WORLD_SOS,
	var_0_1.PB_TYPE_WORLD_RESCUE,
	var_0_1.PB_TYPE_WORLD_RESCUE_JOIN,
	var_0_1.PB_TYPE_WORLD_RESCUE_END,
	var_0_1.PB_TYPE_WORLD_FIND_EX,
	var_0_1.PB_TYPE_WORLD_FIND_EX_CANCEL,
	var_0_1.PB_TYPE_WORLD_FIND_RESET,
	var_0_1.PB_TYPE_WORLD_GET_OPPONENT,
	var_0_1.PB_TYPE_WORLD_FIND_NPC,
	var_0_1.PB_TYPE_WORLD_RESET_TROOP,
	var_0_1.PB_TYPE_WORLD_RESET_LADDER_LOSE,
	var_0_1.PB_TYPE_WORLD_EXPEDITION_EX,
	var_0_1.PB_TYPE_WORLD_GET_EXPEDITION_EX,
	var_0_1.PB_TYPE_WORLD_EXPEDITION_EX_BOSS,
	var_0_1.PB_TYPE_WORLD_LOTTERY,
	var_0_1.PB_TYPE_WORLD_REFRESH_EXPEDITION_EX,
	var_0_1.PB_TYPE_WORLD_BUY_TICKET,
	var_0_1.PB_TYPE_WORLD_SELECT_CHAR,
	var_0_1.PB_TYPE_WORLD_SELECT_CARD,
	var_0_1.PB_TYPE_WORLD_QUIT,
	var_0_1.PB_TYPE_WORLD_CREATE_MATCH,
	var_0_1.PB_TYPE_WORLD_QUERY_MATCH,
	var_0_1.PB_TYPE_WORLD_JOIN_MATCH,
	var_0_1.PB_TYPE_WORLD_QUIT_MATCH,
	var_0_1.PB_TYPE_WORLD_START_MATCH,
	var_0_1.PB_TYPE_WORLD_TOGGLE_MATCH,
	var_0_1.PB_TYPE_WORLD_GET_MATCH,
	var_0_1.PB_TYPE_WORLD_CLOSE_MATCH,
	var_0_1.PB_TYPE_WORLD_RECYCLE_MATCH,
	var_0_1.PB_TYPE_WORLD_LOTTERY_UNOPEN,
	var_0_1.PB_TYPE_WORLD_LOTTERY_OPENED,
	var_0_1.PB_TYPE_WORLD_UPDATE_LOTTERY_INFO,
	var_0_1.PB_TYPE_WORLD_RECOMMEND_TROOP,
	var_0_1.PB_TYPE_WORLD_DARK_DUEL_DASHBOARD,
	var_0_1.PB_TYPE_WORLD_DARK_DUEL_RECHEAT,
	var_0_1.PB_TYPE_WORLD_DAKR_RESET,
	var_0_1.PB_TYPE_WORLD_SELECT_DARK_TROOP,
	var_0_1.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL,
	var_0_1.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL,
	var_0_1.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL,
	var_0_1.PB_TYPE_WORLD_QUIT_SURVIVAL,
	var_0_1.PB_TYPE_WORLD_FIND_SURVIVAL,
	var_0_1.PB_TYPE_WORLD_JOIN_SURVIVAL,
	var_0_1.PB_TYPE_WORLD_SURVIVAL_HALL_INFO,
	var_0_1.PB_TYPE_WORLD_SURVIVAL_EXPLORE_START,
	var_0_1.PB_TYPE_WORLD_SURVIVAL_EXPLORE_END,
	var_0_1.PB_TYPE_WORLD_SURVIVAL_GAME_OVER,
	var_0_1.PB_TYPE_WORLD_WORSHIP_LIST,
	var_0_1.PB_TYPE_WORLD_WORSHIP,
	var_0_1.PB_TYPE_WORLD_LOTTERY_EX,
	var_0_1.PB_TYPE_WORLD_LEAVE_TEAM,
	var_0_1.PB_TYPE_WORLD_JOIN_TEAM,
	var_0_1.PB_TYPE_WORLD_LOTTERY_ACTIVITY,
	var_0_1.PB_TYPE_WORLD_ROLL_CHAR,
	var_0_1.PB_TYPE_WORLD_GEN_ENVELOPE,
	var_0_1.PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX,
	var_0_1.PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX,
	var_0_1.PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX,
	var_0_1.PB_TYPE_WORLD_QUIT_SURVIVAL_EX,
	var_0_1.PB_TYPE_WORLD_FIND_SURVIVAL_EX,
	var_0_1.PB_TYPE_WORLD_JOIN_SURVIVAL_EX,
	var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO,
	var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_START,
	var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_END,
	var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_GAME_OVER,
	var_0_1.PB_TYPE_WORLD_SURVIVAL_EX_EQUIP_SKILL,
	var_0_1.PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX,
	var_0_1.PB_TYPE_WORLD_BUY_TICKET_LEGEND,
	var_0_1.PB_TYPE_WORLD_QUIT_LEGEND,
	var_0_1.PB_TYPE_BATTLE_START,
	var_0_1.PB_TYPE_BATTLE_END,
	var_0_1.PB_TYPE_BATTLE_USECARD,
	var_0_1.PB_TYPE_BATTLE_OP_USECARD,
	var_0_1.PB_TYPE_BATTLE_LOG,
	var_0_1.PB_TYPE_BATTLE_REPLAY,
	var_0_1.PB_TYPE_BATTLE_SHARE,
	var_0_1.PB_TYPE_BATTLE_RECOVER,
	var_0_1.PB_TYPE_BATTLE_OP_ONLINE,
	var_0_1.PB_TYPE_BATTLE_OP_OFFLINE,
	var_0_1.PB_TYPE_BATTLE_SYNC,
	var_0_1.PB_TYPE_BATTLE_CHAT,
	var_0_1.PB_TYPE_BATTLE_SKIP,
	var_0_1.PB_TYPE_BATTLE_OP_SKIP,
	var_0_1.PB_TYPE_BATTLE_TUTORIAL,
	var_0_1.PB_TYPE_BATTLE_AGAIN,
	var_0_1.PB_TYPE_BATTLE_RETRY,
	var_0_1.PB_TYPE_BATTLE_REPLAY_TUTORIAL,
	var_0_1.PB_TYPE_BATTLE_THUMBS_UP,
	var_0_1.PB_TYPE_BATTLE_THUMBS_UP_CANCEL,
	var_0_1.PB_TYPE_BATTLE_REPLAY_SHARE,
	var_0_1.PB_TYPE_BATTLE_SHARE_WATCH,
	var_0_1.PB_TYPE_BATTLE_ERROR,
	var_0_1.PB_TYPE_BATTLE_LOADING_DONE,
	var_0_1.PB_TYPE_BATTLE_LOG_EX,
	var_0_1.PB_TYPE_BATTLE_REPLAY_EX,
	var_0_1.PB_TYPE_BATTLE_OP_CHAT,
	var_0_1.PB_TYPE_BATTLE_SET_MATCH_HP,
	var_0_1.PB_TYPE_TROOP_RELOAD,
	var_0_1.PB_TYPE_TROOP_MARK,
	var_0_1.PB_TYPE_TROOP_UNLOCK,
	var_0_1.PB_TYPE_FRIEND_SEARCH,
	var_0_1.PB_TYPE_FRIEND_RECOMMEND,
	var_0_1.PB_TYPE_FRIEND_INVITE,
	var_0_1.PB_TYPE_FRIEND_ACCEPT,
	var_0_1.PB_TYPE_FRIEND_REMOVE,
	var_0_1.PB_TYPE_FRIEND_LIST,
	var_0_1.PB_TYPE_FRIEND_ACCEPTED,
	var_0_1.PB_TYPE_FRIEND_REMOVED,
	var_0_1.PB_TYPE_FRIEND_BATTLE,
	var_0_1.PB_TYPE_FRIEND_BATTLE_START,
	var_0_1.PB_TYPE_FRIEND_BATTLE_END,
	var_0_1.PB_TYPE_FRIEND_BATTLE_JOIN,
	var_0_1.PB_TYPE_FRIEND_SEARCH_EX,
	var_0_1.PB_TYPE_FRIEND_BATTLE_CANCEL,
	var_0_1.PB_TYPE_FRIEND_BATTLE_UPDATE,
	var_0_1.PB_TYPE_MAIL_LIST,
	var_0_1.PB_TYPE_MAIL_SEND,
	var_0_1.PB_TYPE_MAIL_RECEIVE,
	var_0_1.PB_TYPE_CHAT,
	var_0_1.PB_TYPE_BONUS_ACTIVITY,
	var_0_1.PB_TYPE_BONUS_CLAIM,
	var_0_1.PB_TYPE_BONUS_ACTIVITY_CLAIM,
	var_0_1.PB_TYPE_BONUS_RE_CHECK_CLAIM,
	var_0_1.PB_TYPE_BONUS_ONLINE_CLAIM,
	var_0_1.PB_TYPE_BONUS_ACTIVITY_EX_CLAIM,
	var_0_1.PB_TYPE_BONUS_PLAYER_BONUS,
	var_0_1.PB_TYPE_BONUS_PLAYER_BONUS_AVAILABLE,
	var_0_1.PB_TYPE_BONUS_TEACHING_FINISH,
	var_0_1.PB_TYPE_BONUS_DAILY_TASK_RESET,
	var_0_1.PB_TYPE_BONUS_DAILY_TASK,
	var_0_1.PB_TYPE_BONUS_GIFT,
	var_0_1.PB_TYPE_BONUS_ENVELOPE_AVAILABLE,
	var_0_1.PB_TYPE_BONUS_CLAIM_ENVELOPE,
	var_0_1.PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS,
	var_0_1.PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE,
	var_0_1.PB_TYPE_BONUS_CHARGE_ENVELOPE_AVAILABLE,
	var_0_1.PB_TYPE_FEEDBACK,
	var_0_1.PB_TYPE_IAP_START,
	var_0_1.PB_TYPE_IAP_FINISH,
	var_0_1.PB_TYPE_BUY_GOLD,
	var_0_1.PB_TYPE_BUY_GRAIN,
	var_0_1.PB_TYPE_BUY_DAILY,
	var_0_1.PB_TYPE_BUY_FUND,
	var_0_1.PB_TYPE_BUY_DUST,
	var_0_1.PB_TYPE_BUY_BADGE,
	var_0_1.PB_TYPE_BUY_BADGE_LEVEL,
	var_0_1.PB_TYPE_BUY_SPRING_BADGE_LEVEL,
	var_0_1.PB_TYPE_BUY_SPRING2_BADGE_LEVEL,
	var_0_1.PB_TYPE_SHOP_BUY,
	var_0_1.PB_TYPE_SHOP_REFRESH,
	var_0_1.PB_TYPE_SHOP_EXCHANGE,
	var_0_1.PB_TYPE_SHOP_BUY_PVP,
	var_0_1.PB_TYPE_SHOP_OPEN,
	var_0_1.PB_TYPE_SHOP_REFRESH_PVP,
	var_0_1.PB_TYPE_SHOP_REFRESH_ALL,
	var_0_1.PB_TYPE_SHOP_REFRESH_PVP_EX,
	var_0_1.PB_TYPE_SHOP_REFRESH_EX,
	var_0_1.PB_TYPE_SHOP_BUY_LADDER,
	var_0_1.PB_TYPE_SHOP_REFRESH_LADDER,
	var_0_1.PB_TYPE_SHOP_REFRESH_LADDER_EX,
	var_0_1.PB_TYPE_SHOP_GIFT,
	var_0_1.PB_TYPE_SHOP_BUY_GIFT,
	var_0_1.PB_TYPE_SHOP_MAGICBOX,
	var_0_1.PB_TYPE_SHOP_UNION,
	var_0_1.PB_TYPE_SHOP_SKIN,
	var_0_1.PB_TYPE_SHOP_RARE,
	var_0_1.PB_TYPE_SHOP_LEGEND,
	var_0_1.PB_TYPE_SHOP_DIAMOND,
	var_0_1.PB_TYPE_SHOP_EXCHANGE_PROP,
	var_0_1.PB_TYPE_SHOP_ANCIENT,
	var_0_1.PB_TYPE_SHOP_VOTE,
	var_0_1.PB_TYPE_SHOP_VOTE_COUNT,
	var_0_1.PB_TYPE_SHOP_RECYCLE,
	var_0_1.PB_TYPE_SHOP_COLLECTION,
	var_0_1.PB_TYPE_SHOP_REVELRY,
	var_0_1.PB_TYPE_SHOP_RUBBING,
	var_0_1.PB_TYPE_SHOP_BADGE,
	var_0_1.PB_TYPE_SHOP_PRIVILEGE,
	var_0_1.PB_TYPE_NEWS,
	var_0_1.PB_TYPE_NEWS_ANNOUNCEMENT,
	var_0_1.PB_TYPE_RANK_TROPHY,
	var_0_1.PB_TYPE_RANK_LEVEL,
	var_0_1.PB_TYPE_RANK_STAR,
	var_0_1.PB_TYPE_RANK_BOSS,
	var_0_1.PB_TYPE_RANK_UNION_LEVEL,
	var_0_1.PB_TYPE_RANK_POWER,
	var_0_1.PB_TYPE_RANK_UBOSS_SCORE,
	var_0_1.PB_TYPE_RANK_UBOSS_TIME,
	var_0_1.PB_TYPE_RANK_LADDER,
	var_0_1.PB_TYPE_RANK_PRE,
	var_0_1.PB_TYPE_RANK_POINT,
	var_0_1.PB_TYPE_RANK_CONSUME,
	var_0_1.PB_TYPE_RANK_LADDER_EX,
	var_0_1.PB_TYPE_RANK_PRE_EX,
	var_0_1.PB_TYPE_RANK_CHAR_LEVEL,
	var_0_1.PB_TYPE_RANK_UNION_TROPHY,
	var_0_1.PB_TYPE_RANK_RESET,
	var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP,
	var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM,
	var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE,
	var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP,
	var_0_1.PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM,
	var_0_1.PB_TYPE_RANK_DARK_PRE,
	var_0_1.PB_TYPE_RANK_DARK,
	var_0_1.PB_TYPE_RANK_ENVELOPE,
	var_0_1.PB_TYPE_RANK_TROPHY_EVENT,
	var_0_1.PB_TYPE_RANK_TROPHY_ACTIVITY,
	var_0_1.PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY,
	var_0_1.PB_TYPE_RANK_LEGEND_PRE,
	var_0_1.PB_TYPE_RANK_LEGEND,
	var_0_1.PB_TYPE_REGION_LIST,
	var_0_1.PB_TYPE_REGION_GROUP,
	var_0_1.PB_TYPE_REGION_GROUP_EX,
	var_0_1.PB_TYPE_UNION_CREATE,
	var_0_1.PB_TYPE_UNION_INVITE,
	var_0_1.PB_TYPE_UNION_APPLY,
	var_0_1.PB_TYPE_UNION_KICKOUT,
	var_0_1.PB_TYPE_UNION_LEAVE,
	var_0_1.PB_TYPE_UNION_ACCEPT_INVITE,
	var_0_1.PB_TYPE_UNION_ACCEPT_APPLY,
	var_0_1.PB_TYPE_UNION_SEARCH,
	var_0_1.PB_TYPE_UNION_DETAIL,
	var_0_1.PB_TYPE_UNION_JOIN,
	var_0_1.PB_TYPE_UNION_MESSAGE,
	var_0_1.PB_TYPE_UNION_EDIT,
	var_0_1.PB_TYPE_UNION_BUY,
	var_0_1.PB_TYPE_UNION_REFRESH,
	var_0_1.PB_TYPE_UNION_DONATE,
	var_0_1.PB_TYPE_UNION_PROMOTE,
	var_0_1.PB_TYPE_UNION_DEMOTE,
	var_0_1.PB_TYPE_UNION_UPGRADE,
	var_0_1.PB_TYPE_UNION_MINE,
	var_0_1.PB_TYPE_UNION_RECOMMEND,
	var_0_1.PB_TYPE_UNION_RESIGN,
	var_0_1.PB_TYPE_UNION_LET,
	var_0_1.PB_TYPE_UNION_RENT,
	var_0_1.PB_TYPE_UNION_UNLET,
	var_0_1.PB_TYPE_UNION_CLAIM_LET,
	var_0_1.PB_TYPE_UNION_LOG,
	var_0_1.PB_TYPE_UNION_WORSHIP,
	var_0_1.PB_TYPE_UNION_BOSS_ATTACK,
	var_0_1.PB_TYPE_UNION_BOSS_UNLOCK,
	var_0_1.PB_TYPE_UNION_BOSS_DAMAGE,
	var_0_1.PB_TYPE_UNION_TECH_UPGRADE,
	var_0_1.PB_TYPE_UNION_BOSS_KILL,
	var_0_1.PB_TYPE_UNION_BOSS_FOCUS,
	var_0_1.PB_TYPE_UNION_REFRESH_EX,
	var_0_1.PB_TYPE_UNION_IMPEACH,
	var_0_1.PB_TYPE_UNION_UNIMPEACH,
	var_0_1.PB_TYPE_UNION_WORLD,
	var_0_1.PB_TYPE_UNION_WAR,
	var_0_1.PB_TYPE_UNION_WAR_DECLARE,
	var_0_1.PB_TYPE_UNION_WAR_DATA,
	var_0_1.PB_TYPE_UNION_WAR_BATTLE_START,
	var_0_1.PB_TYPE_UNION_WAR_BATTLE_END,
	var_0_1.PB_TYPE_UNION_WAR_BATTLE_JOIN,
	var_0_1.PB_TYPE_UNION_WAR_BATTLE_SCOUT,
	var_0_1.PB_TYPE_UNION_WAR_BATTLE_ATTACK,
	var_0_1.PB_TYPE_UNION_WAR_END,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUERY_INFO,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_INFO,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_CREATE_TEAM,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_JOIN_TEAM,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TEAM,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_KICK_OUT_TEAM,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_LOAD_CARDS,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_START,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT,
	var_0_1.PB_TYPE_MASSWAR_MULTIPLE_QUIT_TROOP
}
PB_TYPE_AUTHENTICATION = 101
PB_TYPE_BATTLE_AGAIN = 715
PB_TYPE_BATTLE_CHAT = 711
PB_TYPE_BATTLE_END = 701
PB_TYPE_BATTLE_ERROR = 722
PB_TYPE_BATTLE_LOADING_DONE = 723
PB_TYPE_BATTLE_LOG = 704
PB_TYPE_BATTLE_LOG_EX = 724
PB_TYPE_BATTLE_OP_CHAT = 726
PB_TYPE_BATTLE_OP_OFFLINE = 709
PB_TYPE_BATTLE_OP_ONLINE = 708
PB_TYPE_BATTLE_OP_SKIP = 713
PB_TYPE_BATTLE_OP_USECARD = 703
PB_TYPE_BATTLE_RECOVER = 707
PB_TYPE_BATTLE_REPLAY = 705
PB_TYPE_BATTLE_REPLAY_EX = 725
PB_TYPE_BATTLE_REPLAY_SHARE = 720
PB_TYPE_BATTLE_REPLAY_TUTORIAL = 717
PB_TYPE_BATTLE_RETRY = 716
PB_TYPE_BATTLE_SET_MATCH_HP = 727
PB_TYPE_BATTLE_SHARE = 706
PB_TYPE_BATTLE_SHARE_WATCH = 721
PB_TYPE_BATTLE_SKIP = 712
PB_TYPE_BATTLE_START = 700
PB_TYPE_BATTLE_SYNC = 710
PB_TYPE_BATTLE_THUMBS_UP = 718
PB_TYPE_BATTLE_THUMBS_UP_CANCEL = 719
PB_TYPE_BATTLE_TUTORIAL = 714
PB_TYPE_BATTLE_USECARD = 702
PB_TYPE_BONUS_ACTIVITY = 1200
PB_TYPE_BONUS_ACTIVITY_CLAIM = 1202
PB_TYPE_BONUS_ACTIVITY_EX_CLAIM = 1205
PB_TYPE_BONUS_CHARGE_ENVELOPE_AVAILABLE = 1216
PB_TYPE_BONUS_CLAIM = 1201
PB_TYPE_BONUS_CLAIM_CHARGE_ENVELOPE = 1215
PB_TYPE_BONUS_CLAIM_ENVELOPE = 1213
PB_TYPE_BONUS_DAILY_TASK = 1210
PB_TYPE_BONUS_DAILY_TASK_RESET = 1209
PB_TYPE_BONUS_ENVELOPE_AVAILABLE = 1212
PB_TYPE_BONUS_GIFT = 1211
PB_TYPE_BONUS_ONLINE_CLAIM = 1204
PB_TYPE_BONUS_PLAYER_ACTIVITY_BONUS = 1214
PB_TYPE_BONUS_PLAYER_BONUS = 1206
PB_TYPE_BONUS_PLAYER_BONUS_AVAILABLE = 1207
PB_TYPE_BONUS_RE_CHECK_CLAIM = 1203
PB_TYPE_BONUS_TEACHING_FINISH = 1208
PB_TYPE_BUY_BADGE = 1407
PB_TYPE_BUY_BADGE_LEVEL = 1408
PB_TYPE_BUY_DAILY = 1404
PB_TYPE_BUY_DUST = 1406
PB_TYPE_BUY_FUND = 1405
PB_TYPE_BUY_GOLD = 1402
PB_TYPE_BUY_GRAIN = 1403
PB_TYPE_BUY_SPRING2_BADGE_LEVEL = 1410
PB_TYPE_BUY_SPRING_BADGE_LEVEL = 1409
PB_TYPE_CARDBOX_INFO = 501
PB_TYPE_CARD_COLLECT = 537
PB_TYPE_CARD_COMPOSE = 511
PB_TYPE_CARD_DECOMPOSE = 512
PB_TYPE_CARD_DECOMPOSE_BATCH = 527
PB_TYPE_CARD_EQUIP = 513
PB_TYPE_CARD_EVOLUTION = 508
PB_TYPE_CARD_EXPAND_BOOK = 517
PB_TYPE_CARD_EXPAND_EQUIP = 516
PB_TYPE_CARD_EXPAND_HERO = 515
PB_TYPE_CARD_EXPAND_HORSE = 518
PB_TYPE_CARD_GET_FESTIVAL = 531
PB_TYPE_CARD_LEGEND_COMPOSE = 529
PB_TYPE_CARD_LEGEND_TRANSLATE = 534
PB_TYPE_CARD_LOTTERY = 500
PB_TYPE_CARD_LOTTERY_BOOK = 514
PB_TYPE_CARD_LOTTERY_BOOK_JUMP = 521
PB_TYPE_CARD_LOTTERY_FESTIVAL = 532
PB_TYPE_CARD_LOTTERY_TEN_TOKEN = 519
PB_TYPE_CARD_LOTTERY_TURNTABLE = 535
PB_TYPE_CARD_RECOVER = 522
PB_TYPE_CARD_RECOVERY = 528
PB_TYPE_CARD_REMOVERUBBING = 540
PB_TYPE_CARD_RESET_FESTIVAL = 533
PB_TYPE_CARD_RUBBING = 538
PB_TYPE_CARD_SELL = 509
PB_TYPE_CARD_SKILL_SET = 526
PB_TYPE_CARD_SMELT = 530
PB_TYPE_CARD_TRANSFORM = 523
PB_TYPE_CARD_UNLOCK = 510
PB_TYPE_CARD_UNRUBBING = 539
PB_TYPE_CARD_UPGRADE = 507
PB_TYPE_CARD_UP_PKG_CARD = 536
PB_TYPE_CHALLENGE = 100
PB_TYPE_CHAT = 1100
PB_TYPE_CITY_COLLECT_GOLD = 400
PB_TYPE_CITY_COLLECT_GRAIN = 401
PB_TYPE_CITY_GUARD = 402
PB_TYPE_CITY_PICK = 403
PB_TYPE_CITY_PKG_GUARD = 413
PB_TYPE_CITY_PKG_PICK = 414
PB_TYPE_CITY_PROCEDURE_ASSIGN = 410
PB_TYPE_CITY_PROCEDURE_CANCEL = 411
PB_TYPE_CITY_PROCEDURE_FINISH = 409
PB_TYPE_CITY_PROCEDURE_REMOVE = 408
PB_TYPE_CITY_VISIT = 404
PB_TYPE_CITY_VISIT_RECRUIT = 406
PB_TYPE_CITY_VISIT_RECRUIT_EX = 412
PB_TYPE_CITY_VISIT_REMOVE = 405
PB_TYPE_CITY_VISIT_STAY = 407
PB_TYPE_FEEDBACK = 1300
PB_TYPE_FRIEND_ACCEPT = 903
PB_TYPE_FRIEND_ACCEPTED = 906
PB_TYPE_FRIEND_BATTLE = 908
PB_TYPE_FRIEND_BATTLE_CANCEL = 913
PB_TYPE_FRIEND_BATTLE_END = 910
PB_TYPE_FRIEND_BATTLE_JOIN = 911
PB_TYPE_FRIEND_BATTLE_START = 909
PB_TYPE_FRIEND_BATTLE_UPDATE = 914
PB_TYPE_FRIEND_INVITE = 902
PB_TYPE_FRIEND_LIST = 905
PB_TYPE_FRIEND_RECOMMEND = 901
PB_TYPE_FRIEND_REMOVE = 904
PB_TYPE_FRIEND_REMOVED = 907
PB_TYPE_FRIEND_SEARCH = 900
PB_TYPE_FRIEND_SEARCH_EX = 912
PB_TYPE_HEART_BEAT = 200
PB_TYPE_IAP_FINISH = 1401
PB_TYPE_IAP_START = 1400
PB_TYPE_MAIL_LIST = 1000
PB_TYPE_MAIL_RECEIVE = 1002
PB_TYPE_MAIL_SEND = 1001
PB_TYPE_MASSWAR_MULTIPLE_CREATE_TEAM = 2112
PB_TYPE_MASSWAR_MULTIPLE_JOIN_TEAM = 2113
PB_TYPE_MASSWAR_MULTIPLE_KICK_OUT_TEAM = 2115
PB_TYPE_MASSWAR_MULTIPLE_LOAD_CARDS = 2116
PB_TYPE_MASSWAR_MULTIPLE_QUERY_INFO = 2110
PB_TYPE_MASSWAR_MULTIPLE_QUIT = 2118
PB_TYPE_MASSWAR_MULTIPLE_QUIT_INFO = 2111
PB_TYPE_MASSWAR_MULTIPLE_QUIT_TEAM = 2114
PB_TYPE_MASSWAR_MULTIPLE_QUIT_TROOP = 2119
PB_TYPE_MASSWAR_MULTIPLE_START = 2117
PB_TYPE_NEWS = 1600
PB_TYPE_NEWS_ANNOUNCEMENT = 1601
PB_TYPE_RANK_BOSS = 1703
PB_TYPE_RANK_CHAR_LEVEL = 1714
PB_TYPE_RANK_CONSUME = 1711
PB_TYPE_RANK_DARK = 1723
PB_TYPE_RANK_DARK_PRE = 1722
PB_TYPE_RANK_ENVELOPE = 1724
PB_TYPE_RANK_LADDER = 1708
PB_TYPE_RANK_LADDER_EX = 1712
PB_TYPE_RANK_LEGEND = 1730
PB_TYPE_RANK_LEGEND_PRE = 1729
PB_TYPE_RANK_LEVEL = 1701
PB_TYPE_RANK_MASSWAR_MULTIPLE_MVP = 1717
PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE = 1719
PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_MVP = 1720
PB_TYPE_RANK_MASSWAR_MULTIPLE_PRE_TEAM = 1721
PB_TYPE_RANK_MASSWAR_MULTIPLE_TEAM = 1718
PB_TYPE_RANK_POINT = 1710
PB_TYPE_RANK_POWER = 1705
PB_TYPE_RANK_PRE = 1709
PB_TYPE_RANK_PRE_EX = 1713
PB_TYPE_RANK_RESET = 1716
PB_TYPE_RANK_STAR = 1702
PB_TYPE_RANK_TROPHY = 1700
PB_TYPE_RANK_TROPHY_ACTIVITY = 1727
PB_TYPE_RANK_TROPHY_EVENT = 1725
PB_TYPE_RANK_TROPHY_YEAR_ACTIVITY = 1728
PB_TYPE_RANK_UBOSS_SCORE = 1706
PB_TYPE_RANK_UBOSS_TIME = 1707
PB_TYPE_RANK_UNION_LEVEL = 1704
PB_TYPE_RANK_UNION_TROPHY = 1715
PB_TYPE_REGION_GROUP = 1901
PB_TYPE_REGION_GROUP_EX = 1902
PB_TYPE_REGION_LIST = 1900
PB_TYPE_RESET_CARDBOX = 502
PB_TYPE_SHOP_ANCIENT = 1522
PB_TYPE_SHOP_BADGE = 1529
PB_TYPE_SHOP_BUY = 1501
PB_TYPE_SHOP_BUY_GIFT = 1514
PB_TYPE_SHOP_BUY_LADDER = 1510
PB_TYPE_SHOP_BUY_PVP = 1504
PB_TYPE_SHOP_COLLECTION = 1526
PB_TYPE_SHOP_DIAMOND = 1520
PB_TYPE_SHOP_EXCHANGE = 1503
PB_TYPE_SHOP_EXCHANGE_PROP = 1521
PB_TYPE_SHOP_GIFT = 1513
PB_TYPE_SHOP_LEGEND = 1519
PB_TYPE_SHOP_MAGICBOX = 1515
PB_TYPE_SHOP_OPEN = 1505
PB_TYPE_SHOP_PRIVILEGE = 1530
PB_TYPE_SHOP_RARE = 1518
PB_TYPE_SHOP_RECYCLE = 1525
PB_TYPE_SHOP_REFRESH = 1502
PB_TYPE_SHOP_REFRESH_ALL = 1507
PB_TYPE_SHOP_REFRESH_EX = 1509
PB_TYPE_SHOP_REFRESH_LADDER = 1511
PB_TYPE_SHOP_REFRESH_LADDER_EX = 1512
PB_TYPE_SHOP_REFRESH_PVP = 1506
PB_TYPE_SHOP_REFRESH_PVP_EX = 1508
PB_TYPE_SHOP_REVELRY = 1527
PB_TYPE_SHOP_RUBBING = 1528
PB_TYPE_SHOP_SKIN = 1517
PB_TYPE_SHOP_UNION = 1516
PB_TYPE_SHOP_VOTE = 1523
PB_TYPE_SHOP_VOTE_COUNT = 1524
PB_TYPE_TROOP_MARK = 801
PB_TYPE_TROOP_RELOAD = 800
PB_TYPE_TROOP_UNLOCK = 802
PB_TYPE_UNION_ACCEPT_APPLY = 2006
PB_TYPE_UNION_ACCEPT_INVITE = 2005
PB_TYPE_UNION_APPLY = 2002
PB_TYPE_UNION_BOSS_ATTACK = 2034
PB_TYPE_UNION_BOSS_DAMAGE = 2036
PB_TYPE_UNION_BOSS_FOCUS = 2039
PB_TYPE_UNION_BOSS_KILL = 2038
PB_TYPE_UNION_BOSS_UNLOCK = 2035
PB_TYPE_UNION_BUY = 2012
PB_TYPE_UNION_CLAIM_LET = 2031
PB_TYPE_UNION_CREATE = 2000
PB_TYPE_UNION_DEMOTE = 2019
PB_TYPE_UNION_DETAIL = 2008
PB_TYPE_UNION_DONATE = 2014
PB_TYPE_UNION_EDIT = 2011
PB_TYPE_UNION_IMPEACH = 2041
PB_TYPE_UNION_INVITE = 2001
PB_TYPE_UNION_JOIN = 2009
PB_TYPE_UNION_KICKOUT = 2003
PB_TYPE_UNION_LEAVE = 2004
PB_TYPE_UNION_LET = 2028
PB_TYPE_UNION_LOG = 2032
PB_TYPE_UNION_MESSAGE = 2010
PB_TYPE_UNION_MINE = 2022
PB_TYPE_UNION_PROMOTE = 2018
PB_TYPE_UNION_RECOMMEND = 2023
PB_TYPE_UNION_REFRESH = 2013
PB_TYPE_UNION_REFRESH_EX = 2040
PB_TYPE_UNION_RENT = 2029
PB_TYPE_UNION_RESIGN = 2027
PB_TYPE_UNION_SEARCH = 2007
PB_TYPE_UNION_TECH_UPGRADE = 2037
PB_TYPE_UNION_UNIMPEACH = 2042
PB_TYPE_UNION_UNLET = 2030
PB_TYPE_UNION_UPGRADE = 2020
PB_TYPE_UNION_WAR = 2101
PB_TYPE_UNION_WAR_BATTLE_ATTACK = 2108
PB_TYPE_UNION_WAR_BATTLE_END = 2105
PB_TYPE_UNION_WAR_BATTLE_JOIN = 2106
PB_TYPE_UNION_WAR_BATTLE_SCOUT = 2107
PB_TYPE_UNION_WAR_BATTLE_START = 2104
PB_TYPE_UNION_WAR_DATA = 2103
PB_TYPE_UNION_WAR_DECLARE = 2102
PB_TYPE_UNION_WAR_END = 2109
PB_TYPE_UNION_WORLD = 2100
PB_TYPE_UNION_WORSHIP = 2033
PB_TYPE_USER_ADMIN_LIST = 322
PB_TYPE_USER_APPLY_VIP_CARD = 318
PB_TYPE_USER_BAN_CHAT = 321
PB_TYPE_USER_BAN_LOGIN = 343
PB_TYPE_USER_BIND_INVITE_CODE = 327
PB_TYPE_USER_BREAK_OUT = 341
PB_TYPE_USER_CANCEL_BAN_CHAT = 332
PB_TYPE_USER_CHECK_INVITE_CODE = 328
PB_TYPE_USER_CLAIM_GIFT = 313
PB_TYPE_USER_COLLECT_GOLD = 310
PB_TYPE_USER_COMMAND = 338
PB_TYPE_USER_DYNAMIC_TIMEOUT = 342
PB_TYPE_USER_FACEBOOK = 330
PB_TYPE_USER_FINISH_TRAIN = 312
PB_TYPE_USER_FUND_GIVEN = 324
PB_TYPE_USER_GET_INVITE_CODE = 326
PB_TYPE_USER_GIVE_FUND = 323
PB_TYPE_USER_LOADING_DONE = 307
PB_TYPE_USER_LOGIN = 300
PB_TYPE_USER_NOTIFY_EVENT = 329
PB_TYPE_USER_OPEN_CHEST = 306
PB_TYPE_USER_OPPO_VIP_LEVEL = 337
PB_TYPE_USER_QUERY_GCID = 315
PB_TYPE_USER_REGISTER = 301
PB_TYPE_USER_SET_AVATAR = 305
PB_TYPE_USER_SET_AVATAR_FRAME = 317
PB_TYPE_USER_SET_CARD_BACK = 316
PB_TYPE_USER_SET_CHARACTER = 333
PB_TYPE_USER_SET_CONFIG = 319
PB_TYPE_USER_SET_DEF_TROOP = 309
PB_TYPE_USER_SET_EVENT = 314
PB_TYPE_USER_SET_GUIDE = 303
PB_TYPE_USER_SET_NAME = 304
PB_TYPE_USER_SET_NAME_GUIDE = 308
PB_TYPE_USER_SET_SKIN = 335
PB_TYPE_USER_SHARE = 336
PB_TYPE_USER_SPAWN_GOLD = 311
PB_TYPE_USER_TECH_UPGRADE = 320
PB_TYPE_USER_UNLOCK_CHARACTER = 334
PB_TYPE_USER_UPDATE = 331
PB_TYPE_USER_VISIT = 302
PB_TYPE_USER_VISIT_EX = 325
PB_TYPE_USER_VOTE = 339
PB_TYPE_USER_VOTE_RECORD = 340
PB_TYPE_WORLD_ATTACK = 600
PB_TYPE_WORLD_BATTLE_END = 620
PB_TYPE_WORLD_BATTLE_JOIN = 621
PB_TYPE_WORLD_BATTLE_START = 619
PB_TYPE_WORLD_BUY_TICKET = 645
PB_TYPE_WORLD_BUY_TICKET_LEGEND = 696
PB_TYPE_WORLD_BUY_TICKET_SURVIVAL = 666
PB_TYPE_WORLD_BUY_TICKET_SURVIVAL_EX = 684
PB_TYPE_WORLD_CHALLENGE = 603
PB_TYPE_WORLD_CHALLENGE_COMMANDER = 611
PB_TYPE_WORLD_CHALLENGE_ELITE = 610
PB_TYPE_WORLD_CLOSE_MATCH = 656
PB_TYPE_WORLD_CREATE_MATCH = 649
PB_TYPE_WORLD_DAKR_RESET = 664
PB_TYPE_WORLD_DARK_DUEL_DASHBOARD = 662
PB_TYPE_WORLD_DARK_DUEL_RECHEAT = 663
PB_TYPE_WORLD_EXPEDITION = 613
PB_TYPE_WORLD_EXPEDITION_EX = 640
PB_TYPE_WORLD_EXPEDITION_EX_BOSS = 642
PB_TYPE_WORLD_EXPEDITION_OPEN = 616
PB_TYPE_WORLD_FIND = 601
PB_TYPE_WORLD_FIND_EX = 633
PB_TYPE_WORLD_FIND_EX_CANCEL = 634
PB_TYPE_WORLD_FIND_NPC = 637
PB_TYPE_WORLD_FIND_RESET = 635
PB_TYPE_WORLD_FIND_START = 617
PB_TYPE_WORLD_FIND_SURVIVAL = 670
PB_TYPE_WORLD_FIND_SURVIVAL_EX = 688
PB_TYPE_WORLD_GEN_ENVELOPE = 683
PB_TYPE_WORLD_GET_EXPEDITION = 615
PB_TYPE_WORLD_GET_EXPEDITION_EX = 641
PB_TYPE_WORLD_GET_MATCH = 655
PB_TYPE_WORLD_GET_OPPONENT = 636
PB_TYPE_WORLD_JOIN_MATCH = 651
PB_TYPE_WORLD_JOIN_SURVIVAL = 671
PB_TYPE_WORLD_JOIN_SURVIVAL_EX = 689
PB_TYPE_WORLD_JOIN_TEAM = 680
PB_TYPE_WORLD_LEAVE_TEAM = 679
PB_TYPE_WORLD_LOTTERY = 643
PB_TYPE_WORLD_LOTTERY_ACTIVITY = 681
PB_TYPE_WORLD_LOTTERY_EX = 678
PB_TYPE_WORLD_LOTTERY_OPENED = 659
PB_TYPE_WORLD_LOTTERY_UNOPEN = 658
PB_TYPE_WORLD_QUERY_MATCH = 650
PB_TYPE_WORLD_QUIT = 648
PB_TYPE_WORLD_QUIT_LEGEND = 697
PB_TYPE_WORLD_QUIT_MATCH = 652
PB_TYPE_WORLD_QUIT_SURVIVAL = 669
PB_TYPE_WORLD_QUIT_SURVIVAL_EX = 687
PB_TYPE_WORLD_RECOMMEND_TROOP = 661
PB_TYPE_WORLD_RECYCLE_MATCH = 657
PB_TYPE_WORLD_REFRESH_EXPEDITION = 614
PB_TYPE_WORLD_REFRESH_EXPEDITION_EX = 644
PB_TYPE_WORLD_RESCUE = 630
PB_TYPE_WORLD_RESCUE_END = 632
PB_TYPE_WORLD_RESCUE_JOIN = 631
PB_TYPE_WORLD_RESET_LADDER_LOSE = 639
PB_TYPE_WORLD_RESET_SWEEP_COUNT = 609
PB_TYPE_WORLD_RESET_TROOP = 638
PB_TYPE_WORLD_RETREAT = 602
PB_TYPE_WORLD_ROB_EXP = 623
PB_TYPE_WORLD_ROB_GOLD = 622
PB_TYPE_WORLD_ROLL_CHAR = 682
PB_TYPE_WORLD_ROLL_CHAR_SURVIVAL_EX = 695
PB_TYPE_WORLD_SCOUT = 607
PB_TYPE_WORLD_SELECT_CARD = 647
PB_TYPE_WORLD_SELECT_CARD_SURVIVAL = 668
PB_TYPE_WORLD_SELECT_CARD_SURVIVAL_EX = 686
PB_TYPE_WORLD_SELECT_CHAR = 646
PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL = 667
PB_TYPE_WORLD_SELECT_CHAR_SURVIVAL_EX = 685
PB_TYPE_WORLD_SELECT_DARK_TROOP = 665
PB_TYPE_WORLD_SOS = 629
PB_TYPE_WORLD_START_MATCH = 653
PB_TYPE_WORLD_SURVIVAL_EXPLORE_END = 674
PB_TYPE_WORLD_SURVIVAL_EXPLORE_START = 673
PB_TYPE_WORLD_SURVIVAL_EX_EQUIP_SKILL = 694
PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_END = 692
PB_TYPE_WORLD_SURVIVAL_EX_EXPLORE_START = 691
PB_TYPE_WORLD_SURVIVAL_EX_GAME_OVER = 693
PB_TYPE_WORLD_SURVIVAL_EX_HALL_INFO = 690
PB_TYPE_WORLD_SURVIVAL_GAME_OVER = 675
PB_TYPE_WORLD_SURVIVAL_HALL_INFO = 672
PB_TYPE_WORLD_SWEEP = 604
PB_TYPE_WORLD_SWEEP_COPY = 627
PB_TYPE_WORLD_SWEEP_COPY_ONCE = 628
PB_TYPE_WORLD_SWEEP_EXPEDITION = 626
PB_TYPE_WORLD_SWEEP_GOLD = 624
PB_TYPE_WORLD_SWEEP_GOLD_ONCE = 625
PB_TYPE_WORLD_SWEEP_ONCE = 618
PB_TYPE_WORLD_TOGGLE_MATCH = 654
PB_TYPE_WORLD_UPDATE_LOTTERY_INFO = 660
PB_TYPE_WORLD_WORSHIP = 677
PB_TYPE_WORLD_WORSHIP_LIST = 676
