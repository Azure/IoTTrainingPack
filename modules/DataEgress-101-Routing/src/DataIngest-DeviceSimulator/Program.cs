using Microsoft.Azure.Devices.Client;
using System.Text; 
using System.Text.Json; 

using var deviceClient = DeviceClient.CreateFromConnectionString(args[0]);

string telemetryData = JsonSerializer.Serialize(
    new {
        DeviceId = "device01",
        TelemetryId = Guid.NewGuid(),
        DeviceCategory = "MultiSensor",
        Pressure = 15.7,
        EnergyConsumption = 20.7,
        TelemetryTimeStamp = DateTime.UtcNow
    }
);

for (int i=0; i<21; i++) {
    var message = new Message(Encoding.ASCII.GetBytes(telemetryData)) {
        ContentType = "application/json",
        ContentEncoding = "utf-8"
    };
    message.Properties.Add("Error", "No");
    await deviceClient.SendEventAsync(message, new CancellationToken());
};








