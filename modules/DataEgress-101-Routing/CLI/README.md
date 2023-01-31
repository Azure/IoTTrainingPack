# Create, test and configure IoT Hub Message Routing

## Steps to setup demo environment and test Azure IoT Hub Routing

[Azure Command Line Interface script](./CreateEnv-TestEnv.azcli)

### Basic Setup

- ***Step 1***: Logon to Azure; Retrieve and store Azure default subscription id.
- ***Step 2***: Define a random number or unifier to ensure unique naming (as much as possible)
- ***Step 3***: Create resource group where all resources will be deployed/created to
- ***Step 4***: Create Azure IoT Hub and Azure IoT Hub device
- ***Step 5***: Create Azure Storage Account and Storage Account Container to route IoT Hub messages to

### IoT Hub Endpoint & IoT Hub Route

- ***Step 6***: Create IoT Hub Endpoint which links to a Azure Blob Storage Account
- ***Step 7***: Create IoT Hub Route without query to filter messages sent to IoT Hub. All incoming messages will be batched and stored in a file in the Storage Account Container created in Step 5.

    ```Powershell
    $hubStorageEndpointBatchFrequency = "60"
    $hubStorageEndpointChunkSize = "10"
    ```

    ***$hubStorageEnpointBatchFrequency***: defines the frequency when incoming messages will be persisted to a file. In the above example at least all 60 seconds a file will be created.

    ***$hubStorageEndpointChunkSize***: defines after how many processed messaged they will be persisted in a file.

### Test IoT Hub Endpoint & IoT Hub Route

- ***Step 8***: The Azure CLI command:

    ```Powershell
    az iot device send-d2c-message
    ```

    will be used to simulate a device and send the simulated data to IoT Hub following this layout:

    ```Powershell
    $telemetryDataTemplate = '
    {
        "DeviceId": "@@DeviceId@@", 
        "DeviceCategory": "MultiSensor", 
        "TelemetryId": "@@TelemetryId",
        "Pressure": 15.7, 
        "EnergyConsumption": 20.7, 
        "TelemetryTimeStamp": "@@TelemetryTimeStamp@@"
    }'
    ```

- ***Step 9***: A test to see if Azure IoT Hub Endpoint and Azure IoT Hub Routing was successful. If files are returned routing and endpoint have been successfully defined.

    Please be patient and wait for the configured BatchFrequency until files in the Azure Blob Storage Container will be visible.

### Enrich incoming messages with data from the Azure Device Twin

- ***Step 10***: Incoming messages will be enriched with values stored in the device specific Devive Twin. Therefore a the device twin will be updated with:
  - DepartmentID = dep01
  - CostCenter = cost01
Both values belong to the object Ownership of the device specific twin.

    ```Powershell
    $hubDeviceDesiredProp = "{'Ownership': {'DepartmentId': 'dep01', 'CostCenter': 'cost01'}}"
    ```

- ***Step 11***: Create message enrichment in Azure IoT Hub for DepartmentId and CostCenter
- ***Step 12***: Test message enrichment by sending test data to IoT Hub using the Azure CLI
- ***Step 13***: Logon to the Azure portal and navigate to the created storage account container and check the enriched test data stored in the latest created file(s). Please be patient and wait for the configured BatchFrequency until files in the Azure Blob Storage Container will be visible.

### Route IoT Hub messages based on message properties

- ***Step 14***: Update already defined message route and add  

    ```Powershell
    --condition = "Error = 'No'" 
    ```

    This will instruct IoT Hub to check the properties (not the message body) for a key value pair where Error equals 'No'. If the condition is matched the message will be routed to the defined endpoint.

- ***Step 15***: Test configured route query. The argument ***props*** of *az iot hub device send-d2c-message* ensures that the key value pair "Error = 'No'" will be added to every message. The value of $telemetryProperty is set in Step 8.

    ```Powershell
        az iot device send-d2c-message `
        --hub-name $hubName `
        --device-id $hubDeviceId `
        --props $telemetryProperty `
        --data $telemetryData 
    ```

- ***Step 16***: Logon to the Azure portal and navigate to the created storage account container and check the enriched test data stored in the latest created file(s). Please be patient and wait for the configured BatchFrequency until files in the Azure Blob Storage Container will be visible.

### Route IoT Hub Messages based on values of the message body

- ***Step 17***: Update already configured IoT Hub route and add the query or condition: 

    ```Powershell
    --condition "$body.DeviceCategory = 'MultiSensor'"
    ```

    *$body* indicates that IoT Hub must look into the message to check for matches.

- ***Step 18***: Send test data using 

     ```Powershell
        az iot device send-d2c-message `
        --hub-name $hubName `
        --device-id $hubDeviceId `
        --props $telemetryProperty `
        --data $telemetryData 
    ```

    The message template: 

    ```Powershell
    $telemetryDataTemplate = '
    {
        "DeviceId": "@@DeviceId@@", 
        "DeviceCategory": "MultiSensor", 
        "TelemetryId": "@@TelemetryId",
        "Pressure": 15.7, 
        "EnergyConsumption": 20.7, 
        "TelemetryTimeStamp": "@@TelemetryTimeStamp@@"
    }'
    ```

    ensures that "DeviceCategory" is set to "MultiSensor" and therefore matches the new route query.

- ***Step 19***: Logon to the Azure portal and navigate to the created storage account container and check the enriched test data stored in the latest created file(s). Please be patient and wait for the configured BatchFrequency until files in the Azure Blob Storage Container will be visible.

    ***ATTENTION:***: you will not see the test data routed to the configured endpoint. Even if the message contains the queried information! The data will be routed by IoT Hub to the built-in endpoint.

    The reason is that IoT Hub wasn't able to check the message body because the data must be flagged and sent as "utf-8". The Azure CLI command ```az iot device send-d2c-message``` doesn't support at the point in time when this repo was created the possibility to flag/encode data as utf-8 encoded.

- ***Step 20***: Send test data using the [.net app](../src/DataIngest-DeviceSimulator/) DataIngest-DeviceSimulator.csproj. Messages sent to IoT Hub are utf-8 encoded.

    ```Powershell
    var message = new Message(Encoding.ASCII.GetBytes(telemetryData)) {
        ContentType = "application/json",
        ContentEncoding = "utf-8"
    };
    ```

- ***Step 21***: Logon to the Azure portal and navigate to the created storage account container and check the enriched test data stored in the latest created file(s). Please be patient and wait for the configured BatchFrequency until files in the Azure Blob Storage Container will be visible.  
