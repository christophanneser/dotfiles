# Workflow and Setup
Currently use Google Drive for cloud backup and synchronization.

For smooth integration into Linux, use (rclone)[https://github.com/rclone/rclone].

SetUp with Google Drive:
1. Create profile using `rclone config` and follow instructions
2. Enter already created API key and secret to use the GDrive API
3. Synchronize selected folders using `rclone sync [remote:path] [local-path]

Example `cron` file:
```
# m h  dom mon dow   command
* * * * * rclone copy christophanneser:Internship ~/intern/gdrive
* * * * * rclone copy ~/intern/gdrive christophanneser:Internship
```
