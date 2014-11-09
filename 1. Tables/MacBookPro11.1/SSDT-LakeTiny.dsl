/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20130117-64 [Jan 19 2013]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of AML/SSDT-LakeTiny.aml, Mon Jan  6 23:23:50 2014
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000001D5 (469)
 *     Revision         0x01
 *     Checksum         0x8F
 *     OEM ID           "PmRef"
 *     OEM Table ID     "LakeTiny"
 *     OEM Revision     0x00003000 (12288)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20100915 (537921813)
 */

DefinitionBlock ("AML/SSDT-LakeTiny.aml", "SSDT", 1, "PmRef", "LakeTiny", 0x00003000)
{
    External (_PR_.CPU0.GEAR, IntObj)
    External (_SB_.PCI0.SAT0, DeviceObj)
    External (_SB_.PCI0.SAT1, DeviceObj)
    External (MPMF)
    External (PNOT, MethodObj)    // 0 Arguments

    Scope (\_SB.PCI0.SAT0)
    {
        Method (SLT1, 0, Serialized)
        {
            If (CondRefOf (\_PR.CPU0.GEAR))
            {
                Store (0x00, \_PR.CPU0.GEAR)
                \PNOT ()
            }

            Return (0x00)
        }

        Method (SLT2, 0, Serialized)
        {
            If (CondRefOf (\_PR.CPU0.GEAR))
            {
                Store (0x01, \_PR.CPU0.GEAR)
                \PNOT ()
            }

            Return (0x00)
        }

        Method (SLT3, 0, Serialized)
        {
            If (CondRefOf (\_PR.CPU0.GEAR))
            {
                Store (0x02, \_PR.CPU0.GEAR)
                \PNOT ()
            }

            Return (0x00)
        }

        Method (GLTS, 0, Serialized)
        {
            Store (\_PR.CPU0.GEAR, Local0)
            ShiftLeft (Local0, 0x01, Local0)
            Or (Local0, 0x01, Local0)
            Return (Local0)
        }
    }

    Scope (\_SB.PCI0.SAT1)
    {
        Method (SLT1, 0, Serialized)
        {
            If (CondRefOf (\_PR.CPU0.GEAR))
            {
                Store (0x00, \_PR.CPU0.GEAR)
                \PNOT ()
            }

            Return (0x00)
        }

        Method (SLT2, 0, Serialized)
        {
            If (CondRefOf (\_PR.CPU0.GEAR))
            {
                Store (0x01, \_PR.CPU0.GEAR)
                \PNOT ()
            }

            Return (0x00)
        }

        Method (SLT3, 0, Serialized)
        {
            If (CondRefOf (\_PR.CPU0.GEAR))
            {
                Store (0x02, \_PR.CPU0.GEAR)
                \PNOT ()
            }

            Return (0x00)
        }

        Method (GLTS, 0, Serialized)
        {
            Store (\_PR.CPU0.GEAR, Local0)
            ShiftLeft (Local0, 0x01, Local0)
            And (MPMF, 0x01, Local1)
            Or (Local0, Local1, Local0)
            Return (Local0)
        }
    }
}

