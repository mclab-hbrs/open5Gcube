*** Settings ***
Documentation   srsRAN 4G LTE with srsEPC core, ZMQ RF simulation
Test Tags       Emulated  srsran  srsepc
Resource        ../../../../../tests/common.resource
Suite Setup     Setup Stack
Suite Teardown  Teardown Stack


*** Variables ***
${STACK}          srsran-4g-emu
${UE_TYPE}        srsran
${CORE_TYPE}      srsepc
@{CONTAINERS}     epc  enb  ue
@{FILES_TO_SAVE}  enb:/mnt/srsran/enb.conf


*** Test Cases ***
Verify Successful Startup
    Containers Should Be Running  @{CONTAINERS}
    No Running Container Should Be  unhealthy
    No Running Container Should Be  starting
    No Container Should Be Failed

Verify UE Attaches To EPC
    UE Should Be Registered At AMF

Verify UE Connectivity
    UE Should Reach The Internet

Verify Default Bearer Establishment
    SMF Log Should Contain PDU Session Setup
