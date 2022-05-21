from requests_html import HTMLSession

session = HTMLSession()
r = session.get('http://192.168.0.20:8082/pizza')
print(r.text)
