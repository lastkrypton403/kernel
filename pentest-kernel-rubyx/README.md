# 🔐 Pentesting Kernel — rubyx (Redmi Note 12 Pro+ 5G)

NetHunter-style pentesting kernel built via GitHub Actions, targeting the  
**Xiaomi Redmi Note 12 Pro+ 5G / Discovery (codename: rubyx, MT6877 / Dimensity 1080)**.

---

## Features

| Capability | Notes |
|---|---|
| Full Netfilter / iptables / nftables | All match & target extensions |
| USB Gadget HID — BadUSB | Keyboard/mouse emulation via `/dev/hidg0` |
| USB Gadget RNDIS / ECM / NCM | USB networking (Windows / Linux / Mac hosts) |
| USB FunctionFS | Custom userspace gadgets |
| Loadable kernel modules | Out-of-tree drivers supported |
| Packet socket / raw capture | `tcpdump`, `hcxdumptool`, `scapy` |
| WireGuard (built-in) | No module needed |
| IPSec / IKEv2 (XFRM) | For `strongSwan`, `libreswan` |
| OpenVPN / PPTP / L2TP | TUN, PPP, L2TP all enabled |
| cfg80211 / mac80211 | Full Wi-Fi stack with WEXT compat |
| **RTL8812AU** (out-of-tree) | Monitor mode + injection — external USB adapter |
| Atheros ath9k_htc — AR9271 | TP-Link WN722N v1 |
| MT7601U / MT7612U (mt76) | Alfa AWUS036ACM and similar |
| RT2800USB — Ralink family | Many cheap USB adapters |
| Bluetooth RFCOMM / HID / BNEP | + USB BT dongle support |

---

## Repo structure

```
.
├── .github/
│   └── workflows/
│       └── build-kernel.yml   ← GitHub Actions workflow
├── pentesting.config           ← Kconfig fragment (merged on top of rubyx_defconfig)
├── anykernel.sh                ← AnyKernel3 device config
└── README.md
```

---

## How to build

### Option A — GitHub Actions (recommended)

1. Fork / create a repo with these files on GitHub.
2. Go to **Actions → Build Pentesting Kernel → Run workflow**.
3. Choose the crDroid branch (e.g. `15.0` for Android 15).
4. Optionally tick **Create GitHub Release**.
5. Download the ZIP from the **Artifacts** section when done (~30–50 min).

### Option B — Triggered on push to `main`

Just push a commit. The workflow runs automatically.

---

## Flash instructions

1. Boot into **TWRP** (or any recovery that supports AnyKernel3).
2. Flash `PentestKernel-rubyx-*.zip`.
3. Wipe **cache + dalvik**.
4. Reboot.

> Tested with crDroid 11.x (Android 15) and crDroid 10.x (Android 14).  
> KernelSU Next is recommended for root; Magisk also works.

---

## External USB Wi-Fi adapters (for monitor mode + injection)

The stock MT6877 Wi-Fi chip does **not** support monitor mode or packet injection.  
You need a USB adapter via OTG. Tested-compatible chipsets:

| Chipset | Example adapter | Driver |
|---|---|---|
| RTL8812AU | Alfa AWUS036ACH, TP-Link Archer T4U | `rtl8812au` (out-of-tree, built automatically) |
| AR9271 | TP-Link WN722N **v1 only** | `ath9k_htc` (in-tree) |
| MT7612U | Alfa AWUS036ACM | `mt76x2u` (in-tree) |
| MT7601U | Many cheap no-name adapters | `mt7601u` (in-tree) |

---

## Troubleshooting

**`rubyx_defconfig` not found**  
The defconfig name may differ across branches. Check:
```bash
ls kernel/arch/arm64/configs/ | grep -i ruby
```
Update the `DEFCONFIG` env var in the workflow accordingly.

**RTL8812AU build fails**  
This is non-fatal — the workflow continues without it. Check the step log.  
The in-tree drivers (AR9271, MT76, RT2800) will still be present.

**Build exceeds GitHub free tier**  
Public repos get unlimited free Actions minutes. Private repos have a 2000 min/month cap.

---

> ⚠️ For authorized security testing and educational use only.
