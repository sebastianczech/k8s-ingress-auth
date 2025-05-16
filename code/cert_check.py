import requests
import logging

logging.basicConfig()
logging.getLogger().setLevel(logging.DEBUG)
requests_log = logging.getLogger("urllib3")
requests_log.setLevel(logging.DEBUG)
requests_log.propagate = True

response = requests.get('https://github.com', verify='external_cert_root_ca.pem')
response = requests.get('https://github.com', verify='external_cert_chain.pem')
response = requests.get('https://github.com', verify=True)
response = requests.get('https://github.com', verify=False)

# print(response.status_code)
# print(response.text)