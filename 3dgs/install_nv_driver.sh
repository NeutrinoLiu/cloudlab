#!/bin/bash

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run this script with sudo"
    exit 1
fi

# Update package information
echo "Updating package information..."
apt update

# Install required packages
echo "Installing required packages..."
apt install -y ubuntu-drivers-common pciutils

# Check if NVIDIA GPU is present
if ! lspci | grep -i nvidia > /dev/null; then
    echo "No NVIDIA GPU detected on this system"
    exit 1
fi

# Get recommended driver
echo "Detecting recommended NVIDIA driver..."
RECOMMENDED_DRIVER=$(ubuntu-drivers devices | grep "recommended" | awk '{print $3}')

if [ -z "$RECOMMENDED_DRIVER" ]; then
    echo "No recommended NVIDIA driver found"
    echo "Available drivers are:"
    ubuntu-drivers devices | grep "nvidia-driver"
    exit 1
fi

echo "Recommended NVIDIA driver is: $RECOMMENDED_DRIVER"

# Ask for confirmation
read -p "Do you want to install the recommended driver? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled"
    exit 1
fi

# Install the recommended driver
echo "Installing NVIDIA driver: $RECOMMENDED_DRIVER"
apt install -y $RECOMMENDED_DRIVER

echo "Installation complete. Please reboot your system to load the new driver."
