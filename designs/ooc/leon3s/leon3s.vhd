------------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2003 - 2008, Gaisler Research
--  Copyright (C) 2008 - 2014, Aeroflex Gaisler
--  Copyright (C) 2015 - 2017, Cobham Gaisler
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 
-----------------------------------------------------------------------------
-- Entity:      leon3s
-- File:        leon3s.vhd
-- Author:      Jan Andersson, Aeroflex Gaisler
-- Description: Top-level LEON3 component
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
library techmap;
use techmap.gencomp.all;
library gaisler;
use gaisler.leon3.all;
use work.config.all;

  --leon3s_0 : leon3s
  --  generic map (0, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU, CFG_V8,
  --               0, CFG_MAC, pclow, CFG_NOTAG, CFG_NWP, CFG_ICEN, CFG_IREPL, CFG_ISETS, CFG_ILINE,
  --               CFG_ISETSZ, CFG_ILOCK, CFG_DCEN, CFG_DREPL, CFG_DSETS, CFG_DLINE, CFG_DSETSZ,
  --               CFG_DLOCK, CFG_DSNOOP, CFG_ILRAMEN, CFG_ILRAMSZ, CFG_ILRAMADDR, CFG_DLRAMEN,
  --               CFG_DLRAMSZ, CFG_DLRAMADDR, CFG_MMUEN, CFG_ITLBNUM, CFG_DTLBNUM, CFG_TLB_TYPE, CFG_TLB_REP,
  --               CFG_LDDEL, disas, CFG_ITBSZ, CFG_PWD, CFG_SVT, CFG_RSTADDR,
  --               CFG_NCPU-1, CFG_DFIXED, CFG_SCAN, CFG_MMU_PAGE, CFG_BP, CFG_NP_ASI, CFG_WRPSR)
  --  port map (clkm, rstn, ahbmi, ahbmo(0), ahbsi, ahbso, irqi(0), irqo(0), dbgi(0), dbgo(0));

entity leon3s is
  generic (
    hindex     :     integer                  := 0;
    fabtech    :     integer range 0 to NTECH := CFG_FABTECH;
    memtech    :     integer                  := CFG_MEMTECH;
    nwindows   :     integer range 2 to 32    := CFG_NWIN;
    dsu        :     integer range 0 to 1     := CFG_DSU;
    fpu        :     integer range 0 to 31    := CFG_FPU;
    v8         :     integer range 0 to 63    := CFG_V8;
    cp         :     integer range 0 to 1     := 0;
    mac        :     integer range 0 to 1     := CFG_MAC;
    pclow      :     integer range 0 to 2     := CFG_PCLOW;
    notag      :     integer range 0 to 1     := CFG_NOTAG;
    nwp        :     integer range 0 to 4     := CFG_NWP;
    icen       :     integer range 0 to 1     := CFG_ICEN;
    irepl      :     integer range 0 to 3     := CFG_IREPL;
    isets      :     integer range 1 to 4     := CFG_ISETS;
    ilinesize  :     integer range 4 to 8     := CFG_ILINE;
    isetsize   :     integer range 1 to 256   := CFG_ISETSZ;
    isetlock   :     integer range 0 to 1     := CFG_ILOCK;
    dcen       :     integer range 0 to 1     := CFG_DCEN;
    drepl      :     integer range 0 to 3     := CFG_DREPL;
    dsets      :     integer range 1 to 4     := CFG_DSETS;
    dlinesize  :     integer range 4 to 8     := CFG_DLINE;
    dsetsize   :     integer range 1 to 256   := CFG_DSETSZ;
    dsetlock   :     integer range 0 to 1     := CFG_DLOCK;
    dsnoop     :     integer range 0 to 6     := CFG_DSNOOP;
    ilram      :     integer range 0 to 1     := CFG_ILRAMEN;
    ilramsize  :     integer range 1 to 512   := CFG_ILRAMSZ;
    ilramstart :     integer range 0 to 255   := CFG_ILRAMADDR;
    dlram      :     integer range 0 to 1     := CFG_DLRAMEN;
    dlramsize  :     integer range 1 to 512   := CFG_DLRAMSZ;
    dlramstart :     integer range 0 to 255   := CFG_DLRAMADDR;
    mmuen      :     integer range 0 to 1     := CFG_MMUEN;
    itlbnum    :     integer range 2 to 64    := CFG_ITLBNUM;
    dtlbnum    :     integer range 2 to 64    := CFG_DTLBNUM;
    tlb_type   :     integer range 0 to 3     := CFG_TLB_TYPE;
    tlb_rep    :     integer range 0 to 1     := CFG_TLB_REP;
    lddel      :     integer range 1 to 2     := CFG_LDDEL;
    disas      :     integer range 0 to 2     := CFG_DISAS;
    tbuf       :     integer range 0 to 128    := CFG_ITBSZ;
    pwd        :     integer range 0 to 2     := CFG_PWD;
    svt        :     integer range 0 to 1     := CFG_SVT;
    rstaddr    :     integer                  := CFG_RSTADDR;
    smp        :     integer range 0 to 15    := CFG_NCPU-1;
    cached     :     integer                  := CFG_DFIXED;
    scantest   :     integer                  := CFG_SCAN;
    mmupgsz    :     integer range 0 to 5     := CFG_MMU_PAGE;
    bp         :     integer                  := CFG_BP;
    npasi      :     integer range 0 to 1     := CFG_NP_ASI;
    pwrpsr     :     integer range 0 to 1     := CFG_WRPSR;
    rex        :     integer range 0 to 1     := 0;
    altwin     :     integer range 0 to 1     := 0
    );
  port (
    clk        : in  std_ulogic;
    rstn       : in  std_ulogic;
    ahbi       : in  ahb_mst_in_type;
    ahbo       : out ahb_mst_out_type;
    ahbsi      : in  ahb_slv_in_type;
    ahbso      : in  ahb_slv_out_vector;
    irqi       : in  l3_irq_in_type;
    irqo       : out l3_irq_out_type;
    dbgi       : in  l3_debug_in_type;
    dbgo       : out l3_debug_out_type
    );
end;

architecture rtl of leon3s is

  signal gnd, vcc : std_logic;
  signal fpuo     : grfpu_out_type;

begin

  gnd  <= '0'; vcc <= '1';
  fpuo <= grfpu_out_none;

  leon3x0 : leon3x
    generic map (
      hindex     => hindex,
      fabtech    => fabtech,
      memtech    => memtech,
      nwindows   => nwindows,
      dsu        => dsu,
      fpu        => fpu,
      v8         => v8,
      cp         => cp,
      mac        => mac,
      pclow      => pclow,
      notag      => notag,
      nwp        => nwp,
      icen       => icen,
      irepl      => irepl,
      isets      => isets,
      ilinesize  => ilinesize,
      isetsize   => isetsize,
      isetlock   => isetlock,
      dcen       => dcen,
      drepl      => drepl,
      dsets      => dsets,
      dlinesize  => dlinesize,
      dsetsize   => dsetsize,
      dsetlock   => dsetlock,
      dsnoop     => dsnoop,
      ilram      => ilram,
      ilramsize  => ilramsize,
      ilramstart => ilramstart,
      dlram      => dlram,
      dlramsize  => dlramsize,
      dlramstart => dlramstart,
      mmuen      => mmuen,
      itlbnum    => itlbnum,
      dtlbnum    => dtlbnum,
      tlb_type   => tlb_type,
      tlb_rep    => tlb_rep,
      lddel      => lddel,
      disas      => disas,
      tbuf       => tbuf,
      pwd        => pwd,
      svt        => svt,
      rstaddr    => rstaddr,
      smp        => smp,
      iuft       => 0,
      fpft       => 0,
      cmft       => 0,
      iuinj      => 0,
      ceinj      => 0,
      cached     => cached,
      clk2x      => 0,
      netlist    => 0,
      scantest   => scantest,
      mmupgsz    => mmupgsz,
      bp         => bp,
      npasi      => npasi,
      pwrpsr     => pwrpsr,
      rex        => rex,
      altwin     => altwin)
    port map (
      clk        => gnd,
      gclk2      => clk,
      gfclk2     => clk,
      clk2       => clk,
      rstn       => rstn,
      ahbi       => ahbi,
      ahbo       => ahbo,
      ahbsi      => ahbsi,
      ahbso      => ahbso,
      irqi       => irqi,
      irqo       => irqo,
      dbgi       => dbgi,
      dbgo       => dbgo,
      fpui       => open,
      fpuo       => fpuo,
      clken      => vcc
      );

end;

