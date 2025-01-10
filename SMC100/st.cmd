#errlogInit(5000)
< envPaths
# Tell EPICS all about the record types, device-support modules, drivers,
# etc.
dbLoadDatabase("../../dbd/iocxxxLinux.dbd")
iocxxxLinux_registerRecordDeviceDriver(pdbbase)
epicsEnvSet("P", "BL62:SMC100:")

### Motors
dbLoadTemplate "motor.substitutions"

### Serial port setup
drvAsynIPPortConfigure("serial3", "192.168.0.5:4003 COM",0,0,0)
asynSetOption("serial3",0,"baud",57600)
asynOctetSetInputEos("serial3",0,"\r\n")
asynOctetSetOutputEos("serial3",0,"\r\n")

### Newport SMC100 support
# (driver port, serial port, axis num, ms mov poll, ms idle poll, egu per step)
SMC100CreateController("SMC100_1", "serial3",1, 100, 0, "0.00005")
< autosave.cmd
iocInit

# Save motor positions every 5 seconds
create_monitor_set("auto_positions.req", 5,"P=$(P)")
# Save motor settings every 30 seconds
create_monitor_set("auto_settings.req", 30, "P=$(P)")

