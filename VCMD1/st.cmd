#!../../bin/linux-x86_64/vcmd

#- You may have to change vcmd to something else
#- everywhere it appears in this file

< envPaths

## Register all support components
dbLoadDatabase "../../dbd/iocxxxLinux.dbd"
iocxxxLinux_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${IP}/db")
epicsEnvSet("PREFIX", "BL62:vcmd1:")
epicsEnvSet("PORT", "serial1")

drvAsynIPPortConfigure("serial1", "192.168.0.5:4001 COM", 0, 0, 0)
asynSetOption("serial1",0,"baud","9600")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"crtscts","n")

dbLoadRecords("${IP}/db/VCMD1.db","P=$(PREFIX),PORT=serial1")
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn1,PORT=serial1,ADDR=0,IMAX=80,OMAX=80")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db","P=$(PREFIX),PORT=serial1")

iocInit

