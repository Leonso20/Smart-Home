# This script manages smart home devices using PowerShell

# Connect to smart home hub
$smartHomeHubIP = "192.168.1.100"  # Change this to your smart home hub IP address
$smartHomeHub = New-Object System.Net.Sockets.TcpClient($smartHomeHubIP, 80)

# Define functions to control smart home devices
function TurnOnLight($room) {
    $room = $room.ToLower()
    Write-Host "Turning on light in $room..."
    # Send command to smart home hub to turn on light in specified room
    $lightCommand = "turnOnLight/" + $room
    $byteLightCommand = [System.Text.Encoding]::ASCII.GetBytes($lightCommand)
    $stream = $smartHomeHub.GetStream()
    $stream.Write($byteLightCommand, 0, $byteLightCommand.Length)
}

function TurnOffLight($room) {
    $room = $room.ToLower()
    Write-Host "Turning off light in $room..."
    # Send command to smart home hub to turn off light in specified room
    $lightCommand = "turnOffLight/" + $room
    $byteLightCommand = [System.Text.Encoding]::ASCII.GetBytes($lightCommand)
    $stream = $smartHomeHub.GetStream()
    $stream.Write($byteLightCommand, 0, $byteLightCommand.Length)
}

function SetThermostat($temperature) {
    Write-Host "Setting thermostat to $temperature degrees..."
    # Send command to smart home hub to set thermostat to specified temperature
    $thermostatCommand = "setThermostat/" + $temperature
    $byteThermostatCommand = [System.Text.Encoding]::ASCII.GetBytes($thermostatCommand)
    $stream = $smartHomeHub.GetStream()
    $stream.Write($byteThermostatCommand, 0, $byteThermostatCommand.Length)
}

# Prompt user for input
Write-Host "Welcome to Smart Home Manager"
Write-Host "--------------------------------"
Write-Host "What would you like to do?"
Write-Host "1. Turn on a light"
Write-Host "2. Turn off a light"
Write-Host "3. Set the thermostat"
$option = Read-Host "Enter option number"

# Execute user's choice
switch ($option) {
    1 {
        $room = Read-Host "Enter room name"
        TurnOnLight($room)
    }
    2 {
        $room = Read-Host "Enter room name"
        TurnOffLight($room)
    }
    3 {
        $temperature = Read-Host "Enter temperature"
        SetThermostat($temperature)
    }
    default {
        Write-Host "Invalid option selected"
    }
}

# Close connection to smart home hub
$smartHomeHub.Close()
