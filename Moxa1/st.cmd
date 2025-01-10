#!../../bin/linux-x86_64/stanfordSR570

## You may have to change stanfordSR570 to something else
## everywhere it appears in this file

< envPaths
#!../../bin/linux-x86_64/vcmd


## Register all support components
dbLoadDatabase "../../dbd/iocxxxLinux.dbd"
iocxxxLinux_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${IP}/db")
epicsEnvSet("PREFIX", "BL62:SR570:")

#################### The first SR570###################

epicsEnvSet("PORT", "serial3")
epicsEnvSet("M","M1:")
drvAsynIPPortConfigure("serial3", "192.168.0.5:4003 COM", 0, 0, 0)
asynOctetSetInputEos("serial3",0,"\r\n")
asynOctetSetOutputEos("serial3",0,"\r\n")
dbLoadRecords("${IP}/db/sr570.db","P=$(PREFIX),M=$(M),PORT=serial3")
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn3,PORT=serial3,ADDR=0,IMAX=80,OMAX=80")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db","P=$(PREFIX),PORT=serial3")

#################### The second SR570###################

epicsEnvSet("PORT", "serial4")
epicsEnvSet("M","M2:")
drvAsynIPPortConfigure("serial4", "192.168.0.5:4004 COM", 0, 0, 0)
asynOctetSetInputEos("serial4",0,"\r\n")
asynOctetSetOutputEos("serial4",0,"\r\n")
dbLoadRecords("${IP}/db/sr570.db","P=$(PREFIX),M=$(M),PORT=serial4")
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn4,PORT=serial4,ADDR=0,IMAX=80,OMAX=80")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db","P=$(PREFIX),PORT=serial4")

#################### The third SR570###################

epicsEnvSet("PORT", "serial5")
epicsEnvSet("M","M3:")
drvAsynIPPortConfigure("serial5", "192.168.0.5:4005 COM", 0, 0, 0)
asynOctetSetInputEos("serial5",0,"\r\n")
asynOctetSetOutputEos("serial5",0,"\r\n")
dbLoadRecords("${IP}/db/sr570.db","P=$(PREFIX),M=$(M),PORT=serial5")
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn5,PORT=serial5,ADDR=0,IMAX=80,OMAX=80")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db","P=$(PREFIX),PORT=serial5")

#################### The fourth SR570###################

epicsEnvSet("PORT", "serial6")
epicsEnvSet("M","M4:")
drvAsynIPPortConfigure("serial6", "192.168.0.5:4006 COM", 0, 0, 0)
asynOctetSetInputEos("serial6",0,"\r\n")
asynOctetSetOutputEos("serial6",0,"\r\n")
dbLoadRecords("${IP}/db/sr570.db","P=$(PREFIX),M=$(M),PORT=serial6")
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX),R=asyn6,PORT=serial6,ADDR=0,IMAX=80,OMAX=80")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db","P=$(PREFIX),PORT=serial6")
set_pass0_restoreFile("sr570_settings.sav")

< autosave.cmd
iocInit()
create_monitor_set("sr570_settings.req", 30, "P=$(PREFIX)")


