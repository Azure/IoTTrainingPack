using Microsoft.Azure.Devices.Client;
using System.Text; 
using System.Text.Json; 

using var deviceClient = DeviceClient.CreateFromConnectionString(args[0]);
string deviceId = args[1]; 
float energyConsumption = 5; 
int sequence = 0; 

for (int i=0; i<21; i++) {
    string telemetryData = JsonSerializer.Serialize
    (
        new {
            DeviceId = deviceId,
            TelemetryId = Guid.NewGuid(),
            DeviceCategory = "MultiSensor",
            Pressure = 15.7,
            EnergyConsumption = energyConsumption ++,
            TelemetryTimeStamp = DateTime.UtcNow, 
            Sequence = sequence ++
        }
    );

    var message = new Message(Encoding.ASCII.GetBytes(telemetryData)) {
        ContentType = "application/json",
        ContentEncoding = "utf-8"
    };
    message.Properties.Add("Error", "No");
    await deviceClient.SendEventAsync(message, new CancellationToken());
};

await deviceClient.CloseAsync(); 







