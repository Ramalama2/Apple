/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20130117-64 [Jan 19 2013]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of AML/SSDT-Cpu0Cst.aml, Mon Jan  6 22:30:12 2014
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000004F0 (1264)
 *     Revision         0x01
 *     Checksum         0xA2
 *     OEM ID           "PmRef"
 *     OEM Table ID     "Cpu0Cst"
 *     OEM Revision     0x00003001 (12289)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20100915 (537921813)
 */

DefinitionBlock ("AML/SSDT-Cpu0Cst.aml", "SSDT", 1, "PmRef", "Cpu0Cst", 0x00003001)
{
    External (_PR_.CPU0, DeviceObj)
    External (C3LT, IntObj)
    External (C3MW, IntObj)
    External (C6LT, IntObj)
    External (C6MW, IntObj)
    External (C7LT, IntObj)
    External (C7MW, IntObj)
    External (CDLT, IntObj)
    External (CDLV, IntObj)
    External (CDMW, IntObj)
    External (CDPW, IntObj)
    External (CFGD)
    External (PDC0)

    Scope (\_PR.CPU0)
    {
        Name (C1TM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            0x01, 
            0x01, 
            0x03E8
        })
        Name (C3TM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x08,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000414, // Address
                    ,)
            }, 

            0x02, 
            0x00, 
            0x01F4
        })
        Name (C6TM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x08,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000415, // Address
                    ,)
            }, 

            0x02, 
            0x00, 
            0x015E
        })
        Name (C7TM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x08,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000416, // Address
                    ,)
            }, 

            0x02, 
            0x00, 
            0xC8
        })
        Name (CDTM, Package (0x04)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x08,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000416, // Address
                    ,)
            }, 

            0x03, 
            0x00, 
            0x00
        })
        Name (MWES, ResourceTemplate ()
        {
            Register (FFixedHW, 
                0x01,               // Bit Width
                0x02,               // Bit Offset
                0x0000000000000000, // Address
                0x01,               // Access Size
                )
        })
        Name (AC2V, 0x00)
        Name (AC3V, 0x00)
        Name (C3ST, Package (0x04)
        {
            0x03, 
            Package (0x00) {}, 
            Package (0x00) {}, 
            Package (0x00) {}
        })
        Name (C2ST, Package (0x03)
        {
            0x02, 
            Package (0x00) {}, 
            Package (0x00) {}
        })
        Name (C1ST, Package (0x02)
        {
            0x01, 
            Package (0x00) {}
        })
        Name (CSTF, 0x00)
        Name (GEAR, 0x00)
        Method (_CST, 0, Serialized)  // _CST: C-States
        {
            If (LNot (CSTF))
            {
                Store (C3LT, Index (C3TM, 0x02))
                Store (C6LT, Index (C6TM, 0x02))
                Store (C7LT, Index (C7TM, 0x02))
                Store (CDLT, Index (CDTM, 0x02))
                Store (CDPW, Index (CDTM, 0x03))
                Store (CDLV, Index (DerefOf (Index (CDTM, 0x00)), 0x07))
                If (LAnd (And (CFGD, 0x0800), And (PDC0, 0x0200)))
                {
                    Store (MWES, Index (C1TM, 0x00))
                    Store (MWES, Index (C3TM, 0x00))
                    Store (MWES, Index (C6TM, 0x00))
                    Store (MWES, Index (C7TM, 0x00))
                    Store (MWES, Index (CDTM, 0x00))
                    Store (C3MW, Index (DerefOf (Index (C3TM, 0x00)), 0x07))
                    Store (C6MW, Index (DerefOf (Index (C6TM, 0x00)), 0x07))
                    Store (C7MW, Index (DerefOf (Index (C7TM, 0x00)), 0x07))
                    Store (CDMW, Index (DerefOf (Index (CDTM, 0x00)), 0x07))
                }
                Else
                {
                    If (LAnd (And (CFGD, 0x0800), And (PDC0, 0x0100)))
                    {
                        Store (MWES, Index (C1TM, 0x00))
                    }
                }

                Store (Ones, CSTF)
            }

            Store (Zero, AC2V)
            Store (Zero, AC3V)
            Store (C1TM, Index (C3ST, 0x01))
            If (And (CFGD, 0x20))
            {
                Store (C7TM, Index (C3ST, 0x02))
                Store (Ones, AC2V)
            }
            Else
            {
                If (And (CFGD, 0x10))
                {
                    Store (C6TM, Index (C3ST, 0x02))
                    Store (Ones, AC2V)
                }
                Else
                {
                    If (And (CFGD, 0x08))
                    {
                        Store (C3TM, Index (C3ST, 0x02))
                        Store (Ones, AC2V)
                    }
                }
            }

            If (And (CFGD, 0x4000))
            {
                Store (CDTM, Index (C3ST, 0x03))
                Store (Ones, AC3V)
            }

            If (LEqual (GEAR, 0x01))
            {
                If (And (CFGD, 0x08))
                {
                    Store (C3TM, Index (C3ST, 0x02))
                    Store (Ones, AC2V)
                    Store (Zero, AC3V)
                }
                Else
                {
                    Store (Zero, AC2V)
                    Store (Zero, AC3V)
                }
            }

            If (LEqual (GEAR, 0x02))
            {
                Store (Zero, AC2V)
                Store (Zero, AC3V)
            }

            If (LAnd (AC2V, AC3V))
            {
                Return (C3ST)
            }
            Else
            {
                If (AC2V)
                {
                    Store (DerefOf (Index (C3ST, 0x01)), Index (C2ST, 0x01))
                    Store (DerefOf (Index (C3ST, 0x02)), Index (C2ST, 0x02))
                    Return (C2ST)
                }
                Else
                {
                    If (AC3V)
                    {
                        Store (DerefOf (Index (C3ST, 0x01)), Index (C2ST, 0x01))
                        Store (DerefOf (Index (C3ST, 0x03)), Index (C2ST, 0x02))
                        Store (0x02, Index (DerefOf (Index (C2ST, 0x02)), 0x01))
                        Return (C2ST)
                    }
                    Else
                    {
                        Store (DerefOf (Index (C3ST, 0x01)), Index (C1ST, 0x01))
                        Return (C1ST)
                    }
                }
            }
        }

        Method (ACST, 0, NotSerialized)
        {
            If (And (CFGD, 0x20))
            {
                Return (Package (0x06)
                {
                    0x01, 
                    0x04, 
                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000000, // Address
                                0x01,               // Access Size
                                )
                        }, 

                        0x01, 
                        0x03, 
                        0x03E8
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000010, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        0x03, 
                        0xCD, 
                        0x01F4
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000020, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        0x06, 
                        0xF5, 
                        0x015E
                    }, 

                    Package (0x04)
                    {
                        ResourceTemplate ()
                        {
                            Register (FFixedHW, 
                                0x01,               // Bit Width
                                0x02,               // Bit Offset
                                0x0000000000000030, // Address
                                0x03,               // Access Size
                                )
                        }, 

                        0x07, 
                        0xF5, 
                        0xC8
                    }
                })
            }

            Return (Package (0x05)
            {
                0x01, 
                0x03, 
                Package (0x04)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x01,               // Bit Width
                            0x02,               // Bit Offset
                            0x0000000000000000, // Address
                            0x01,               // Access Size
                            )
                    }, 

                    0x01, 
                    0x03, 
                    0x03E8
                }, 

                Package (0x04)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x01,               // Bit Width
                            0x02,               // Bit Offset
                            0x0000000000000010, // Address
                            0x03,               // Access Size
                            )
                    }, 

                    0x03, 
                    0xCD, 
                    0x01F4
                }, 

                Package (0x04)
                {
                    ResourceTemplate ()
                    {
                        Register (FFixedHW, 
                            0x01,               // Bit Width
                            0x02,               // Bit Offset
                            0x0000000000000020, // Address
                            0x03,               // Access Size
                            )
                    }, 

                    0x06, 
                    0xF5, 
                    0x015E
                }
            })
        }
    }
}

