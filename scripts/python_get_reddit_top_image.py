#!/usr/bin/python3

import json
import requests as req
import os

CMP_FIELD = 'created_utc'

TIME_HOUR = 'hour'
TIME_WEEK = 'week'
TIME_DAY = 'day'
TIME_MONTH = 'month'
TIME_YEAR = 'year'
TIME_ALL = 'all'

imageFolder = 'images'
skipMultiple = True
maxImages = 10
TOP_OF = TIME_MONTH

USER_AGENT = 'Wallpaperscript/0.1 by k1lso'
USER_ID = 'hs_ArJmxBT3pBQ'
SECRET = '40_1uykBIBeAjjlSox0ccTOzTYU'

endpoints = {
        'auth': 'https://www.reddit.com/api/v1/access_token',
        'authRevoke': 'https://www.reddit.com/api/v1/revoke_token',
        'hot' : 'https://oauth.reddit.com/r/{name}/hot/.json',

        'subr': [
            'wallpaper',
            'skyporn', 
            'earthporn', 
            'multiwall', 
            'wallpapers']
        }



def readFromFile(filename):
    with open(filename, 'r') as f:
        alllines = f.read()
        return json.loads(alllines)

def authorize():
    print('authorizing')
    auth = req.auth.HTTPBasicAuth(USER_ID, SECRET)

    headers = {
            'User-Agent': USER_AGENT,
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded'
            }
    resp = req.post(endpoints['auth'], 
            auth=auth,
            data=f'grant_type=client_credentials', 
            headers=headers)
    try:
        resp = resp.json()
    except:
        print('Answer is not json-convertible')
        return None

    if 'access_token' in resp and 'token_type' in resp:
        return (resp['token_type'], resp['access_token'])

    else:
        print('Access token not present')
    return None


def revoke(token, token_type):
    print('resetting token')
    headers = {
            'User-Agent': USER_AGENT,
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded'
            }
    resp = req.post(
            endpoints['authRevoke'],
            data=f'token={token}&token_type_hint={token_type}',
            headers=headers)
    return resp.json()


def populateEndpoint(url, subreddit):
    return url.format(name=subreddit)

def main():
    global endpoints

    token_tuple = authorize()
    if token_tuple is None:
        print('No auth token provided: Exiting')
        exit(1)
    else:
        (token_type, token) = token_tuple
    
    standardHeaders = {
        'User-Agent': USER_AGENT,
        'Accept': 'application/json',
        'Authorization': f'{token_type} {token}',
        }

    session = req.Session()
    session.headers.update(standardHeaders)

    chosenImage = {
            'path': '',
            'score': 0
            }

    if not os.path.exists(imageFolder):
        os.mkdir(imageFolder)

    for cSubr in endpoints['subr']:
        resp = req.get(
            populateEndpoint(
                endpoints['hot'],
                cSubr),
            headers=session.headers,
            allow_redirects=True, 
            params={'limit': maxImages, 't': TOP_OF})

        resp = resp.json()
        # print(json.dumps(resp, indent=3))
        # exit(0)

        #resp = readFromFile('resp.txt')
        if      'data' in resp and \
                'children' in resp['data'] and \
                len(resp['data']['children']) > 0:

            if not os.path.exists(os.path.join(imageFolder, cSubr)):
                os.mkdir(os.path.join(imageFolder, cSubr))



            c = 1
            for cChild in resp['data']['children']:
                if 'data' in cChild and 'url' in cChild['data'] and CMP_FIELD in cChild['data']:
                    cLink = cChild['data']['url']
                    print(f'current image: {cLink} \n score: {cChild["data"][CMP_FIELD]}')
                    if not cLink.endswith(('jpg', 'jpeg', 'gif', 'png', 'tif', 'tiff', 'bmp')):
                        print('Not an image. Skipping!')
                        continue # skip current link
                    image = req.get(cLink, allow_redirects=False)
                    
                    # Determine if the current image is topping the current chosen image
                    imagePath = os.path.abspath(os.path.join('.', imageFolder, cSubr, f'{c}_{cLink.split("/")[-1]}')) # f'./{imageFolder}/{cSubr}/{c}_{cLink.split("/")[-1]}'
                    if cChild['data'][CMP_FIELD] > chosenImage['score']:
                        chosenImage = {
                                'path': imagePath,
                                'score': cChild['data'][CMP_FIELD]
                                }


                    with open(imagePath, 'wb') as newf:
                        newf.write(image.content)

                    

                    if skipMultiple:
                        break
                else:
                    print('No picture found in the current post, going forward')
                c += 1


        else:
            print(f'error while requesting from the api of subreddit "{cSubr}", got:')
            print(json.dumps(resp, indent=4))

    print(f'File Path: {chosenImage["path"]}, score: {chosenImage["score"]}')
    print(json.dumps(revoke(token, token_type), indent=4))
    return chosenImage['path']


def setBackground(filePath):
    pass

if __name__ == '__main__':
    path = main()
    setBackground(path)
