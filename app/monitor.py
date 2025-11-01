import requests, time, os, logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s: %(message)s')

# List of websites to monitor (edit as needed)
SITES = [
    "https://google.com",
    "https://github.com",
    "https://stackoverflow.com"
]

# Telegram Bot details (set as env vars)
BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
CHAT_ID = os.getenv("TELEGRAM_CHAT_ID")

def send_alert(message):
    if not BOT_TOKEN or not CHAT_ID:
        logging.warning("Telegram credentials not set. Skipping alert: %s", message)
        return
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    payload = {"chat_id": CHAT_ID, "text": message}
    try:
        resp = requests.post(url, data=payload, timeout=10)
        logging.info("Telegram response: %s", resp.text)
    except Exception as e:
        logging.exception("Failed to send Telegram alert: %s", e)

def check_sites():
    for site in SITES:
        try:
            r = requests.get(site, timeout=10)
            if r.status_code == 200:
                logging.info("✅ %s is UP", site)
            else:
                logging.warning("⚠️ %s returned %s", site, r.status_code)
                send_alert(f"⚠️ {site} returned {r.status_code}")
        except Exception as e:
            logging.error("🚨 %s seems DOWN! Error: %s", site, e)
            send_alert(f"🚨 {site} seems DOWN! Error: {e}")

if __name__ == "__main__":
    interval = int(os.getenv("CHECK_INTERVAL", "300"))  # default 300s = 5 minutes
    logging.info("Starting uptime monitor. Interval=%s seconds", interval)
    while True:
        check_sites()
        time.sleep(interval)
