# 👷🏾 ABDI - Android app Builder Docker Image
![](https://img.shields.io/badge/Android%20SDK-29-green) ![](https://img.shields.io/badge/Android%20build--tools-29.0.0-green) ![](https://img.shields.io/badge/Gradle%20version-5.6.2-green) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/ivanprok/abdi)

--------

This image has aimed to be a lightweight tool to build android projects and based on [gradle official image](https://hub.docker.com/_/gradle?tab=description).

## Versions
To provide ability to use different versions of used tools (like gradle, android SDK, etc.) this repository will present multiple 
tags which be named by this rule:
`%java_distribution_version%`-`%gradle_version%`-`android_sdk_version`-`android_build_tools_version`.
I.e. `jdk8-5.6.2-29-29.0.0` means that docker container built from this tag will use jdk8, Gradle 5.6.2, Android SDK for API 29 and Android Build tools 29.0.0.

## How to use
`cd` to your android project folder, and run
```bash
docker run --rm -v $(PWD):/root/project" ivanprok/abdi:latest gradle build
```
