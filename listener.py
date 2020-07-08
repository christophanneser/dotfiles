#!/usr/bin/env python3

import atexit
import argparse
import re
import json
import os
from pathlib import Path
import time
import subprocess
from watchdog.observers import Observer
from watchdog.events import LoggingEventHandler, FileModifiedEvent, FileCreatedEvent
import sys

DEFAULT_CONFIG_PATH = ".listener-config"


class FileChecker():
    def __init__(self, config):
        self.files = config.files
        self.regex_patterns = []
        for regex in config.regexes:
            try:
                self.regex_patterns.append(re.compile(regex))
            except:
                print("Error in your regex \"" + regex + "\"")
                exit(1)

    def check(self, path):
        for regex in self.regex_patterns:
            if regex.match(path):
                return True
        for f in self.files:
            if f in path:
                return True
        return False


class Configuration():
    def __init__(self, file_path):
        f = open(file_path, "r")
        content = f.readlines()
        f.close()

        content = " ".join(content).replace("\n", "")
        self.config = json.loads(content)

        self.files = self.config["files"]
        self.regexes = self.config["regexes"]
        self.commands = self.config["commands"]
        self.exit_commands = self.config["exit_commands"]

        print("use the following configuration: " + str(self))

    def __repr__(self):
        return str(self.config)

class Event(LoggingEventHandler):
    def __init__(self, file_checker, config):
        self.file_checker = file_checker
        self.config = config

    def dispatch(self, event):
        if not (isinstance(event, FileModifiedEvent) or isinstance(event, FileCreatedEvent)) or not self.file_checker.check(event.src_path):
            return

        print(event.src_path)
        for command in self.config.commands:
            os.system(command)

def store_default_config():
    config = {
            "files": [],
            "regexes": [".*.py"],
            "commands": ["cp main.tex _tmp.tex", "pdflatex _tmp", "cp _tmp.pdf main.pdf"],
            "exit_commands": ["rm _tmp*"],
            }
    with open('.listener-config', 'w', encoding='utf-8') as f:
        json.dump(config, f, ensure_ascii=False, indent=4)


def exit_handler(exit_commands):
    for exit_command in exit_commands:
        os.system(exit_command)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='File listener to mainly support LaTex dev')
    parser.add_argument('-i', help='create default config file stored in .listener.config', action='store_true')
    parser.add_argument('-c', dest="config", type=str, help='used if config file is different to .listener.config')

    args = parser.parse_args()
    print(args)

    if args.i:
        store_default_config()
        print("wrote config file to .listener-config")
        exit(0)

    if hasattr(args, 'c') and args.c is not None:
        config_file_path = args.c
    else:
        config_file_path = DEFAULT_CONFIG_PATH

    config = Configuration(config_file_path)
    current_working_dir = os.getcwd()
    observer = Observer()
    file_checker = FileChecker(config)
    event_handler = Event(file_checker, config)
    observer.schedule(event_handler, current_working_dir, recursive=True)
    observer.start()

    # register handler for exit
    atexit.register(exit_handler, config.exit_commands)

    try:
        while True:
            time.sleep(4)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
