#!../../bin/linux-x86_64/pigcs2

< envPaths

## Register all support components
dbLoadDatabase "../../dbd/iocxxxLinux.dbd"
iocxxxLinux_registerRecordDeviceDriver pdbbase

cd "${TOP}/iocBoot/${IOC}"

## motorUtil (allstop & alldone)
dbLoadRecords("$(MOTOR)/db/motorUtil.db", "P=BL62:pigcs2:")

##
# PI GCS2 support

dbLoadTemplate("PI_GCS2.substitutions")

drvAsynIPPortConfigure("C885_ETH","192.168.62.26:50000",0,0,0)
# Turn on asyn trace
asynSetTraceMask("C885_ETH",0,3)
asynSetTraceIOMask("C885_ETH",0,1)

# PI_GCS2_CreateController(portName, asynPort, numAxes, priority, stackSize, movingPollingRate, idlePollingRate)
PI_GCS2_CreateController("C885", "C885_ETH",6, 0,0, 100, 1000)

# Turn off asyn trace
asynSetTraceMask("C885_ETH",0,1)
asynSetTraceIOMask("C885_ETH",0,0)


iocInit

## motorUtil (allstop & alldone)
motorUtilInit("BL62:pigcs2:")

# Boot complete
