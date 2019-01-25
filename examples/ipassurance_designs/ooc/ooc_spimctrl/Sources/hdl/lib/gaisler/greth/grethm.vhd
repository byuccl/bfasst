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
-- Entity: 	grethm
-- File:	grethm.vhd
-- Author:	Jiri Gaisler
-- Description:	Module to select between greth and greth1g
------------------------------------------------------------------------------
library ieee;
library grlib;
library gaisler; 
use ieee.std_logic_1164.all;
use grlib.stdlib.all;
use grlib.amba.all;
library techmap;
use techmap.gencomp.all;
use gaisler.net.all;
use work.config.all;

--generic map(hindex => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG,
--            pindex => 15, paddr => 15, pirq => 12, memtech => memtech,
--            mdcscaler => CPU_FREQ/1000, enable_mdio => 1, fifosize => CFG_ETH_FIFO,
--            nsync => 1, edcl => CFG_DSU_ETH, edclbufsz => CFG_ETH_BUF,
--            macaddrh => CFG_ETH_ENM, macaddrl => CFG_ETH_ENL, phyrstadr => 7,
--            ipaddrh => CFG_ETH_IPM, ipaddrl => CFG_ETH_IPL, giga => CFG_GRETH1G, rmii => 1)

entity grethm is
  generic(  
    --BOARD_FREQ     : integer := 100000;                                -- CLK input frequency in KHz
    --CPU_FREQ       : integer := 100000 * CFG_CLKMUL / CFG_CLKDIV;  -- cpu frequency in KHz
    hindex         : integer := CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG;
    pindex         : integer := 15;
    paddr          : integer := 15;
    pmask          : integer := 16#FFF#;
    pirq           : integer := 12;
    memtech        : integer := CFG_MEMTECH;
    ifg_gap        : integer := 24; 
    attempt_limit  : integer := 16;
    backoff_limit  : integer := 10;
    slot_time      : integer := 128;
    mdcscaler      : integer range 0 to 255 := (100000 * CFG_CLKMUL / CFG_CLKDIV) /1000; 
    enable_mdio    : integer range 0 to 1 := 1;
    fifosize       : integer range 4 to 64 := CFG_ETH_FIFO;
    nsync          : integer range 1 to 2 := 1;
    edcl           : integer range 0 to 3 := CFG_DSU_ETH;
    edclbufsz      : integer range 1 to 64 := CFG_ETH_BUF;
    burstlength    : integer range 4 to 128 := 32;
    macaddrh       : integer := CFG_ETH_ENM;
    macaddrl       : integer := CFG_ETH_ENL;
    ipaddrh        : integer := CFG_ETH_IPM;
    ipaddrl        : integer := CFG_ETH_IPL;
    phyrstadr      : integer range 0 to 32 := 7;
    rmii           : integer range 0 to 1 := 1;
    sim            : integer range 0 to 1 := 0;
    giga           : integer range 0 to 1  := CFG_GRETH1G;
    oepol          : integer range 0 to 1  := 0;
    scanen         : integer range 0 to 1  := 0;
    ft             : integer range 0 to 2  := 0;
    edclft         : integer range 0 to 2  := 0;
    mdint_pol      : integer range 0 to 1  := 0;
    enable_mdint   : integer range 0 to 1  := 0;
    multicast      : integer range 0 to 1  := 0;
    ramdebug       : integer range 0 to 2  := 0;
    mdiohold       : integer := 1;
    maxsize        : integer := 1500;
    gmiimode       : integer range 0 to 1  := 0
    );
  port(
    rst            : in  std_ulogic;
    clk            : in  std_ulogic;
    ahbmi          : in  ahb_mst_in_type;
    ahbmo          : out ahb_mst_out_type;
    apbi           : in  apb_slv_in_type;
    apbo           : out apb_slv_out_type;
    ethi           : in  eth_in_type;
    etho           : out eth_out_type
  );
end entity;
  
architecture rtl of grethm is
begin

  m100 : if giga = 0 generate
    u0 : greth
      generic map (
        hindex         => hindex,
        pindex         => pindex,
        paddr          => paddr,
        pmask          => pmask,
        pirq           => pirq,
        memtech        => memtech,
        ifg_gap        => ifg_gap,
        attempt_limit  => attempt_limit,
        backoff_limit  => backoff_limit,
        slot_time      => slot_time,
        mdcscaler      => mdcscaler,
        enable_mdio    => enable_mdio,
        fifosize       => fifosize,
        nsync          => nsync,
        edcl           => edcl,
        edclbufsz      => edclbufsz,
        macaddrh       => macaddrh,
        macaddrl       => macaddrl,
        ipaddrh        => ipaddrh,
        ipaddrl        => ipaddrl,
        phyrstadr      => phyrstadr,
        rmii           => rmii,
        oepol          => oepol,
        scanen         => scanen,
        ft             => ft,
        edclft         => edclft,
        mdint_pol      => mdint_pol,
        enable_mdint   => enable_mdint,
        multicast      => multicast,
        ramdebug       => ramdebug,
        mdiohold       => mdiohold,
        maxsize        => maxsize,
        gmiimode       => gmiimode
        )
      port map (
        rst            => rst,
        clk            => clk,
        ahbmi          => ahbmi,
        ahbmo          => ahbmo,
        apbi           => apbi,
        apbo           => apbo,
        ethi           => ethi,
        etho           => etho);
  end generate;

  m1000 : if giga = 1 generate
    u0 : greth_gbit
      generic map (
        hindex         => hindex,
        pindex         => pindex,
        paddr          => paddr,
        pmask          => pmask,
        pirq           => pirq,
        memtech        => memtech,
        ifg_gap        => ifg_gap,
        attempt_limit  => attempt_limit,
        backoff_limit  => backoff_limit,
        slot_time      => slot_time,
        mdcscaler      => mdcscaler,
        nsync          => nsync,
        edcl           => edcl,
        edclbufsz      => edclbufsz,
        burstlength    => burstlength,
        macaddrh       => macaddrh,
        macaddrl       => macaddrl,
        ipaddrh        => ipaddrh,
        ipaddrl        => ipaddrl,
        phyrstadr      => phyrstadr,
        sim            => sim,
        oepol          => oepol,
        scanen         => scanen,
        ft             => ft,
        edclft         => edclft,
        mdint_pol      => mdint_pol,
        enable_mdint   => enable_mdint,
        multicast      => multicast,
        ramdebug       => ramdebug,
        mdiohold       => mdiohold,
        gmiimode       => gmiimode
        ) 
      port map (
        rst            => rst,
        clk            => clk,
        ahbmi          => ahbmi,
        ahbmo          => ahbmo,
        apbi           => apbi,
        apbo           => apbo,
        ethi           => ethi,
        etho           => etho);
  end generate;

end architecture;

