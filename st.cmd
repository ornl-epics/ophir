#!../../bin/linux-x86_64/Ophir5087

## You may have to change Ophir5087 to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/Ophir5087.dbd"
Ophir5087_registerRecordDeviceDriver pdbbase

drvAsynIPPortConfigure ("OP2","10.112.8.63:23",0,0,0)
drvAsynIPPortConfigure ("OP1","10.112.8.64:23",0,0,0)




asynSetTraceMask("OP1",0,0xFF)
asynSetTraceIOMask("OP1",0,0xFF)





## Load record instances
dbLoadRecords("db/Ophir5087.db")

#######################AUTOSAVE
epicsEnvSet("IOCNAME","bl4a-Ophir5087")
epicsEnvSet("SAVE_DIR","/home/controls/var/$(IOCNAME)")

save_restoreSet_Debug(0)


save_restoreSet_status_prefix("BL4A:SF:OPHIR")

set_requestfile_path("$(SAVE_DIR)")
set_savefile_path("$(SAVE_DIR)")

save_restoreSet_NumSeqFiles(3)
save_restoreSet_SeqPeriodInSeconds(600)
set_pass0_restoreFile("$(IOCNAME).sav")

##################################

cd "${TOP}/iocBoot/${IOC}"
iocInit

#set Set units to VPP for amplitude
dbpf BL4A:SF:OPHIR1:SETVVALEVEL 25
dbpf BL4A:SF:OPHIR2:SETVVALEVEL 85



epicsThreadSleep(5)
makeAutosaveFileFromDbInfo("$(SAVE_DIR)/$(IOCNAME).req", "autosaveFields")
create_monitor_set("$(IOCNAME).req", 5)

