#!/bin/env python3

#
# This script is intended to be run with python 3
#

import time
import os
import re
import subprocess
import functools

voltage_raws = []

voltage_differential_raws = []

voltage_scales = [ "in_voltage-voltage_scale" ]

hw_gain = [ "hardwaregain" ]

hw_gain_available = [ hw_gain[0] + "_available" ]

calib_bias = [ "calibbias" ]

calib_bias_available = [ calib_bias[0] + "_available" ]

calib_scale = [ "calibscale" ]

calib_scale_available = [ calib_scale[0] + "_available" ]

oversampling_ratio = [ "oversampling_ratio" ]

oversampling_ratio_available = [ oversampling_ratio[0] + "_available" ]
temperature_raws = [ "in_temp_raw" ]

temperature_scale = [ "in_temp_scale" ]

DIR_PATH="/sys/bus/iio/devices/"
device = []
mcp_devices = []

device2channels ={}


new_line = '\n'

def mult(file1_name, file2_name):
    global ABS_PATH
    file1 = open(ABS_PATH+file1_name,'r')
    val1 = int(file1.read())
    file1.close()
    file2 = open(ABS_PATH+file2_name,'r')
    val2 = float(file2.read())
    file2.close()
    return (val1 * val2)


def print_attribute(file_name):
    global ABS_PATH
    attr_file = open(ABS_PATH + file_name,'r')
    string = attr_file.read()
    attr_file.close()
    # clean the string for printing
    string = string.replace("0000000", "")
    return string

def calculate_temperature(file1_name):
    global ABS_PATH

    name_file = open(ABS_PATH + "name",'r')
    device_name_string = name_file.read()
    name_file.close()

    temperature = open(ABS_PATH+file1_name,'r')
    temperature_val = int(temperature.read())
    temperature.close()

    if ( 'mcp3564\n' == device_name_string ):
        return temperature_val * 4.0096 * 0.0001 * 2.4 - 269.13
    else:
        return 0

def write_attribute(file_name, value):
    global ABS_PATH
    attr_file = open(ABS_PATH + file_name,'w')
    attr_file.write(value)
    attr_file.close()
    return 0

def get_name(file_name):
    global ABS_PATH
    attr_file = open(file_name,'r')
    string = attr_file.read()
    attr_file.close()
    return string




if not os.path.isdir(DIR_PATH):
    print('IIO is not enabled')
    exit()

proc = subprocess.Popen("ls -1 " + DIR_PATH + "| grep device", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr =  proc.communicate()

lines = stdout.decode('utf-8').split('\n')

print('Search for devices:')
for line in lines:
    path=DIR_PATH + line
    if os.path.exists(path):
        if os.path.exists(path + "/name"):
            device_name= get_name(path + "/name")

            print('------------->', device_name)

            if re.search(r"mcp3[45]6[124][rR]", device_name):
                device_index = re.findall(r'\d+', line)
                if device_index:
                    mcp_devices.append(device_index[0])

                    # get voltage_raws*
                    proc_channels = subprocess.Popen("ls -1 " + path + "/ | grep in_voltage* | grep -v scale | grep -v \"-\"", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    stdout_channels, stderr_channels =  proc_channels.communicate()
                    voltage_raws = stdout_channels.decode('utf-8').split('\n')
                    voltage_raws = voltage_raws[:-1]

                    # get voltage_differential_raws
                    proc_channels = subprocess.Popen("ls -1 " + path + "/ | grep in_voltage* | grep -v scale | grep \"-\"", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    stdout_channels, stderr_channels =  proc_channels.communicate()
                    voltage_differential_raws = stdout_channels.decode('utf-8').split('\n')
                    voltage_differential_raws = voltage_differential_raws[:-1]


for mcp_device in mcp_devices:
    ABS_PATH = f'{DIR_PATH}iio:device{mcp_device}/'

    print('--------------------------------')
    print('--------------------------------')
    print('--------------------------------')
    print(f'Device:  {print_attribute("name")}')
    print('--------------------------------')

    print(f'Available Voltage Oversampling Ratio:')
    oversampling_ratio_string = print_attribute(oversampling_ratio_available[0])
    oversampling_ratio_list = oversampling_ratio_string.split()
    print(f'    {oversampling_ratio_string}')

    print('--------------------------------')
    print(f'Current Voltage Oversampling Ratio:  %s' % (print_attribute(oversampling_ratio[0])))
    print('--------------------------------')

    print(f'Available Voltage Hardware Gain:')
    hw_gain_string = print_attribute(hw_gain_available[0])
    hw_gain_list = hw_gain_string.split()
    print(f'    {hw_gain_string}')

    print('--------------------------------')
    print(f'Current Voltage Hardware Gain:  %s' % (print_attribute(hw_gain[0])))
    print('--------------------------------')

    print(f'Available Voltage Calibration Bias {new_line} [    Low, Step, High  ] {new_line}  %s' % (print_attribute(calib_bias_available[0]).replace(" ", "  ")))

    print('--------------------------------')
    print(f'Current Voltage Calibration Bias:  %s' % (print_attribute(calib_bias[0])))
    print('--------------------------------')

    print(f'Available Voltage Calibration Scale {new_line}  [ Low, Step, High  ] {new_line}  %s' % (print_attribute(calib_scale_available[0]).replace(" ", "    ")))

    print('--------------------------------')
    print(f'Current Voltage Calibration Scale:  %s' % (print_attribute(calib_scale[0])))
    print('--------------------------------')

    print('--------------------------------')
    # Measured voltage in millivolts
    # U = in2_raw * in_scale

    print('\n Voltage')
    print('=========')

    print(f'      Channel             V              mV')
    for raw in voltage_raws:
        # Voltage Scale is in mV
        voltage_mv = mult(raw,voltage_scales[0])
        voltage = voltage_mv/1000
        print('---------------------------------------------------------------------')
        print(f'    {raw}:    %2.4f   |   %5.6f' % (voltage, voltage_mv))

    print('\n\n--------------------------------')


    print('\n Differential Voltage')
    print('======================')

    print(f'            Channel                   V                   mV')
    for raw in voltage_differential_raws:
        # Voltage Scale is in mV
        voltage_mv = mult(raw,voltage_scales[0])
        voltage = voltage_mv/1000
        print('---------------------------------------------------------------------')
        print(f'    {raw}:    %8.4f     |  %15.6f' % (voltage, voltage_mv))

    print('\n\n--------------------------------')
    print('\n\n Temperature(',u'\xb0\x43','): %8.4f' % calculate_temperature(temperature_raws[0]))
    print('\n\n--------------------------------')

    if os.geteuid()==0:
        print('\n\n================================')
        print ('Running as root.')
        print('================================\n\n')

        # Testing Hardware Gain
        current_hw_gain = print_attribute(hw_gain[0])
        print(f'   Current Voltage Hardware Gain:    x{current_hw_gain}')


        print('\n================================')
        print(f'   Testing Hardware gain settings: {hw_gain_string}')
        print('================================\n')
        print('--------------------------------')

        for hw_gain_value in hw_gain_list:
            print(f' {new_line} Set Voltage Hardware Gain: x{hw_gain_value}')

            write_attribute(hw_gain[0], hw_gain_value)

            print(f'      Channel                       V              mV')
            voltage_mv = mult(voltage_differential_raws[0], voltage_scales[0])
            voltage = voltage_mv/1000
            print('---------------------------------------------------------------------')
            print(f'    {voltage_differential_raws[0]}:    %2.4f   |   %5.6f   -> Hw Gain: x%s' % (voltage, voltage_mv, print_attribute(hw_gain[0])))
            print('---------------------------------------------------------------------------------------------------------------------')

        # set back the Hardware Gain
        write_attribute(hw_gain[0], current_hw_gain)
        print('--------------------------------')

        # Testing Oversampling Ratio
        current_oversampling_ratio = print_attribute(oversampling_ratio[0])
        print(f'   Current Oversampling Ratio:    x{current_oversampling_ratio}')

        print(f' {new_line}')
        print('\n================================')
        print(f'   Testing Oversampling Ratio settings: {oversampling_ratio_string}')
        print('================================\n')
        print('--------------------------------')

        for oversampling_ratio_value in oversampling_ratio_list:
            print(f' {new_line} Set Oversampling Ratio: x{oversampling_ratio_value}')

            write_attribute(oversampling_ratio[0], oversampling_ratio_value)

            print(f'      Channel                       V              mV')
            voltage_mv = mult(voltage_differential_raws[0], voltage_scales[0])
            voltage = voltage_mv/1000
            print('---------------------------------------------------------------------')
            print(f'    {voltage_differential_raws[0]}:    %2.4f   |   %5.6f   -> Oversampling Ratio: x%s' % (voltage, voltage_mv, print_attribute(oversampling_ratio[0])))
            print('---------------------------------------------------------------------------------------------------------------------')

        # set back the Oversampling Ratio
        write_attribute(oversampling_ratio[0], current_oversampling_ratio)
        print('\n--------------------------------')

        # Testing Calibration BIAS
        current_calib_bias = print_attribute(calib_bias[0])
        print(f'{new_line}   Current Calibration BIAS:    {current_calib_bias}')

        print('\n\n================================')
        print(f'   Testing Calibration Bias settings')
        print('================================\n')
        print('--------------------------------\n')

        calib_bias_value = "50000"
        print(f' {new_line} Set Calibration BIAS: {calib_bias_value}')

        write_attribute(calib_bias[0], calib_bias_value)

        print(f'      Channel                       V              mV')
        voltage_mv = mult(voltage_differential_raws[0], voltage_scales[0])
        voltage = voltage_mv/1000
        print('---------------------------------------------------------------------')
        print(f'    {voltage_differential_raws[0]}:    %2.4f   |   %5.6f   -> Calibration BIAS: %s' % (voltage, voltage_mv, print_attribute(calib_bias[0])))
        print('---------------------------------------------------------------------------------------------------------------------')

        # set back the Calibration Bias
        write_attribute(calib_bias[0], "0")
        print('\n--------------------------------')

        # Testing Calibration Scale
        calib_scale_x1_gain = 8388608

        current_calib_scale = print_attribute(calib_scale[0])
        print(f'{new_line}   Current Calibration Scale:    {int(current_calib_scale)/calib_scale_x1_gain}')

        print('\n\n================================')
        print(f'   Testing Calibration Scale settings')
        print('================================\n')
        print('--------------------------------')

        calib_scale_value = 4194304;
        print(f' {new_line} Set Calibration Scale: {calib_scale_value/calib_scale_x1_gain}')

        write_attribute(calib_scale[0], str(calib_scale_value))

        print(f'      Channel                       V              mV')
        voltage_mv = mult(voltage_differential_raws[0], voltage_scales[0])
        voltage = voltage_mv/1000
        print('---------------------------------------------------------------------')
        calib_scale_string = print_attribute(calib_scale[0])
        calib_scale_int = int(calib_scale_string)
        print(f'    {voltage_differential_raws[0]}:    %2.4f   |   %5.6f   -> Calibration Scale: x%2.6f' % (voltage, voltage_mv, calib_scale_int/calib_scale_x1_gain))
        print('*********************************************************************************************************************')
        print('*********************************************************************************************************************')
        print('*********************************************************************************************************************')

        # set back the Calibration Scale
        write_attribute(calib_scale[0], str(calib_scale_x1_gain))

    else:
        print ('User is not root.\n')
        print ('Changing the user configurable settings must by done by root user.\n')