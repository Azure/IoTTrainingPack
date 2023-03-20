# Create IoT Hub Event Registration

## Retrieve Logic App Webhook Url

Go back to the Resource Group and select the Logic App "LogicAppTaskCreator"
![ResourceGroupView](img/LATaskCreator.png)

Click on ***Edit***
![Edit](img/LAEdit.png)

Copy webhook Url
![WebHookUrl](img/LACopyWebhook.png)

## Configure IoT Hub

Go back to the Resource Group and select the IoT Hub within the Resource Group
![Resource Group](img/LAResourceGroup.png)

Click on ***Events***
![Events](img/LAEvents.png)

Click on ***+ Event Subscription***
![Subscription](img/LAEventSubsription.png)

Provide the following configuration:

- Event Subscription Details Name: IoTHub2EG
- Check if "Event Grid Schema" in EventSchema is selected
- EventTypes: Just select Device Telemetry
  ***Attention***: Take care that nothing else is selected! 
  ![EventType](img/LASubscriptionPara.png)
- Select Webhook as endpoint
- Click ***Please select and endpoint*** and provide Logic App webhook Url:
![Url](img/LAWebHook.png)
- Confirm selection
- Click ***Create***

***Attention***: IoT Hub goes in "Transitioning" state while configuration is applied. It is not reachable for devices or management calls.
