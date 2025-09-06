< envPaths

# Tell EPICS all about the record types, device-support modules, drivers, etc.
dbLoadDatabase("../../dbd/iocxxxLinux.dbd")
iocxxxLinux_registerRecordDeviceDriver(pdbbase)
epicsEnvSet("PREFIX","BL172:MDrive:")
###s Motors
# Motors substitutions, customize this for your motor
dbLoadTemplate "motor.substitutions"

# Configure asyn communication port, first
# drvAsynIPPortConfigure(IOPortName, port, priority, disable auto-connect, no process EOS)
drvAsynIPPortConfigure("serial1", "192.168.33.7:503", 0, 0, 0 )
drvAsynIPPortConfigure("serial2", "192.168.33.8:503", 0, 0, 0 )
drvAsynIPPortConfigure("serial3", "192.168.33.9:503", 0, 0, 0 )
drvAsynIPPortConfigure("serial4", "192.168.33.10:503", 0, 0, 0 )
#asynSetTraceIOMask("serial2",0,ESCAPE)
#asynSetTraceMask("serial2",0,ERROR|DRIVER)
# Configure one controller per motor, each controller just has 1 axis
# motorPortName, portName, deviceName, movingPollPeriod, idlePollPeriod
ImsMDrivePlusCreateController("IMS1", "serial1", "", 200, 5000)
ImsMDrivePlusCreateController("IMS2", "serial2", "", 200, 5000)
ImsMDrivePlusCreateController("IMS3", "serial3", "", 200, 5000)
ImsMDrivePlusCreateController("IMS4", "serial4", "", 200, 5000)

< autosave.cmd

# Initialize the IOC and start processing records
iocInit()
create_monitor_set("MDrivePositions.req", 5, "P=$(PREFIX)")
create_monitor_set("MDriveSettings.req", 30, "P=$(PREFIX)")





