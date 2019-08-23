[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Automatically updates macOS application to the new Version.

# Features
- Api - API for uploading/Downloading file app.zip
- Notification: will notify to users if has any new version
- Apply all the [Sparkle](https://github.com/sparkle-project/Sparkle) features

# Usage

## Run Upload Server
- Clone the repository
```
git clone https://github.com/htq287/macos-check-for-updates.git backend
```
- Install dependencies
```sh
npm install
```

- Configure your mongoDB server
```bash
# create the db directory
sudo mkdir -p /data/db
# give the db read/write permissions
sudo chmod 777 /data/db
```
- Start your mongoDB server
```sh
mongod
```

- Build and run the server/drive
```
npm run prod
```

## Updater