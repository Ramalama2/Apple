/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20130117-64 [Jan 19 2013]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of AML/SSDT-SsdtS3.aml, Mon Jan  6 23:23:50 2014
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000032 (50)
 *     Revision         0x01
 *     Checksum         0x53
 *     OEM ID           "Apple"
 *     OEM Table ID     "SsdtS3"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20100915 (537921813)
 */

DefinitionBlock ("AML/SSDT-SsdtS3.aml", "SSDT", 1, "Apple", "SsdtS3", 0x00001000)
{
    Name (_S3, Package (0x03)  // _S3_: S3 System State
    {
        0x05, 
        0x05, 
        0x00
    })
}

