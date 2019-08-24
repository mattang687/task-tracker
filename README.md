# Task Tracker

## Introduction

Recently, I've been inspired by bullet journaling as a way to be more productive by setting goals for myself before I start my day and checking them off as I make progress. The permanence of pen on paper has made me feel more accountable for what I set out to do each day, and that's a feeling I sense is missing from many checklist or to-do apps. It's too easy to edit and move tasks around so that it feels like you've accomplished a lot when in reality you only did half the things you wanted to.

Task Tracker is a time management app designed to mimic the feeling of using a pen and paper while providing the benefits of a more tech-savvy approach (not having to carry a notebook and pen around, mainly). Once you've committed a task to the app, it stays there (though you can still edit it at a slight cost to your convenience). When you move and cancel tasks that you commit, they won't disappear entirely from the day's view. Instead, a change in color and icon will indicate that they've been changed, and a new task will appear if you've moved it.

## Key Features

- Keeps you accountable for tasks by keeping the original entry when moving or canceling them (you can still bypass this if you make a mistake in the original entry, but it is slightly less convenient)
- All of the day's tasks, complete and incomplete, are shown ordered by time, giving you an overview of your schedule and productivity whenever you open the app

## Technologies

- Flutter 1.7
  - sqflite 1.1.6
  - provider 3.0.0
  - table_calendar 2.0.0

## Installation

To install the app, you will need Flutter. Clone this repo, connect your device and run

```
flutter clean
flutter build apk
flutter install
```

for Android, or

```
flutter clean
flutter build ios
flutter install
```

for iOS.
