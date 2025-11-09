"""List unencrypted Xilinx IPs in the Vivado installation directory."""

import pathlib
import re

VIVADO_PATH = pathlib.Path("/tools/Xilinx/Vivado/2022.2")

IP_PATH = VIVADO_PATH / "data" / "ip" / "xilinx"

total_num_ip = len(list(IP_PATH.iterdir()))


def main():
    """Main function to list unencrypted Xilinx IPs."""
    unencrypted_ips = []

    for ip in IP_PATH.iterdir():
        # ERASE_LINE = '\x1b[2K';
        # print(f"{ERASE_LINE}\r{i} of {total_num_ip}: {ip}", end="",flush=True)

        if not (ip / "hdl").exists():
            continue

        encrypted = False

        # Iterate through all files in the IP directory that end in .v, .sv, .vhd
        for file in (ip / "hdl").rglob("*"):
            if file.is_dir():
                continue
            if file.name == "emc_common_v3_0_vh_rfs.vhd":
                # This file is not encrypted, but as a non-utf-8 character
                continue
            if file.suffix not in (".v", ".sv", ".vhd"):
                continue

            txt = file.read_text(encoding="utf-8", errors="replace")

            # Check if a line starts with `pragma protect
            if re.search("^`pragma protect", txt, re.MULTILINE) or re.search(
                "^`protect", txt, re.MULTILINE
            ):
                # print(f"\n{file} contains encrypted IP    ")
                encrypted = True
                break

        if not encrypted:
            unencrypted_ips.append(ip)

    unencrypted_ips.sort()

    for ip in unencrypted_ips:
        print(ip)

    print(f"{total_num_ip} IPs found in {IP_PATH}")
    print(f"{len(unencrypted_ips)} of these are unencrypted")


if __name__ == "__main__":
    main()
