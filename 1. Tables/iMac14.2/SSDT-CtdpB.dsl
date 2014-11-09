/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20130117-64 [Jan 19 2013]
 * Copyright (c) 2000 - 2013 Intel Corporation
 * 
 * Disassembly of AML/SSDT-CtdpB.aml, Mon Jan  6 22:29:58 2014
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000042B (1067)
 *     Revision         0x01
 *     Checksum         0x4E
 *     OEM ID           "CtdpB"
 *     OEM Table ID     "CtdpB"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20100915 (537921813)
 */

DefinitionBlock ("AML/SSDT-CtdpB.aml", "SSDT", 1, "CtdpB", "CtdpB", 0x00001000)
{
    External (_PR_.CPU0)
    External (_PR_.CPU0._PPC)
    External (_PR_.CPU0._PSS)
    External (_PR_.CPU1)
    External (_PR_.CPU2)
    External (_PR_.CPU3)
    External (_PR_.CPU4)
    External (_PR_.CPU5)
    External (_PR_.CPU6)
    External (_PR_.CPU7)
    External (_SB_.PCI0, DeviceObj)
    External (MHBR)
    External (PNHM)
    External (TCNT, IntObj)

    Scope (\_SB.PCI0)
    {
        OperationRegion (MBAR, SystemMemory, Add (ShiftLeft (MHBR, 0x0F), 0x5000), 0x1000)
        Field (MBAR, ByteAcc, NoLock, Preserve)
        {
            Offset (0x930), 
            PTDP,   15, 
            Offset (0x932), 
            PMIN,   15, 
            Offset (0x934), 
            PMAX,   15, 
            Offset (0x936), 
            TMAX,   7, 
            Offset (0x938), 
            PWRU,   4, 
            Offset (0x939), 
            EGYU,   5, 
            Offset (0x93A), 
            TIMU,   4, 
            Offset (0x958), 
            Offset (0x95C), 
            LPMS,   1, 
            CTNL,   2, 
            Offset (0x9A0), 
            PPL1,   15, 
            PL1E,   1, 
                ,   1, 
            PL1T,   7, 
            Offset (0x9A4), 
            PPL2,   15, 
            PL2E,   1, 
                ,   1, 
            PL2T,   7, 
            Offset (0xF3C), 
            TARN,   8, 
            Offset (0xF40), 
            PTD1,   15, 
            Offset (0xF42), 
            TAR1,   8, 
            Offset (0xF44), 
            PMX1,   15, 
            Offset (0xF46), 
            PMN1,   15, 
            Offset (0xF48), 
            PTD2,   15, 
            Offset (0xF4A), 
            TAR2,   8, 
            Offset (0xF4C), 
            PMX2,   15, 
            Offset (0xF4E), 
            PMN2,   15, 
            Offset (0xF50), 
            CTCL,   2, 
                ,   29, 
            CLCK,   1, 
            TAR,    8
        }

        Method (CTCU, 0, NotSerialized)
        {
            Store (PTD2, PPL1)
            Store (0x01, PL1E)
            Store (CLC2 (PTD2), PPL2)
            Store (0x01, PL2E)
            SPPC (0x01)
            Subtract (TAR2, 0x01, TAR)
            Store (0x02, CTCL)
        }

        Method (CTCN, 0, NotSerialized)
        {
            If (LEqual (CTCL, 0x01))
            {
                Store (PTDP, PPL1)
                Store (0x01, PL1E)
                Store (CLC2 (PTDP), PPL2)
                Store (0x01, PL2E)
                NPPC (TARN)
                Subtract (TARN, 0x01, TAR)
                Store (0x00, CTCL)
            }
            Else
            {
                If (LEqual (CTCL, 0x02))
                {
                    Store (0x00, CTCL)
                    Subtract (TARN, 0x01, TAR)
                    NPPC (TARN)
                    Store (CLC2 (PTDP), PPL2)
                    Store (0x01, PL2E)
                    Store (PTDP, PPL1)
                    Store (0x01, PL1E)
                }
            }
        }

        Method (CTCD, 0, NotSerialized)
        {
            Store (0x01, CTCL)
            Subtract (TAR1, 0x01, TAR)
            NPPC (TAR1)
            Store (CLC2 (PTD1), PPL2)
            Store (0x01, PL2E)
            Store (PTD1, PPL1)
            Store (0x01, PL1E)
        }

        Method (NPPC, 1, NotSerialized)
        {
            Name (TRAT, 0x00)
            Name (PRAT, 0x00)
            Name (TMPI, 0x00)
            Store (Arg0, TRAT)
            Store (SizeOf (\_PR.CPU0._PSS), TMPI)
            While (LNotEqual (TMPI, 0x00))
            {
                Decrement (TMPI)
                Store (DerefOf (Index (DerefOf (Index (\_PR.CPU0._PSS, TMPI)), 0x04)), 
                    PRAT)
                ShiftRight (PRAT, 0x08, PRAT)
                If (LGreaterEqual (PRAT, TRAT))
                {
                    SPPC (TMPI)
                    Break
                }
            }
        }

        Method (SPPC, 1, Serialized)
        {
            Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
            Store (Arg0, \_PR.CPU0._PPC)
            While (One)
            {
                Store (TCNT, _T_0)
                If (LEqual (_T_0, 0x08))
                {
                    Notify (\_PR.CPU0, 0x80)
                    Notify (\_PR.CPU1, 0x80)
                    Notify (\_PR.CPU2, 0x80)
                    Notify (\_PR.CPU3, 0x80)
                    Notify (\_PR.CPU4, 0x80)
                    Notify (\_PR.CPU5, 0x80)
                    Notify (\_PR.CPU6, 0x80)
                    Notify (\_PR.CPU7, 0x80)
                }
                Else
                {
                    If (LEqual (_T_0, 0x04))
                    {
                        Notify (\_PR.CPU0, 0x80)
                        Notify (\_PR.CPU1, 0x80)
                        Notify (\_PR.CPU2, 0x80)
                        Notify (\_PR.CPU3, 0x80)
                    }
                    Else
                    {
                        If (LEqual (_T_0, 0x02))
                        {
                            Notify (\_PR.CPU0, 0x80)
                            Notify (\_PR.CPU1, 0x80)
                        }
                        Else
                        {
                            Notify (\_PR.CPU0, 0x80)
                        }
                    }
                }

                Break
            }
        }

        Method (CLC2, 1, Serialized)
        {
            Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
            And (PNHM, 0x0FFF0FF0, Local0)
            While (One)
            {
                Store (Local0, _T_0)
                If (LEqual (_T_0, 0x000306C0))
                {
                    Return (Divide (Multiply (Arg0, 0x05), 0x04, ))
                }
                Else
                {
                    If (LEqual (_T_0, 0x00040650))
                    {
                        Return (Multiply (0x19, 0x08))
                    }
                    Else
                    {
                        Return (Divide (Multiply (Arg0, 0x05), 0x04, ))
                    }
                }

                Break
            }
        }
    }
}

