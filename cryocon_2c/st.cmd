#!../../bin/linux-x86_64/cryocon

#- You may have to change cryocon to something else
#- everywhere it appears in this file

< envPaths

#cd "${TOP}"

## Register all support components
dbLoadDatabase "../../dbd/iocxxxLinux.dbd"
iocxxxLinux_registerRecordDeviceDriver pdbbase


epicsEnvSet ("STREAM_PROTOCOL_PATH", "${IP}/db")
epicsEnvSet("PREFIX", "BL62:cryocon:")
epicsEnvSet("PORT", "serial1")

drvAsynIPPortConfigure("serial1", "192.168.1.5:5000", 0, 0, 0)

asynOctetSetInputEos("serial1",0,"\r\n")
asynOctetSetOutputEos("serial1",0,"\n")

# Load asyn records on all serial ports
asynSetTraceIOMask("serial1",0,2)
asynSetTraceMask("serial1",0,9)

dbLoadRecords("${IP}/db/cryocon_24c_inp.db","P=$(PREFIX),PORT=serial1,M=m1:,N=A")
dbLoadRecords("${IP}/db/cryocon_24c_inp.db","P=$(PREFIX),PORT=serial1,M=m2:,N=B")
dbLoadRecords("${IP}/db/cryocon_24c_inp.db","P=$(PREFIX),PORT=serial1,M=m3:,N=C")
dbLoadRecords("${IP}/db/cryocon_24c_inp.db","P=$(PREFIX),PORT=serial1,M=m4:,N=D")

dbLoadRecords("${IP}/db/cryocon_24c_loop.db","P=$(PREFIX),M=m1:,PORT=serial1,N=1")
dbLoadRecords("${IP}/db/cryocon_24c_loop.db","P=$(PREFIX),M=m2:,PORT=serial1,N=2")
dbLoadRecords("${IP}/db/cryocon_24c_loop.db","P=$(PREFIX),M=m3:,PORT=serial1,N=3")
dbLoadRecords("${IP}/db/cryocon_24c_loop.db","P=$(PREFIX),M=m4:,PORT=serial1,N=4")

dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX),R=asyn1,PORT=serial1,ADDR=0,IMAX=80,OMAX=80")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=$(PREFIX),PORT=serial1")
cd ${TOP}/iocBoot/ioccryocon24c
< autosave.cmd

iocInit
create_monitor_set(cryocon_settings.req, 30, "P=$(PREFIX),M1=m1:,M2=m2:,M3=m3:,M4=m4:")

