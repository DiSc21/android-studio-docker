# FROM ubuntu:18.04
# FROM osrf/ros@sha256:ccd7251088cb37c2add84d78594aa582fac2765c0b4421b5a0bf7a534f013a86
#FROM ubuntu@sha256:0fedbd5bd9fb72089c7bbca476949e10593cebed9b1fb9edf5b79dbbacddd7d6
FROM ubuntu:jammy-20231211.1

# install basic libraries
RUN apt-get update && apt-get install -y
RUN apt-get install -y --no-install-recommends --fix-missing ninja-build curl gcc git gnupg2 wget build-essential lsb-release software-properties-common

# install cmake 
CMD mkdir /opt/cmake
WORKDIR /opt/cmake/
RUN wget --no-check-certificate https://github.com/Kitware/CMake/releases/download/v3.22.0-rc2/cmake-3.22.0-rc2-linux-x86_64.sh
RUN sh cmake-3.22.0-rc2-linux-x86_64.sh --skip-license
ENV PATH="/opt/cmake/bin/:${PATH}"

# install gtest
RUN /bin/bash -c "mkdir -p /third_party/gtest && cd /third_party/gtest && \
    tar -xvz --strip 1 -f <(wget --no-check-certificate -q -O - https://github.com/google/googletest/archive/refs/tags/release-1.11.0.tar.gz) && \
    cmake -Bbuild -GNinja . && cmake --build build --target install && rm -rf /third_party/"

# llvm for clang format 14
#RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
#    && add-apt-repository "deb http://apt.llvm.org/bionic/   llvm-toolchain-bionic  main" \
#    && add-apt-repository "ppa:ubuntu-toolchain-r/test" \
#    && apt-get update && apt-get install -y --no-install-recommends --fix-missing clang-format
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing clang-format

#RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing openjdk-18-jdk
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing default-jdk

CMD mkdir /tmp/gradle
WORKDIR /tmp/gradle/
RUN wget --no-check-certificate https://services.gradle.org/distributions/gradle-8.5-bin.zip

RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing unzip zip
CMD mkdir /opt/gradle
RUN /bin/bash -c "unzip -d /opt/gradle gradle-8.5-bin.zip"
ENV PATH="/opt/gradle/gradle-8.5/bin/:${PATH}"
CMD ["gradle -v"]

# install nvidia drivers
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y --no-install-recommends --fix-missing software-properties-common nvidia-driver-455

# setup kvm dependencies
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing iptables qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing mesa-utils
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing libgl1-mesa-dri libgl1-mesa-glx
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing virtinst virt-viewer
#RUN add-apt-repository "ppa:opencpn/opencpn" && apt-get update && apt-get install opencpn libgl1-mesa-dri libgl1-mesa-glx virtinst virt-viewer
RUN /bin/bash -c "adduser root kvm && adduser root libvirt"

# install rustc
#RUN apt-get install -y --no-install-recommends --fix-missing rustc
#CMD ["rustc --version"]

# install gtk3 glad
#RUN apt-get install -y --no-install-recommends --fix-missing glade pkg-config libgtk-3-dev libgtkmm-3.0-dev libgstreamermm-1.0-dev
#RUN apt-get purge fcitx-module-dbus
#ENV PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/x86_64-linux-gnu/gtkmm-3.0/include/:/usr/share/pkgconfig:${PKG_CONFIG_PATH}"

# install freeglut and mesa libraries
RUN apt-get install -y --no-install-recommends --fix-missing mesa-common-dev mesa-utils freeglut3-dev  

RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing libc6-i386 lib32z1

CMD ["java --version"]

RUN add-apt-repository "ppa:maarten-fonville/android-studio" && apt-get update \
  && apt-get install -y --no-install-recommends --fix-missing android-studio

# install firefox
RUN apt-get install -y --no-install-recommends --fix-missing firefox
ENV BROWSER=/usr/bin/firefox

#RUN /bin/bash -c "yes | ~/Android/Sdk/tools/bin/sdkmanager --licenses"
#Run /bin/bash -c "mkdir ~/android && cd ~/android && wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip"
#RUN apt-get install -y --no-install-recommends --fix-missing zip unzip vim
#Run /bin/bash -c "cd ~/android && unzip commandlinetools-linux-7583922_latest.zip && rm commandlinetools-linux-7583922_latest.zip"
#Run /bin/bash -c "cd ~/android/cmdline-tools && mkdir ../tools && mv * ../tools/ && mv ../tools ."
#
#Run /bin/bash -c 'echo "export ANDROID_HOME=\$HOME/android" >> $HOME/.bashrc \
#    && echo "export PATH=\$ANDROID_HOME/cmdline-tools/tools/bin/:\$PATH" >> /root/.bashrc \
#    && echo "export PATH=\$ANDROID_HOME/cmdline-tools/emulator/:\$PATH" >> /root/.bashrc \
#    && echo "export PATH=\$ANDROID_HOME/cmdline-tools/platform-tools/:\$PATH" >> /root/.bashrc \
#    && echo "y" | $HOME/android/cmdline-tools/tools/bin/sdkmanager --install "platform-tools" "platforms;android-29" "build-tools;29.0.2" "emulator" '

# install marp
#RUN /bin/bash -c "cd /usr/bin/ && tar -xvz -f <(wget --no-check-certificate -q -O - https://github.com/marp-team/marp-cli/releases/download/v1.4.2/marp-cli-v1.4.2-linux.tar.gz)";

# define alias for starting android studio
#Run /bin/bash -c 'echo "alias android_studio=/opt/android-studio-2020.3.1/android-studio/bin/studio.sh" >> /root/.bashrc'
#Run /bin/bash -c 'echo "alias android_studio=/opt/android-studio-2020.3.1/android-studio/bin/studio.sh" >> /root/.bashrc'
#               && ln -s /root/android_docker_deps/AndroidStudioConfig/ /root/.config/Google/AndroidStudio2020.3 \

# create link to mounted android config deps
#RUN /bin/bash -c "mkdir -p /root/android_docker_deps/ && mkdir -p /root/.config/Google/ && mkdir -p /root/.local/"
               #&& ln -s /root/android_docker_deps/AndroidStudioConfig/ /root/.config/Google/AndroidStudio2023.1 \
#RUN /bin/bash -c "mkdir -p /root/android_docker_deps/ && mkdir -p /root/.config/Google/ && mkdir -p /root/.local/ \
#               && ln -s /root/android_docker_deps/AndroidVD/ /root/.android \
#               && ln -s /root/android_docker_deps/AndroidGradle/ /root/.gradle "
##               && ln -s /root/android_docker_deps/AndroidGradle/ /root/.gradle \
##               && ln -s /root/android_docker_deps/AndroidLocalShareHome/ /root/.local/share "

CMD mkdir /ws/
WORKDIR /ws/

