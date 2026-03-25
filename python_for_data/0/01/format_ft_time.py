import time
from datetime import datetime


t = time.time()
tnow = time.localtime()
print(f'Seconds since Junuary 1, 1970: {t:,.4f} or {t:.2e} in centific notation')
print(time.strftime("%b %d %Y", tnow))