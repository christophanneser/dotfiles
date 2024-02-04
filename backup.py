#!/bin/python3
import os
import subprocess
import pickle
from datetime import datetime


HEADER = '\033[95m'
OKBLUE = '\033[94m'
OKCYAN = '\033[96m'
OKGREEN = '\033[92m'
WARNING = '\033[93m'
FAIL = '\033[91m'
ENDC = '\033[0m'
BOLD = '\033[1m'
UNDERLINE = '\033[4m'

def ok(message : str):
    print(OKGREEN + message + ENDC)

def fail(message: str):
    print(FAIL + message + ENDC)

def warn(message: str):
    print(WARNING + message + ENDC)

def underline(message: str):
    print(UNDERLINE + message + ENDC)


def find_partition_by_uuid(uuid) -> str | None:
    try:
        lines = subprocess.check_output(['blkid']).decode('utf-8').split('\n')

        for line in lines:
            # Check if the UUID is in the current line
            if f'UUID="{uuid}"' in line:
                # The first part of the line contains the device path
                device_path = line.split(':')[0]
                return device_path
        return None
    except subprocess.CalledProcessError as e:
        print(e)
        return None
    except Exception as e:
        print(e)
        return None


def find_mount_point(partition) -> str | None:
    try:
        # Execute the mount command and decode the output
        mount_points = subprocess.check_output(['mount']).decode('utf-8').split('\n')

        for mount_point in mount_points:
            # Search the mount command output for the partition
            if partition in mount_point:
                # Extract the mount point assuming that the format is 'device on mount_point type ...'
                parts = mount_point.split(' ')
                if 'on' in parts and parts.index('on') + 1 < len(parts):
                    return parts[parts.index('on') + 1]
        return None  # Return None if the partition is not mounted or not found
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while checking mounted partitions: {e.output.decode('utf-8')}")
        return None
    except Exception as e:
        print(f"An unexpected error occurred: {str(e)}")
        return None


class BackupDevice:
    """Backup device class"""
    BACKUP_MOUNT_POINT = os.path.expanduser('~/.backup-mount-points')

    def __init__(self, name, partition_uuid, path, encrypted=False, unmount_when_finished=False):
        self.name = name
        self.partition_uuid = partition_uuid
        self.path = path
        self.encrypted = encrypted
        self.device_partition = find_partition_by_uuid(self.partition_uuid)
        self.unmount_when_finished = unmount_when_finished
        self.mount_point = None

    def __del__(self):
        if self.unmount_when_finished:
            self._unmount()

    def is_device_connected(self) -> bool:
        return self.device_partition is not None

    def _prepare_device_for_backup(self) -> bool:
        """Prepare the device for backup"""
        if not self._is_device_mounted():
            return self._mount()
        return True

    def backup(self, source: str):
        self._prepare_device_for_backup()
        os.system(f'rsync -r --copy-links {source} {self.get_dest()}')

    def get_dest(self) -> str:
        return self.mount_point + '/' + self.path

    def _is_device_mounted(self):
        if self.mount_point is not None:
            return True
        if self.encrypted:
            fail('Cannot check if an encrypted device is mounted')
            return False
        else:
            self.mount_point = find_mount_point(self.device_partition)
            return self.mount_point is not None

    def _unmount(self):
        if self.mount_point is not None:
            if self.encrypted:
                os.system(f'veracrypt --text --dismount {self.mount_point}')
            else:
                os.system(f'sudo -S umount {self.mount_point}')
        else:
            fail('Cannot unmount device which is not mounted!')

    def _create_mount_point(self):
        os.system(f'mkdir -p {self._preferred_mount_point()}')

    def _preferred_mount_point(self):
        return f'{BackupDevice.BACKUP_MOUNT_POINT}/{self.name}'

    def _mount(self) -> bool:
        if not self.device_partition:
            fail('Device is already mounted!')

        if self.mount_point:
            ok('Device is already mounted!')
        else:
            self._create_mount_point()
            if self.encrypted:
                # mount using VeraCrypt
                try:
                    os.system(f'veracrypt --text {self.device_partition} {self._preferred_mount_point()} ')
                    self.mount_point = self._preferred_mount_point()
                except Exception:
                    fail(f'Fatal: Cannot mount {self.name} using VeraCrypt!')
                    self.mount_point = None
                    return False
            else:
                try:
                    os.system(f'sudo -S mount {self.device_partition} {self._preferred_mount_point()}')
                    self.mount_point = self._preferred_mount_point()
                except Exception:
                    fail(f'{FAIL}Fatal: Cannot mount {self.name} using VeraCrypt!')
                    self.mount_point = None
                    return False
        return True

    def write_backup_info(self):
        self._serialize_last_backup_info()

    def _backup_info_filename(self) -> str:
        return self.get_dest() + '.backup.info'

    def _serialize_last_backup_info(self):
        with open(self._backup_info_filename(), 'w+b') as file:
            pickle.dump(datetime.now(), file)

    def _deserialize_last_backup_info(self) -> datetime | None:
        if os.path.exists(self._backup_info_filename()):
            with open(self._backup_info_filename(), 'rb') as file:
                return pickle.load(file)
        return None

    def __repr__(self) -> str:
        result = f'BackupDevice {UNDERLINE}{self.name}{ENDC}:\n' \
                 f'\tUUID: {self.partition_uuid}\n' \
                 f'\tPath: {self.path}\n' \
                 f'\tEncrypted: {self.encrypted}\n' \
                 f'\tDevice: ' \
                 f'{OKGREEN + self.device_partition + ENDC if self.device_partition else FAIL + "not connected" + ENDC}'
        last_backup = None
        if self.device_partition:
            if not self.mount_point:
                self._mount()
            last_backup = self._deserialize_last_backup_info()

        def days_since_last_backup(backup_time: datetime) -> str:
            delta = datetime.now() - backup_time
            days = delta.days
            if int(days) > 6:
                return f'{FAIL}{days} days!{ENDC}'
            if int(days) > 2:
                return f'{WARNING}{days} days!{ENDC}'
            return f'{OKGREEN}{days} day(s)!{ENDC}'

        result += f'\n\t{"Last Backup: " + days_since_last_backup(last_backup) if last_backup else FAIL + "No backup found!" + ENDC}'
        return result


backup_destinations = [
    BackupDevice('Toshiba1Tb', partition_uuid='XXX', path='files-backup', unmount_when_finished=True),
    BackupDevice('Crucial500Gb', partition_uuid='YYY', path='', encrypted=True, unmount_when_finished=True),
]

# No closing dash, otherwise not the folder itself but its content is copied
backup_src = []

if __name__ == '__main__':
    for device in backup_destinations:
        print('Should backup to the following location?')
        print(device)
        print('[y/N]')
        answer = input()
        if 'y' in answer:
            for src in backup_src:
                device.backup(src)
            device.write_backup_info()
