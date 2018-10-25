#!/bin/bash
IF="sriov-dpdk" 
export cid="$(sed -ne '/hostname/p' /proc/1/task/1/mountinfo | awk -F '/' '{print $6}')-$IF" 
export PCIADDR="$(awk -F '"' '{print $4}' /sriov-cni/$cid)" 
export CORES=`printenv CMK_CPUS_ASSIGNED` 
COMMAND=${@//'$CORES'/$CORES} 
COMMAND=${COMMAND//'$PCIADDR'/$PCIADDR} 
$COMMAND