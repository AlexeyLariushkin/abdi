FROM gradle:5.6.2-jdk8

ENV ANDROID_VERSION=28 \
    ANDROID_BUILD_TOOLS_VERSION=28.0.3 \
    ANDROID_HOME="/usr/local/android-sdk" \
    SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" \
    GRADLE_OPTS="-Dorg.gradle.daemon=false -Dorg.gradle.caching=true"

ENV SDK="$ANDROID_HOME" \
    LICENSES_HOME="$ANDROID_HOME/licenses" \
    PATH="$PATH:${ANDROID_HOME}/tools/bin:${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin"

ENV SDK_MANAGER="${ANDROID_HOME}/tools/bin/sdkmanager"

# Install SDK tools
RUN echo "Downloading sdk tools..." \
    && mkdir -p $SDK \
    && wget --quiet -O $SDK/sdk-tools.zip $SDK_URL \
    && echo "Extracting sdk tools..." \
    && unzip -q $SDK/sdk-tools.zip -d $ANDROID_HOME\
    && rm $SDK/sdk-tools.zip \
    && mkdir /root/.android/ && touch /root/.android/repositories.cfg

# Applying licenses
RUN echo "Applying licenses" \
    && mkdir -p $LICENSES_HOME || true \
    && echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > $LICENSE_HOME/android-sdk-license \
    && yes | $SDK_MANAGER --licenses

# Install android build tools and libraries
RUN echo "Installing android build tools and libraries..." \
    && $SDK_MANAGER --update \
    && $SDK_MANAGER "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools" | grep -v = || true

WORKDIR /root/project