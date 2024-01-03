FROM ubuntu:jammy-20231211.1

RUN apt-get update && apt-get install -y

#--------------------------------------------------------------
#---- Some standard libraries/tools ---------------------------
#--------------------------------------------------------------

# install basic libraries
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing libc6-i386 lib32z1
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing sudo curl wget zip unzip
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing ca-certificates libldap-common iptables gnupg2 lsb-release
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing vim vim-common vim-runtime vim-scripts exuberant-ctags
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing xorg

# install google-chrome
WORKDIR /tmp
ARG CHROME_URL="https://dl.google.com/linux/direct/"
ARG CHROME_DEB="google-chrome-stable_current_amd64.deb"
RUN wget --progress=bar:force:noscroll --no-check-certificate ${CHROME_URL}${CHROME_DEB} && apt-get install -y --no-install-recommends --fix-missing ./${CHROME_DEB}
ENV BROWSER=/usr/bin/google-chrome


#--------------------------------------------------------------
#---- Some standard c++ dev tools -----------------------------
#--------------------------------------------------------------

RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing ninja-build gcc git build-essential software-properties-common
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing make cmake
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing clang-format clang-tidy
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing googletest-tools


#--------------------------------------------------------------
#---- NVIDIA drivers and virtualization tools -----------------
#--------------------------------------------------------------

# install nvidia drivers (DEBIAN_FRONTEND noninteractive to skip country commandline input)
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y --no-install-recommends --fix-missing software-properties-common nvidia-driver-455

# setup kvm dependencies
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing usbutils mesa-utils mesa-common-dev
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing libgl1-mesa-dri libgl1-mesa-glx
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing virtinst virt-viewer

RUN adduser root libvirt
RUN adduser root kvm


#--------------------------------------------------------------
#---- Some standard c++ dev tools -----------------------------
#--------------------------------------------------------------

# install java development kit
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing default-jdk

# install gradle 8.5
CMD mkdir /tmp/gradle
WORKDIR /tmp/gradle/
RUN wget --progress=bar:force:noscroll --no-check-certificate https://services.gradle.org/distributions/gradle-8.5-bin.zip
CMD mkdir /opt/gradle && /bin/bash -c "unzip -d /opt/gradle gradle-8.5-bin.zip"
ENV PATH="/opt/gradle/gradle-8.5/bin/:${PATH}"


# install freeglut and mesa libraries
#RUN apt-get install -y --no-install-recommends --fix-missing mesa-common-dev mesa-utils freeglut3-dev


#--------------------------------------------------------------
#---- create user/group for host user in docker ---------------
#--------------------------------------------------------------

# get user id
ARG ARG_USER_ID=1000
ENV USER_ID=$ARG_USER_ID

# get user name
ARG ARG_GROUP_ID=1000
ENV GROUP_ID=$ARG_GROUP_ID

# get group id
ARG ARG_USER_NAME="john_doe"
ENV USER_NAME=$ARG_USER_NAME

# get group name
ARG ARG_GROUP_NAME="john_doe"
ENV GROUP_NAME=$ARG_GROUP_NAME

# create user and group
RUN groupadd -g $GROUP_ID -r $GROUP_NAME
RUN useradd -u $USER_ID -g $GROUP_ID --create-home -r $USER_NAME
VOLUME /home/${USER_NAME}

RUN usermod -aG sudo $USER_NAME
RUN usermod -aG plugdev $USER_NAME

#Change password
RUN echo "$USER_NAME:$USER_NAME" | chpasswd
#Make sudo passwordless
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-$USER_NAME

RUN adduser $USER_NAME libvirt
RUN adduser $USER_NAME kvm

WORKDIR /home/$USER_NAME


#--------------------------------------------------------------
#---- Install Android Studio ----------------------------------
#--------------------------------------------------------------

RUN add-apt-repository "ppa:maarten-fonville/android-studio" && apt-get update \
  && apt-get install -y --no-install-recommends --fix-missing android-studio
ENV ANDROID_EMULATOR_USE_SYSTEM_LIBS=1


#--------------------------------------------------------------
#---- Some final docker build steps (usr/wd/envs/...) ---------
#--------------------------------------------------------------

USER $USER_NAME

ENV BROWSER=/usr/bin/google-chrome
ENV ANDROID_EMULATOR_USE_SYSTEM_LIBS=1

#COPY .docker/docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
#ENTRYPOINT [ "/usr/local/bin/docker_entrypoint.sh" ]
ENTRYPOINT ["/bin/bash", "-c", "/ws/.docker/docker_entrypoint.sh"]
