FROM ubuntu:xenial

RUN apt-get update && apt-get install -y --no-install-recommends \
  gcc build-essential make wget curl git liblua5.2-dev libedit-dev libpcap-dev libncurses5-dev libncursesw5-dev pkg-config vim net-tools iproute2 netcat iputils-ping

ENV PATH="$PATH:/usr/src/dpdk/x86_64-native-linuxapp-gcc/app/" \
  DPDK_VERSION=17.05 \
  RTE_SDK=/usr/src/dpdk \
  RTE_TARGET=x86_64-native-linuxapp-gcc
  
RUN curl -sSL http://dpdk.org/browse/dpdk/snapshot/dpdk-${DPDK_VERSION}.tar.gz | tar -xz; \
  mv dpdk-${DPDK_VERSION} ${RTE_SDK}
  
# don't build kernel modules
RUN sed -i s/CONFIG_RTE_EAL_IGB_UIO=y/CONFIG_RTE_EAL_IGB_UIO=n/ ${RTE_SDK}/config/common_linuxapp \ 
 && sed -i s/CONFIG_RTE_LIBRTE_KNI=y/CONFIG_RTE_LIBRTE_KNI=n/ ${RTE_SDK}/config/common_linuxapp\ 
 && sed -i s/CONFIG_RTE_KNI_KMOD=y/CONFIG_RTE_KNI_KMOD=n/ ${RTE_SDK}/config/common_linuxapp

# don't build unnecessary stuff
RUN sed -i s/CONFIG_RTE_APP_TEST=y/CONFIG_RTE_APP_TEST=n/ ${RTE_SDK}/config/common_linuxapp

RUN cd ${RTE_SDK} \
  && make install T=${RTE_TARGET} DESTDIR=install -j
  
WORKDIR ${RTE_SDK}/