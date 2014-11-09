/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20130117-64 [Jan 19 2013]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of AML/SSDT-SaHdaCdc.aml, Mon Jan  6 22:30:26 2014
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000003E0 (992)
 *     Revision         0x01
 *     Checksum         0xEC
 *     OEM ID           "Apple"
 *     OEM Table ID     "SaHdaCdc"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20100915 (537921813)
 */

DefinitionBlock ("AML/SSDT-SaHdaCdc.aml", "SSDT", 1, "Apple", "SaHdaCdc", 0x00001000)
{
    External (_SB_.PCI0, DeviceObj)
    External (AUDA, IntObj)
    External (AUDB, IntObj)
    External (AUDC, IntObj)
    External (BBAR, MethodObj)    // 1 Arguments
    External (CADR, IntObj)
    External (CCNT)
    External (DTGP, MethodObj)    // 4 Arguments

    Scope (\_SB.PCI0)
    {
        Device (HDAU)
        {
            Name (_ADR, 0x00030000)  // _ADR: Address
            OperationRegion (HDAH, PCI_Config, 0x00, 0x40)
            Field (HDAH, ByteAcc, NoLock, Preserve)
            {
                VID0,   16, 
                DID0,   16, 
                Offset (0x10), 
                ABAR,   32
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (LNotEqual (VID0, 0xFFFF))
                {
                    Return (0x0F)
                }

                Return (0x00)
            }

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (LEqual (Arg0, Buffer (0x10)
                        {
                            /* 0000 */   0xC6, 0xB7, 0xB5, 0xA0, 0x18, 0x13, 0x1C, 0x44,
                            /* 0008 */   0xB0, 0xC9, 0xFE, 0x69, 0x5E, 0xAF, 0x94, 0x9B
                        }))
                {
                    If (LNotEqual (And (VID0, 0xFFFF), 0xFFFF))
                    {
                        Store (Package (0x02)
                            {
                                "hda-gfx", 
                                Buffer (0x0A)
                                {
                                    "onboard-1"
                                }
                            }, Local0)
                        DTGP (Arg0, Arg1, Arg2, Arg3)
                        RefOf (Local0)
                        Return (Local0)
                    }
                }

                Return (0x80000002)
            }

            Method (ASTR, 0, Serialized)
            {
                If (LAnd (LNotEqual (ABAR, 0xFFFFFFFF), LNotEqual (And (ABAR, 
                    0xFFFFC000), 0x00)))
                {
                    And (ABAR, 0xFFFFFFF0, BBAR)
                    Add (BBAR (0x1000), BBAR (OperationRegion (RPCY, SystemMemory, BBAR (0x25), Field (RPCY, DWordAcc, NoLock, Preserve)
                                {
                                    Offset (0x0C), 
                                    EM4W,   32, 
                                    EMWA,   32, 
                                    Offset (0x1C), 
                                    ADWA,   32
                                })), Store (AUDA, EMWA))
                    Store (AUDB, ADWA)
                    Store (AUDC, EM4W)
                }
            }

            Method (VSTR, 1, Serialized)
            {
                Name (CONT, 0x03E8)
                Name (ADDR, 0x80000000)
                Store (Arg0, ADDR)
                OperationRegion (CCDC, SystemMemory, ADDR, 0x04)
                Field (CCDC, ByteAcc, NoLock, Preserve)
                {
                    CDEC,   32
                }

                If (LAnd (LNotEqual (ABAR, 0xFFFFFFFF), LNotEqual (And (ABAR, 
                    0xFFFFC000), 0x00)))
                {
                    If (LNotEqual (CDEC, 0x00))
                    {
                        And (ABAR, 0xFFFFFFF0, BBAR)
                        OperationRegion (IPCV, SystemMemory, BBAR (0x70), Field (IPCV, DWordAcc, NoLock, Preserve)
                            {
                                Offset (0x60), 
                                AVIC,   32, 
                                Offset (0x68), 
                                AIRS,   16
                            })
                        Store (0x03E8, CONT)
                        While (LAnd (LEqual (And (AIRS, 0x01), 0x01), LNotEqual (
                            CONT, 0x00)))
                        {
                            Stall (0x01)
                            Decrement (CONT)
                        }

                        Or (AIRS, 0x02, AIRS)
                        Store (CDEC, AVIC)
                        Or (AIRS, 0x01, AIRS)
                        Store (0x03E8, CONT)
                        While (LAnd (LEqual (And (AIRS, 0x01), 0x01), LNotEqual (
                            CONT, 0x00)))
                        {
                            Stall (0x01)
                            Decrement (CONT)
                        }
                    }
                }
            }

            Method (CXDC, 0, Serialized)
            {
                Name (IDDX, 0x80000000)
                If (LAnd (LNotEqual (CADR, 0x00), LNotEqual (CCNT, 0x00)))
                {
                    Store (CADR, IDDX)
                    While (LLess (IDDX, Add (CADR, Multiply (CCNT, 0x04))))
                    {
                        VSTR (IDDX)
                        Add (IDDX, 0x04, IDDX)
                    }
                }
            }

            Method (AINI, 0, Serialized)
            {
                Name (CONT, 0x03E8)
                If (LAnd (LNotEqual (ABAR, 0xFFFFFFFF), LNotEqual (And (ABAR, 
                    0xFFFFC000), 0x00)))
                {
                    And (ABAR, 0xFFFFFFF0, BBAR)
                    OperationRegion (IPCV, SystemMemory, BBAR (0x70), Field (IPCV, DWordAcc, NoLock, Preserve)
                        {
                            GCAP,   16, 
                            Offset (0x08), 
                            GCTL,   32, 
                            Offset (0x0E), 
                            SSTS,   8, 
                            Offset (0x60), 
                            AVIC,   32, 
                            Offset (0x68), 
                            AIRS,   16
                        })
                    Or (GCTL, 0x01, GCTL)
                    Store (0x03E8, CONT)
                    While (LAnd (LEqual (And (GCTL, 0x01), 0x01), LNotEqual (
                        CONT, 0x00)))
                    {
                        Stall (0x01)
                        Decrement (CONT)
                    }

                    And (GCAP, 0xFFFF, GCAP)
                    Or (SSTS, 0x0F, SSTS)
                    And (GCTL, 0xFFFFFFFE, GCTL)
                    Store (0x03E8, CONT)
                    While (LAnd (LEqual (And (GCTL, 0x01), 0x01), LNotEqual (
                        CONT, 0x00)))
                    {
                        Stall (0x01)
                        Decrement (CONT)
                    }

                    Or (GCTL, 0x01, GCTL)
                    Store (0x03E8, CONT)
                    While (LAnd (LEqual (And (GCTL, 0x01), 0x01), LNotEqual (
                        CONT, 0x00)))
                    {
                        Stall (0x01)
                        Decrement (CONT)
                    }
                }
            }
        }
    }
}

