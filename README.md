# 👷🏾 ABDI - Android app Builder Docker Image

![](https://img.shields.io/badge/Android%20SDK-29-green) ![](https://img.shields.io/badge/Android%20build--tools-29.0.0-green) ![](https://img.shields.io/badge/Gradle%20version-5.6.2-green) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/ivanprok/abdi)
--------

This image has aimed to be a lightweight tool to build android projects and based on gradle official image - [gradle/5.6.2-jdk8](https://hub.docker.com/_/gradle?tab=description).

## How to use
`cd` to your android project folder, and run
```bash
docker run --rm -v $(PWD):/root/project" ivanprok/abdi:latest gradle build
```