FROM openjdk:8-jdk

USER root

ENV ANDROID_HOME="/usr/local/android-sdk" \
    SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" \
    ANDROID_VERSION=29 \
    ANDROID_BUILD_TOOLS_VERSION=29.0.0 \
    GRADLE_VERSION=5.1.1 \
    GRADLE_DISTRIBUTION_URL="https://services.gradle.org/distributions/gradle" \
    GRADLE_HOME="/root/.gradle" \
    GRADLE_OPTS="-Dorg.gradle.daemon=false"

ENV SDK="$ANDROID_HOME" \
    LICENSES_HOME="$ANDROID_HOME/licenses" \
    PATH="$PATH:$ANDROID_HOME/tools/bin:${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin" \
    GRADLE_DIST_PATH="${GRADLE_HOME}/gradle-${GRADLE_VERSION}-all.zip"
ENV SDK_MANAGER="$ANDROID_HOME/tools/bin/sdkmanager"

# Install SDK tools
RUN echo "Downloading sdk tools..." \
    && mkdir -p $SDK \
    && wget --quiet -O $SDK/sdk-tools.zip $SDK_URL \
    && echo "Extracting sdk tools..." \
    && unzip -q $SDK/sdk-tools.zip -d $ANDROID_HOME\
    && rm $SDK/sdk-tools.zip \
    && mkdir /root/.android/ && touch /root/.android/repositories.cfg \
    && echo "Done"

RUN echo "Applying licenses" \
    && mkdir -p $LICENSES_HOME || true \
    && echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > $LICENSE_HOME/android-sdk-license \
    && yes | $SDK_MANAGER --licenses \
    && echo "Done"

# Install android build tools and libraries
RUN echo "Installing android build tools and libraries..." \
    && $SDK_MANAGER --update \
    && $SDK_MANAGER "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools" | grep -v = || true \
    && echo "Done"

RUN echo "Installing gradle-${GRADLE_VERSION}..." \
    && mkdir ${GRADLE_HOME} \
    && echo "Downloading gradle distribution..." \
    && wget --quiet -O ${GRADLE_DIST_PATH} ${GRADLE_DISTRIBUTION_URL}-${GRADLE_VERSION}-all.zip \
    && echo "Unzipping..." \
    && unzip -q ${GRADLE_DIST_PATH} -d ${GRADLE_HOME} \
    && rm ${GRADLE_DIST_PATH} \
    && echo "Setting executable permissions..." \
    && chmod 755 ${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin/gradle \
    && echo "Done"