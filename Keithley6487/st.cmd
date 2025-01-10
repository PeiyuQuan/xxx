errlogInit(5000)
< envPaths
###############################################################################
# Set up environment
epicsEnvSet("P","BL62:K6487:")
epicsEnvSet ("STREAM_PROTOCOL_PATH", "$(IP)/db")
epicsEnvSet("PORT", "serial2")

###############################################################################
# Register all support components
dbLoadDatabase "../../dbd/iocxxxLinux.dbd"
iocxxxLinux_registerRecordDeviceDriver pdbbase

###############################################################################
# Set up ASYN ports
# drvAsynIPPortConfigure port ipInfo priority noAutoconnect noProcessEos
#drvAsynIPPortConfigure("serial2","$(K6487_ADDRESS) $(K6487_PROTOCOL)",0,0,0)
drvAsynIPPortConfigure("serial2","192.168.0.5:4002 COM",0,0,0)
#drvAsynSerialPortConfigure("serial2","/dev/ttyUSB0",0,0,0)
asynOctetSetInputEos("serial2",0,"\r")
asynOctetSetOutputEos("serial2",0,"\r")
#asynSetTraceMask("L0",-1,0x9)
asynSetOption("serial2", -1, "baud", "19200")
asynSetOption("serial2", -1, "bits", "8")
asynSetOption("serial2", -1, "parity", "None")
asynSetOption("serial2", -1, "stop", "1")
#asynSetOption("serial2", -1, "crtscts", "N")
asynSetTraceIOMask("serial2",-1, ESCAPE)
asynSetTraceMask("serial2", -1, ERROR|DRIVER|FLOW)

###############################################################################
# Load record instances
dbLoadTemplate("asynRecord.template")
dbLoadRecords("$(IP)/db/devKeithley6487.db" "P=$(P),R=1:,PORT=serial2,A=-1,NELM=1000")
dbLoadRecords("$(ASYN)/db/asynRecord.db" "P=$(P),R=asyn2,PORT=serial2,ADDR=-1,OMAX=0,IMAX=0")

###############################################################################
# Start IOC

iocInit
