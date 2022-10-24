import androidhelper, time
droid = androidhelper.Android()
droid.startLocating()
print('reading GPS ...')
event=droid.eventWaitFor('location', 10000)
while 1:
    try :
        provider = event.result['data']['gps']['provider']
        if provider == 'gps':
            lat = str(event['data']['gps']['latitude'])
            lng = str(event['data']['gps']['longitude'])
            latlng = 'lat: ' + lat + ' lng: ' + lng
            print(latlng)
            break
        else: continue
    except KeyError:
       continue