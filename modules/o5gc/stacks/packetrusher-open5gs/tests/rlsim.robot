*** Settings ***
Documentation   PacketRusher 5G SA with Open5GS core, radio link simulation
Test Tags       Emulated  packetrusher  open5gs
Resource        ../../../../../tests/common.resource
Suite Setup     Setup Stack
Suite Teardown  Teardown Stack


*** Variables ***
${STACK}          packetrusher-open5gs
${UE_TYPE}        packetrusher
${CORE_TYPE}      open5gs
# PacketRusher runs the gNB and the UE in a single container
${UE_CONTAINER}   gnb-ue
@{CONTAINERS}     upf  smf  amf  nrf  ausf  udr  udm  pcf  bsf  nssf  scp  pcrf  gnb-ue
@{FILES_TO_SAVE}  gnb-ue:/o5gc/PacketRusher/config/config.yml


*** Test Cases ***
Verify Successful Startup
    Containers Should Be Running  @{CONTAINERS}
    No Running Container Should Be  unhealthy
    No Running Container Should Be  starting
    No Container Should Be Failed

Verify UE Is Registered At AMF
    UE Should Be Registered At AMF

Verify UE Connectivity
    UE Should Reach The Internet

Verify PDU Session Establishment At SMF
    SMF Log Should Contain PDU Session Setup
