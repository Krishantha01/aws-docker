import flask
from time_zone import *
import mail
import logging
import watchtower


logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)-8s %(message)s', datefmt='%Y-%m-%d %H:%M:%S')
logger = logging.getLogger(__name__)
console_handler = logging.StreamHandler()
cw_handler = watchtower.CloudWatchLogHandler(
                log_group='flask-app',
                stream_name='flask-app')
#logger.addHandler(watchtower.CloudWatchLogHandler())
logger.addHandler(console_handler)
logger.addHandler(cw_handler)



logger.info("application started")

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    try:
        logger.info("sending the results")
        return return_time()
    except Exception as e:
        logger.info("faiure in the script")
        mail.send_mail(str(e),"Api Failure")
