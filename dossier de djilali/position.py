import androidhelper, time
droid = androidhelper.Android()
droid.startLocating()
time.sleep(15)
loc = droid.readLocation().result
if loc = {}:
  loc = getLastKnownLocation().result
if loc != {}:
  try:
    n = loc['gps']
  except KeyError:
    n = loc['network']
  la = n['latitude']
  lo = n['longitude']
  address = droid.geocode(la, lo).result
droid.stopLocating()